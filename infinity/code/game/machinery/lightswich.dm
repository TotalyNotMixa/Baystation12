/obj/machinery/light_switch/on
	icon_state = "light1"
	on = 1

#define LS_MODE_MANUAL		"Ручной"
#define LS_MODE_ONLY_OFF	"Только выключать"
#define LS_MODE_FULL_AUTO	"Полная автоматика"
/obj/machinery/light_switch
	var/smart = LS_MODE_FULL_AUTO

/obj/machinery/light_switch/examine(mob/user, distance)
	. = ..()
	if(distance)
		to_chat(user, "Режим автоматики: [smart]")

/obj/machinery/light_switch/proc/sync_motionMode()
	if(connected_area)
		for(var/obj/machinery/light_switch/L in connected_area)
			if(L.smart != smart)
				L.smart = smart

/obj/machinery/light_switch/proc/motion_detect(var/force=FALSE, var/atom/movable/detected)
	// Events writes into force - areas... But who cares

	// Furniture, simple_animals - doesn't care
	if(!(ishuman(detected) || istype(detected, /mob/living/exosuit)) && force != TRUE)
		return
	if(!smart in list(LS_MODE_MANUAL, LS_MODE_ONLY_OFF, LS_MODE_FULL_AUTO))
		smart = LS_MODE_FULL_AUTO
	// Regular manual lightswitch
	if(smart == LS_MODE_MANUAL)
		return
	// Smart 1 only turns off light. Turn on it manualy
	if(smart == LS_MODE_ONLY_OFF && !on)
		return
	var/anyoneElse = FALSE
	if((locate(/mob/living/carbon/human) in connected_area) || (locate(/mob/living/exosuit) in connected_area))
		anyoneElse = TRUE
	
	// We won't turn lights off if there other humans presented
	if(!(on ^ anyoneElse))
		return

	if(on)
		addtimer(CALLBACK(src, .proc/set_state, !on), 3 SECONDS)
	else
		set_state(!on)
	//visible_message("Выключатель тихо щелкнул и в[on?"":"ы"]ключился как только [detected.name] [on?"вошел в":"покидает"] помещение.")

/obj/machinery/light_switch/Initialize()
	. = ..()
	if(connected_area)
		GLOB.entered_event.register(connected_area, src, /obj/machinery/light_switch/proc/motion_detect)
		GLOB.exited_event.register(connected_area, src, /obj/machinery/light_switch/proc/motion_detect)
		
/obj/machinery/light_switch/Destroy()
	GLOB.entered_event.unregister(connected_area, src, /obj/machinery/light_switch/proc/motion_detect)
	GLOB.exited_event.unregister(connected_area, src, /obj/machinery/light_switch/proc/motion_detect)
	. = ..()

/obj/machinery/light_switch/verb/configure_motion_detector()
	set name = "Toggle motion sensor"
	set desc = "Adjust lightswitch's motion sensors"
	set category = "Object"
	set src in view(1)

	if(!CanPhysicallyInteract(usr))
		return
	
	var/selection = input(usr, "Установите режим датчика движения", "Mode" , smart) as null|anything in list(LS_MODE_MANUAL, LS_MODE_ONLY_OFF, LS_MODE_FULL_AUTO)
	if(!CanPhysicallyInteract(usr))
		return
	if(selection)
		smart = selection
	visible_message(SPAN_NOTICE("Выключатель мягко мигает, подтверждая что его настройки были изменены"))
	sync_motionMode()

/datum/map/proc/reset_lights_automatics()
	var/selection = LS_MODE_FULL_AUTO
	if(usr)
		selection = input(usr, "Установите режим датчиков движения", "Mode" , LS_MODE_FULL_AUTO) as null|anything in list("Включить свет", "Выключить свет", LS_MODE_MANUAL, LS_MODE_ONLY_OFF, LS_MODE_FULL_AUTO)
		to_chat(usr, SPAN_NOTICE("Консоль издает тихий писк, подтверждая что новые настройки были применены."))
	for(var/obj/machinery/light_switch/ls in SSmachines.machinery)
		if(ls.z in GLOB.using_map.station_levels)
			switch(selection)
				if("Включить свет")
					ls.set_state(1)
					continue
				if("Выключить свет")
					ls.set_state(0)
					continue
				
			if(ls.smart != selection)
				ls.smart = selection
				ls.sync_motionMode()
				ls.visible_message(SPAN_NOTICE("Выключатель мягко мигает, подтверждая что его настройки были изменены"))
				ls.motion_detect(TRUE)

#undef LS_MODE_FULL_AUTO
#undef LS_MODE_ONLY_OFF
#undef LS_MODE_MANUAL
