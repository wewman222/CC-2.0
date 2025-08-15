/datum/action/sizecode_smallsprite
	name = "Toggle Giant Sprite"
	desc = "Others will always see you as giant"
	button_icon = 'icons/mob/actions/actions_xeno.dmi'
	button_icon_state = "smallqueen"
	background_icon_state = "bg_alien"
	var/small = FALSE

// TODO: this shouldn't be a global proc, I just didn't want to validate the action lifetime
//       and make sure it always cleans up after itself.
/proc/sizecode_impl_self_downsize_hook(mob/host_mob, mutable_appearance/modifying)
	var/matrix/inverse_transform = modifying.transform
	// TODO: put logic for determining what transform is applied here. i just reset it right now.
	inverse_transform = matrix()
	modifying.transform = inverse_transform

/datum/action/sizecode_smallsprite/Remove(mob/M)
	if(small && owner)
		var/datum/component/self_image_override/image_override_handler = owner.GetComponent(/datum/component/self_image_override)
		if(image_override_handler)
			image_override_handler.remove_alteration_hook("sizecode_smallsprite")
			image_override_handler.update()
	return ..()
	
/datum/action/sizecode_smallsprite/Trigger(trigger_flags)
	. = ..()
	if(!owner)
		return

	if(!small)
		var/datum/component/self_image_override/image_override_handler = owner.LoadComponent(/datum/component/self_image_override)
		// execute very early; TODO: define the priority
		image_override_handler.add_alteration_hook("sizecode_smallsprite", CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(sizecode_impl_self_downsize_hook)), -100000)
		image_override_handler.update()
		var/image/I = image(icon = owner.icon, icon_state = owner.icon_state, loc = owner, layer = owner.layer, pixel_x = owner.pixel_x, pixel_y = owner.pixel_y)
		I.override = TRUE
		I.overlays += owner.overlays
		owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic, "smallsprite_sizecode", I)
	else
		var/datum/component/self_image_override/image_override_handler = owner.GetComponent(/datum/component/self_image_override)
		if(image_override_handler)
			image_override_handler.remove_alteration_hook("sizecode_smallsprite")
			image_override_handler.update()

	small = !small
	return TRUE

/obj/effect/proc_holder/spell/self/sizecode_smallsprite
	name = "Small Sprite"
	desc = "!"
	overlay_state = "claws"
	antimagic_allowed = TRUE
	recharge_time = 20 //2 seconds
	ignore_cockblock = TRUE
	var/small = FALSE

/obj/effect/proc_holder/spell/self/sizecode_smallsprite/cast(mob/user = usr)
	. = ..()
	if(!user)
		return

	if(!small)
		var/image/I = image(icon = user.icon, icon_state = user.icon_state, loc = user, layer = user.layer, pixel_x = user.pixel_x, pixel_y = user.pixel_y)
		I.override = TRUE
		I.overlays += user.overlays
		user.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic, "smallsprite_sizecode", I)
		//small_icon = I
	else
		user.remove_alt_appearance("smallsprite_sizecode")

	small = !small
	return TRUE
