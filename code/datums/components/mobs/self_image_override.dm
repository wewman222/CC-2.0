
/**
 * This mildly unhinged-sounding components allows arbitrarily having a somewhat-automatically-
 * updating 'override' image for one's self. This solves the issue of BYOND only allowing 
 * one override image per atom per client, but, there's a catch.
 *
 * * The API for this isn't laggy, per se, but isn't high-perforamnce either. This is
 *   a lazy component to fulfil a purpose. If you are reading this in the future and
 *   this component is visible on profiler's CPU rankings and it's a problem,
 *   look into proper managed rendering via planes / vis contents / byond intrinsics / 
 *   refactoring this component to be update-event based, not rebuild based.
 * * The reason this is inefficient is because all callbacks are invoked every time
 *   we need an update. This is not great; there's no way to selective-update.
 * * The API to use this is LoadComponent(). Yeah, this isn't amazing.
 * * The hook API uses string keys. This is because I don't really trust featurecoders
 *   with handling raw callback references. Sorry! Strings, at the least, are pooled by
 *   BYOND for you.
 * * One override per atom per client still applies; this can be trampled by misbehaving code
 *   elsewhere, like using alternate appearances that show to self while this is active.
 *   There's nothing I can do about that; having an actually generate alternate-appearance-override
 *   system is the realm of a *massive* atom HUD refactor, which I am not able to do in just 24 hours.
 */
/datum/component/self_image_override
	/// associative list key to /datum/component_self_image_override_entry; lower priority is applied first
	var/list/alter_entries = list()
	/// our rendering image
	var/image/renderer

/datum/component/self_image_override/Initialize()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return

/datum/component/self_image_override/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_COMPILED_OVERLAYS, PROC_REF(on_overlay_update))
	renderer = new
	renderer.loc = parent
	ensure_image_is_on_client()
	update()
	
/datum/component/self_image_override/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_COMPILED_OVERLAYS)
	if(renderer)
		var/mob/mob_parent = parent
		if(mob_parent.client)
			mob_parent.client -= renderer
		renderer.loc = null
		// try not to harddel; byond scans active procs faster.
		var/image/unreferencing = renderer
		renderer = null
		qdel(unreferencing) 

/** 
 * Adds an alteration hook with a given priority.
 * * This hook is ran on every update.
 * * This does **not** trigger an immediate update.
 * * If the key already exists, the old hook will be overwritten.
 * * You are responsible for ensuring the callback is valid for the duration of the alteration's
 *   lifetime on this component. If the callback is invalidated or its delegate is, runtimes
 *   will occur every update and this is very, very bad.
 * * Callback hooks **cannot sleep under any circumstances.** Doing so will blow things up, like
 *   for example the overlay subsystem. This is enforced with an `invoke_no_sleep()`.
 * 
 * @params
 * * key - string key to register hook under
 * * hook - the callback hook, which will be called with (mob/host_mob, mutable_appearance/modifying)
 * * priority - priority to register under; lower runs first.
 */
/datum/component/self_image_override/proc/add_alteration_hook(key, datum/callback/hook, priority)
	ASSERT(isnum(priority))
	ASSERT(istype(hook))
	if(alter_entries[key])
		remove_alteration_hook(key)
	var/datum/component_self_image_override_entry/entry = new(key, hook, priority)
	BINARY_INSERT(entry, alter_entries, /datum/component_self_image_override_entry, entry, priority, COMPARE_KEY)

/datum/component/self_image_override/proc/remove_alteration_hook(key)
	alter_entries -= key
	if(!length(alter_entries))
		addtimer(CALLBACK(src, PROC_REF(auto_gc_if_empty)), 0)
	
/datum/component/self_image_override/proc/auto_gc_if_empty()
	if(!length(alter_entries))
		qdel(src)

/datum/component/self_image_override/proc/on_overlay_update(datum/source)
	PRIVATE_PROC(TRUE)
	SIGNAL_HANDLER
	update()

/datum/component/self_image_override/proc/update()
	if(!renderer)
		return
	var/mob/our_parent_mob = parent
	var/mutable_appearance/mutating = new(our_parent_mob)
	for(var/datum/component_self_image_override_entry/entry as anything in alter_entries)
		// just because i expect featurecoders to use this code this contains a sanity check
		// to make sure the callback's target object
		var/datum/callback/entry_cb = entry.callback
		if(entry_cb.object != GLOBAL_PROC && QDELETED(entry_cb.object))
			alter_entries -= entry
			// if you are seeing this this is **always** incorrect behavior.
			stack_trace("self image override on mob [REF(our_parent_mob)] contained an alter hook callback with key [entry.key] with a callback targeting a qdeleted object [entry_cb.object]")
			continue
		entry_cb.invoke_no_sleep(our_parent_mob, mutating)
	renderer.appearance = mutating

/datum/component/self_image_override/proc/ensure_image_is_on_client()
	// it should not be necessary to trigger this proc too much but most codebases
	// are lazy and just clear images all the time, so, just call this lol
	var/mob/our_parent_mob = parent
	var/client/maybe_client = our_parent_mob.client
	maybe_client?.images |= renderer

/// quite a mouthful
/datum/component_self_image_override_entry
	var/key
	var/datum/callback/callback
	var/priority

/datum/component_self_image_override_entry/New(key, datum/callback/callback, priority)
	src.key = key
	src.callback = callback
	src.priority = priority
