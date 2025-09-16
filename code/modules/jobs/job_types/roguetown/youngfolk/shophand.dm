/datum/job/roguetown/shophand
	title = "Shophand"
	flag = SHOPHAND
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)
	advclass_cat_rolls = list(CTAG_SHOPHAND = 20)
	tutorial = "You work the largest store in the Peaks by the grace of the Merchant who has shackled you in service to the Merchant's Guild. You do as you are told and in return are rewarded with meager pay and a roof above your head. With time, perhaps you will one day be more than a glorified servant."
//"You work the largest store in the Peaks by grace of the Merchant who has shackled you to this drudgery. The work of stocking shelves and taking inventory for your employer is mind-numbing and repetitive--but at least you have a roof over your head and comfortable surroundings. With time, perhaps you will one day be more than a glorified servant."
	//outfit = /datum/outfit/job/roguetown/shophand
	display_order = JDO_SHOPHAND
	give_bank_account = TRUE
	min_pq = -10
	max_pq = null
	round_contrib_points = 2

/datum/job/roguetown/shophand/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/guildthug
	name = "Guild Thug"
	tutorial = "You've been hired by the Merchant's Guild to be their brawn. Valued for your strength and little else, you assist the Merchant in hauling heavy goods, or strong arming potential thiefs."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/guildthug
	category_tags = list(CTAG_SHOPHAND)

/datum/outfit/job/roguetown/adventurer/guildthug/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE) 
	H.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	var/weapons = list("Knuckles","Cudgel")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Knuckles")
			beltr = /obj/item/rogueweapon/knuckles/bronzeknuckles
		if("Cudgel")
			beltl = /obj/item/rogueweapon/mace/cudgel
	head = /obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
	backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/rogueweapon/huntingknife = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1,
				/obj/item/storage/keyring/merchant = 1,
				)
	H.change_stat("strength", 2)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 3)
	H.change_stat("intelligence", -1)
	H.grant_language(/datum/language/thievescant)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, "[type]")
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)

/datum/advclass/guildinformant
	name = "Guild Informant"
	tutorial = "You started as a basic street urchin sneaking and stealing as you needed. On one fateful day you chose to steal from the Merchant's Guild, and now find yourself indebted to their service. Now, you serve as their eyes and ears on the streets of the city."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/guildinformant
	category_tags = list(CTAG_SHOPHAND)

/datum/outfit/job/roguetown/adventurer/guildinformant/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE) 
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/mace/cudgel
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	gloves = /obj/item/clothing/gloves/roguetown/fingerless_leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	backpack_contents = list(
				/obj/item/flashlight/flare/torch = 1,
				/obj/item/rogueweapon/huntingknife/idagger/steel = 1,
				/obj/item/rogueweapon/scabbard/sheath = 1,
				/obj/item/storage/keyring/merchant = 1,
				)
	H.change_stat("speed", 3)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("intelligence", 1)
	H.grant_language(/datum/language/thievescant)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, "[type]")
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)

/datum/advclass/hiredservant
	name = "Hired Servant"
	tutorial = "You are an expert courtier, though find yourself in the service to an aristocrat rather than nobility. Your ability to cater to your Merchant's needs are unparalleled."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/hiredservant
	category_tags = list(CTAG_SHOPHAND)

/datum/outfit/job/roguetown/adventurer/hiredservant/pre_equip(mob/living/carbon/human/H)
	..()
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
				/obj/item/kitchen/rollingpin = 1,
				/obj/item/flint = 1,
				/obj/item/cooking/pan = 1,
				/obj/item/reagent_containers/peppermill = 1,
			)
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/merchant
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	r_hand = /obj/item/reagent_containers/glass/bucket/pot
	var/loadouts = list("Maid","Butler")
	var/loadout_choice = input("Choose your attire.") as anything in loadouts
	H.set_blindness(0)
	switch(loadout_choice)
		if("Maid")
			head = /obj/item/clothing/head/roguetown/armingcap
			armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			pants = /obj/item/clothing/under/roguetown/tights/stockings/black
			cloak = /obj/item/clothing/cloak/apron/waist
		if("Butler")
			pants = /obj/item/clothing/under/roguetown/tights/black
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			shoes = /obj/item/clothing/shoes/roguetown/shortboots
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
	H.change_stat("speed", 1)
	H.change_stat("intelligence", 1)
	H.change_stat("perception", 2)
	ADD_TRAIT(H, TRAIT_CICERONE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, "[type]")
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)

//The original version of the shophand
/datum/advclass/shoplackey
	name = "Shop Lackey"
	tutorial = "You were once a beggar on the street struggling to find your next meal. The Merchant's Guild offered you a roof in exchange for your labor. Now you find yourself as little more than an indentured servant to the Merchant and their whims."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/shoplackey
	category_tags = list(CTAG_SHOPHAND)

/datum/outfit/job/roguetown/adventurer/shoplackey/pre_equip(mob/living/carbon/human/H)
	..()
	var/loadouts = list("Shirt","Dress")
	var/loadout_choice = input("Choose your attire.") as anything in loadouts
	H.set_blindness(0)
	switch(loadout_choice)
		if("Dress")
			pants = /obj/item/clothing/under/roguetown/tights
			armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/blue
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/storage/keyring/merchant
			backr = /obj/item/storage/backpack/rogue/satchel
		if("Shirt")
			pants = /obj/item/clothing/under/roguetown/tights
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
			belt = /obj/item/storage/belt/rogue/leather
			beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
			beltl = /obj/item/storage/keyring/merchant
			backr = /obj/item/storage/backpack/rogue/satchel
	//worse skills than a normal peasant, generally, with random bad combat skill
	H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.change_stat("speed", 1)
	H.change_stat("intelligence", 1)
	H.change_stat("fortune", 1)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, "[type]")
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/appraise/secular)
	if(prob(33))
		H.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
	else if(prob(33))
		H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	else //the legendary shopARM
		H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		H.change_stat("strength", 1)