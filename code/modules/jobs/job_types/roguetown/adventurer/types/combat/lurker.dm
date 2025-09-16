/datum/advclass/lurker
	name = "Feral Soul"
	tutorial = "Those who walk a path that many fear to tread, embracing their innermost instincts."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_NO_CONSTRUCT //artificial constructs do not have the spark of the wild
	outfit = /datum/outfit/job/roguetown/adventurer/lurker
	traits_applied = list(TRAIT_OUTLANDER)
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	classes = list("Wild Lurker" = "You are a mortal who embraces the aspects of nature. A creature one step removed from being little more than a feral beast. Whatever lyfe you lived before is now but a faded memory.")

/obj/item/clothing/suit/roguetown/armor/skin_armor/natural_armor
	slot_flags = null
	name = "natural armor"
	desc = ""
	icon_state = null
	body_parts_covered = FULL_BODY
	body_parts_inherent = FULL_BODY
	armor = ARMOR_NATURAL
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_STAB, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	sewrepair = FALSE
	max_integrity = 600
	item_flags = DROPDEL
	var/next_regen
	var/mob/living/carbon/human/skin_haver


/obj/item/clothing/suit/roguetown/armor/skin_armor/natural_armor/Initialize(mapload)
	. = ..()
	skin_haver = loc
	trait_add(skin_haver)
	START_PROCESSING(SSobj, src)
	return

/obj/item/clothing/suit/roguetown/armor/skin_armor/natural_armor/Destroy()
	trait_remove(skin_haver)
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/suit/roguetown/armor/skin_armor/natural_armor/process()
	if(next_regen > world.time)
		return
	regenerate(skin_haver)
	next_regen = world.time + 30 SECONDS

/obj/item/clothing/suit/roguetown/armor/skin_armor/natural_armor/proc/trait_add(mob/living/user)
	skin_haver = user
	ADD_TRAIT(skin_haver, TRAIT_NATURAL_ARMOR, TRAIT_GENERIC)
	return

/obj/item/clothing/suit/roguetown/armor/skin_armor/natural_armor/proc/trait_remove(mob/living/user)
	skin_haver = user
	REMOVE_TRAIT(skin_haver, TRAIT_NATURAL_ARMOR, TRAIT_GENERIC)
	return

/obj/item/clothing/suit/roguetown/armor/skin_armor/natural_armor/proc/regenerate(mob/living/user)
	//mob wearing the natural armor
	skin_haver = user

	//making sure that the thing wearing the armor is human
	if(!istype(skin_haver))
		return

	//no need to regenerate if armor is already full
	if(obj_integrity >= max_integrity)
		return
	
	//we can't regenerate if we have no nutrition to do it with
	if(skin_haver.nutrition <=0)
		return

	//we can only regenerate 100 points of integrity at a time
	var/regen_amt = min(100, max_integrity - obj_integrity)
	obj_integrity += regen_amt

	 //Every 1 point of integrity is 2 points of hunger
	skin_haver.adjust_nutrition(-regen_amt * 2)

	//some user feed back for regeneration
	if(obj_integrity < max_integrity)
		to_chat(skin_haver, span_smallgreen("You feel your natural protection knitting itself back together..."))
		return
	//letting the owner know it's fully restored
	else
		to_chat(skin_haver, span_green("You feel your natural protection has fully healed!"))
		return

/datum/outfit/job/roguetown/adventurer/lurker/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list("Wild Lurker")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)

		if("Wild Lurker")
			to_chat(H, span_warning("You have embraced your feral instincts. You tread through brush and thicket unimpeded, and hunt as the beasts of Dendor do. Civilization is your anathema, and is to be avoided. For what purpose is the safety of a tavern when you thrive in this wild realm?"))
			head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
			shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedanklets
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			belt = /obj/item/storage/belt/rogue/leather/rope
			beltl = /obj/item/rogueweapon/huntingknife/stoneknife
			//cloak = /obj/item/clothing/cloak/raincloak/furcloak
			//backl = /obj/item/storage/backpack/rogue/satchel
			//backpack_contents = list(
			//	/obj/item/rogueweapon/huntingknife/stoneknife = 1,
			//	/obj/item/rogueweapon/scabbard/sheath = 1
			//	)
			H.cmode_music = 'sound/music/combat_gronn.ogg'
			H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
			H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
			H.adjust_skillrank(/datum/skill/labor/butchering, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
			H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
			ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_STRONGBITE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_WILD_EATER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_AZURENATIVE, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_WOODWALKER, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_FERAL, TRAIT_GENERIC)
			H.change_stat("strength", 4)
			H.change_stat("perception", 3) 
			H.change_stat("constitution", 3)
			H.change_stat("speed", 2)
			H.change_stat("endurance", 4)
			H.change_stat("intelligence", -3) 
			H.skin_armor = new /obj/item/clothing/suit/roguetown/armor/skin_armor/natural_armor(H)
			var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
			var/color_one
			var/color_two
			var/heterochromia
			if(eyes)
				color_one = eyes.eye_color
				color_two = eyes.second_color
				heterochromia = eyes.heterochromia
				eyes.Remove(H,1)
				QDEL_NULL(eyes)
			eyes = new /obj/item/organ/eyes/night_vision/feral
			if(color_one)
				eyes.eye_color = color_one
			if(color_two)
				eyes.second_color = color_two
			if(heterochromia)
				eyes.heterochromia = heterochromia
			eyes.Insert(H)