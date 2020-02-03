/datum/job/assistant
	title = "Crewman"
	total_positions = 12
	spawn_positions = 12
	department = "Civilian"
	department_flag = CIV
	supervisors = "the Head of Personnel"
	selection_color = "#515151"
//	economic_power = 6
	announced = FALSE
	alt_titles = list(
		"Journalist" = /decl/hierarchy/outfit/job/sierra/passenger/passenger/journalist,
		"Historian",
		"Botanist",
		"Naturalist",
		"Ecologist",
		"Sociologist",
		"Off-Duty",
		"Trainer"
		)
	outfit_type = /decl/hierarchy/outfit/job/sierra/passenger/passenger
	allowed_branches = list(/datum/mil_branch/employee, /datum/mil_branch/contractor, /datum/mil_branch/civilian)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ,
		/datum/mil_rank/civ/offduty,
		/datum/mil_rank/civ/nt
	)

/datum/job/assistant/get_description_blurb()
	return "�� - ������... ���, �� ������� ����, ���� �� ��� ������������. �� ��� �� ���� ���������� ������� � ������. \
	�� ������ �������� ����������� ����� � ���������� ����� ���� �������, ��� �� �������� � ����, ���� ��� �� \
	������� ������ � ������ �������. �������� ������������ � ����� ������������� - ��������, ���������� ������� \
	������ ������������ �������, ����� ��� ���������� ����� ������, ����������� ������ ����������� � ��� ��� \
	������ ��������� ������� ������������... � ��������, ���� ����������� � ����������."

/datum/job/cyborg
	total_positions = 3
	spawn_positions = 3
	supervisors = "your laws"

/datum/job/merchant
	title = "Merchant"
	department = "Civilian"
	department_flag = CIV

	total_positions = 1
	spawn_positions = 1
	supervisors = "the invisible hand of the market"
	selection_color = "#515151"
	ideal_character_age = 30
	minimal_player_age = 7
	create_record = 0
	outfit_type = /decl/hierarchy/outfit/job/sierra/merchant/leader
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/civ)
	latejoin_at_spawnpoints = 1

	access = list(access_merchant, access_merchant_leader)
	minimal_access = list()

	announced = FALSE
	min_skill = list(	SKILL_FINANCE = SKILL_ADEPT,
						SKILL_PILOT	  = SKILL_BASIC)
	skill_points = 24

/datum/job/merchant/equip(var/mob/living/carbon/human/H)
	to_chat(H, "���� ����� ������� ��� ������ � ������, ��� ������� �������� �������... ����� ���������������� �����������:")
	to_chat(H, "<b>������� �����</b>: <span class='danger'>[syndicate_code_phrase]</span>")
	to_chat(H, "<b>������ �� �����</b>: <span class='danger'>[syndicate_code_response]</span>")
	H.StoreMemory("<b>Code Phrase</b>: [syndicate_code_phrase]", /decl/memory_options/system)
	H.StoreMemory("<b>Code Response</b>: [syndicate_code_response]", /decl/memory_options/system)
	return ..()

/datum/job/merchant_trainee
	title = "Merchant Assistant"
	department = "Civilian"
	department_flag = CIV

	total_positions = 2
	spawn_positions = 2
	supervisors = "the Merchant"
	selection_color = "#515151"
	ideal_character_age = 20
	minimal_player_age = 0
	create_record = 0
	alt_titles = list(
		"Merchant Security" = /decl/hierarchy/outfit/job/sierra/merchant/security)
	outfit_type = /decl/hierarchy/outfit/job/sierra/merchant
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/civ)
	latejoin_at_spawnpoints = 1
	access = list(access_merchant)
	announced = FALSE
	min_skill = list(   SKILL_FINANCE = SKILL_BASIC)

	max_skill = list(   SKILL_COMBAT  = SKILL_MAX,
	                    SKILL_WEAPONS = SKILL_MAX)
	required_role = list("Merchant")

	skill_points = 24
/*
/datum/job/stowaway
	title = "Stowaway"
	department = "Civilian"
	department_flag = CIV

	total_positions = 2
	spawn_positions = 2
	supervisors = "yourself"
	selection_color = "#515151"
	ideal_character_age = 30
	minimal_player_age = 7
	create_record = 0
	account_allowed = 0
	outfit_type = /decl/hierarchy/outfit/job/sierra/stowaway
	allowed_branches = list(/datum/mil_branch/civilian)
	allowed_ranks = list(/datum/mil_rank/civ/civ)
	latejoin_at_spawnpoints = 1
	announced = FALSE

	access = list(access_maint_tunnels, access_emergency_storage)
	minimal_access = list()
*/