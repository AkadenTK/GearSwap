-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','PDT','TPEat')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')

	gear.obi_cure_waist = "Austerity Belt +1"
	gear.obi_cure_back = "Alaunus's Cape"

	gear.obi_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Yamabuki-no-Obi"
	gear.obi_nuke_back = "Toro Cape"

		-- Additional local binds
	--send_command('bind ^` input /ma "Arise" <t>')
	--send_command('bind !` input /ja "Penury" <me>')
	--send_command('bind @` gs c cycle MagicBurstMode')
	--send_command('bind ^@!` gs c toggle AutoCaress')
	--send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	--send_command('bind @backspace input /ma "Aurora Storm" <me>')
	--send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	--send_command('bind !backspace input /ja "Accession" <me>')
	--send_command('bind != input /ja "Sublimation" <me>')
	--send_command('bind ^delete input /ja "Dark Arts" <me>')
	--send_command('bind !delete input /ja "Addendum: Black" <me>')
	--send_command('bind @delete input /ja "Manifestation" <me>')
	--send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	--send_command('bind @\\\\ input /ma "Shellra V" <me>')
	--send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.Capacity={back="Aptitude mantle"}
	-- Weapons sets
	sets.weapons.MeleeWeapons = {main="Izcalli",sub="Ammurapi Shield"}
	sets.weapons.DualWeapons = {main="Izcalli",sub="Nehushtan"}
	
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
    	head="Haruspex hat", 
    	neck="Orison locket",
    	hands="Fanatic Gloves",
    	ring1="Kishar Ring",
    	waist="Witful Belt",
    	legs="Kaykaus Tights",
    	feet="Regal pumps +1",
    	back={ name="Alaunus's Cape", augments={'"Fast Cast"+10',}},
    }
		
    sets.precast.FC.DT = set_combine(sets.precast.FC, {})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {ear1="Nourishing Earring", ear2="Nourishing Earring +1", head="Piety cap",feet="Vanya Clogs"})
	
	sets.precast.FC.Cure.DT = set_combine(sets.precast.FC.Cure, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    --sets.precast.WS['Flash Nova'] = {}

    --sets.precast.WS['Mystic Boon'] = {}

    -- Midcast Sets

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {back="Umbra Cape"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	
	sets.ConserveMP = {}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {}
	
    sets.midcast.FastRecast = {}
		
    -- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	sets.midcast.Cure = {    
		main="Queller Rod",
	    sub="Sors Shield",
	    ammo="Plumose Sachet",
	    head="Vanya Hood",
	    body="Ebers Bliaud",
	    hands="Theo. Mitts +1",
	    legs="Ebers Pantaloons",
	    feet="Vanya Clogs",
	    neck="Phrenic torque",
	    waist="Cleric's Belt",
	    ear1="Glorious Earring",
	    ear2="Nourishing Earring +1",
	    ring1="Sirona's Ring",
	    ring2="Haoma's Ring",
	    back="Mending Cape",
	}
		
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {})

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {main="Chatoyant Staff",sub="Achaq Grip",waist="Korin Obi",back="Twilight Cape"})

	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.LightWeatherCure, {})

	sets.midcast.LightDayCure = set_combine(sets.midcast.LightWeatherCure, {})
		
	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.LightDayCure, {})

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.LightWeatherCure, {})
		
	sets.midcast.LightDayCuraga = set_combine(sets.midcast.LightDayCure, {})

	sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {})
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	sets.midcast.StatusRemoval = {
		main="Queller Rod",
	    sub="Sors Shield",
		head="Ebers Cap",
	    body="Ebers Bliaud",
	    hands="Theo. Mitts +1",
	    legs="Ebers Pantaloons",
	    feet="Healer's Duckbills",
	    ear1="Orison Earring",
	    ring1="Sirona's Ring",
	    }

	sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
		ring1="Ephedra ring",
		ring2="Haoma's ring",
		hands="Fanatic gloves",
		back="Alaunus's Cape",
		legs="Theophany Pantaloons +1",
		feet="Gendewitha Galoshes +1",})


    -- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {
		main="Beneficus",
		sub="Sors Shield",
		head="Telchine cap",
		body="Telchine Chasuble",
		hands="Telchine gloves",
		ring1="Stikini ring",
		back="Mending Cape",
		waist="Cascade Belt",
		legs="Telchine Braconi",
		feet="Theophany duckbills +1",
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Ammurapi Shield",hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2", body="Piety Briault +1", hands="Ebers Mitts",legs="Theophany Pantaloons +1",})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Piety Duckbills +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Piety Duckbills +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaln. +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaln. +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		main="Beneficus",
		sub="Sors Shield",
		head="Ebers cap",
		body="Ebers bliaud",
		hands="Ebers mits",
		legs="Piety Pantaloons +1",
		feet="Orison duckbills +1"
	})

	sets.midcast.Impact = {}
		
	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast['Divine Magic'] = {}
		
	sets.midcast.Holy = {}

	sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = {}

    sets.midcast.Drain.Resistant = {}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {}

	sets.midcast.Stun.Resistant = {}

	sets.midcast['Enfeebling Magic'] = {}

	sets.midcast['Enfeebling Magic'].Resistant = {}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {back="Alaunus's Cape"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back="Alaunus's Cape",ring1="Stikini Ring"})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = set_combine(sets.midcast.Cure, {ammo="Homiliary", body="Piety Briault +1", legs="Assiduity pants +1"})

	sets.idle.PDT = {}
		
    sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})

	sets.idle.Weak = {}

    -- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

    sets.defense.MEVA = {}
		
	-- Gear for specific elemental nukes.
	sets.element.Wind = {main="Marin Staff +1"}
	sets.element.Ice = {main="Ngqoqwanb"}
	sets.element.Earth = {neck="Quanpur Necklace"}

		-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {}

    sets.engaged.Acc = {}

	sets.engaged.DW = {}

    sets.engaged.DW.Acc = {}

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {}

	sets.HPDown = {}

	sets.HPCure = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 6)
    windower.chat.input:schedule(1,'/lockstyleset 5')
end
function user_job_precast(spell, spellMap, eventArgs)
	if state.smartcure and spell.english:lower() == 'cure' then
		state.smartcure = false
		eventArgs.cancel = true
		smartcure_target(spell.target.name)		
	end
	state.smartcure = false
end

function smartcure_target(target)
	local curaga_info = get_best_curaga_info(target)
	if curaga_info and curaga_info.member_count > 1 and curaga_info['avg_missing_hp'] >= 300 then
		-- do curaga

		local curaga_spell = get_curaga_by_info(curaga_info)
		if curaga_spell then
			local downgraded_curaga = downgrade_curaga_by_recast_and_cost(curaga_spell)
			if downgraded_curaga then
				if downgraded_curaga ~= curaga_spell then
					add_to_chat(123,'Alert: Curaga changed due to recast times or MP.')
				end
				send_command('@input /ma "'..downgraded_curaga..'" '..target)
				return
			else
				add_to_chat(123,'Alert: Appropriate Curagas are on cooldown or MP not sufficient.')
			end
		end
	end
	-- do single-target
	local missingHP
	local missingHPP
	if target == player.name then
		missingHP = player.max_hp - player.hp
		missingHPP = 100 - player.hpp
	else
		local ally_member = find_player_in_alliance(target)
		if ally_member == nil then
			local mob = windower.ffxi.get_mob_by_name(target)
			if mob ~= nil then
				missingHPP = 100 - mob.hpp
			end
		else
			missingHP = (ally_member.hp / (ally_member.hpp/100)) - ally_member.hp
			missingHPP = 100 - ally_member.hpp
		end
	end

	add_to_chat(8,'SmartCure: Trying to cure '..target..' for '..tostring(math.floor(missingHP))..' ('..tostring(missingHPP)..'%)')

	local cure_spell = get_cure_by_hp(missingHP, missingHPP)
	if cure_spell then
		add_to_chat(123,'Cure chosen: '..cure_spell)
		local downgraded_cure = downgrade_cure_by_recast_and_cost(cure_spell)
		if downgraded_cure then
			if downgraded_cure ~= cure_spell then
				add_to_chat(8,'Alert: Cure changed due to recast times or MP.')
			end
			send_command('@input /ma "'..downgraded_cure..'" '..target)
		else
			add_to_chat(123,'Abort: Appropriate cures are on cooldown or MP not sufficient.')
		end
	else
		add_to_chat(123,'Abort: SmartCure not necessary.')
	end
end

function get_cure_by_hp(missingHP,missingHPP)
	if missingHP then
		local mod = get_cure_mod()

		-- don't bother casting if missing hpp is too low, unless it's an inordinate amount or total HP is really low
		if missingHPP >= 15 or (missingHP > 400 * mod) or (missingHP / (missingHPP/100) < 1300) then
			if missingHP > 1700 * mod then
				return "Cure VI"
			elseif missingHP > 1300 * mod then
				return "Cure V"
			elseif missingHP > 1000 * mod then
				return "Cure IV"
			else
				return "Cure III"
			end
		end
		return nil
	else
		if missingHPP > 75 then
			return "Cure V"
		elseif missingHPP > 45 then
			return "Cure IV"
		else 
			return	"Cure III"
		end
	end
end

function downgrade_cure_by_recast_and_cost(cure)
	local spell_recasts = windower.ffxi.get_spell_recasts()

	if cure == "Cure VI" and (spell_recasts[6] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		cure = "Cure V"
	end
	if cure == "Cure V" and (spell_recasts[5] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		cure = "Cure IV"
	end
	if cure == "Cure IV" and (spell_recasts[4] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		-- maybe try upgrade?
		cure = "Cure V"
	end
	if cure == "Cure V" and (spell_recasts[5] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		-- nope, fuck.
		cure = "Cure III"
	end
	if cure == "Cure III" and (spell_recasts[3] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		-- maybe try upgrade?
		cure = "Cure IV"
	end
	if cure == "Cure IV" and (spell_recasts[4] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		-- nope, fuck.
		cure = "Cure II"
	end
	if cure == "Cure II" and (spell_recasts[2] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		-- nothing's ready and no MP. Fuck it.
		cure = nil
	end

	return cure
end

function get_curaga_by_info(curaga_info)
	local missingHP = curaga_info['avg_missing_hp']
	if curaga_info['danger_count'] > 2 then
		missingHP = curaga_info['max_missing_hp']
	end
	local mod = get_cure_mod()

	if missingHP > 1750 * mod then
		return "Curaga V"
	elseif missingHP > 1300 * mod then
		return "Curaga IV"
	elseif missingHP > 700 * mod then
		return "Curaga III"
	else
		return "Curaga II"
	end
end

function get_cure_mod()
	local mod = 1
	if world.day_element == 'Light' then
		mod = mod + 0.1
	elseif world.day_element == 'Dark' then
		mod = mod - 0.1
	end
	if world.weather_element == 'Light' then 
		mod = mod + 0.15
	elseif world.weather_element == 'Dark' then 
		mod = mod - 0.15
	end
	add_to_chat(8,'SmartCure: Cure Mod: '..mod)
	return mod
end

function downgrade_curaga_by_recast_and_cost(cure)
	local spell_recasts = windower.ffxi.get_spell_recasts()

	if cure == "Curaga V" and (spell_recasts[11] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		cure = "Curaga IV"
	end
	if cure == "Curaga IV" and (spell_recasts[10] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		cure = "Curaga III"
	end
	if cure == "Curaga III" and (spell_recasts[9] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		-- maybe try upgrade?
		cure = "Curaga IV"
	end
	if cure == "Curaga IV" and (spell_recasts[10] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		-- nope, fuck.
		cure = "Curaga II"
	end
	if cure == "Curaga II" and (spell_recasts[8] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		-- maybe try upgrade?
		cure = "Curaga III"
	end
	if cure == "Curaga III" and (spell_recasts[9] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) then
		-- nope, fuck. Give up
		cure = nil
	end

	return cure
end

function get_best_curaga_info(target)
	local target_info = find_player_in_alliance(target)
	local best_curaga_info
	for i = 1,6 do
		if party[i] then
			local dist = get_dist(target_info.mob, party[i].mob)
			-- ignore any curaga target that doesn't include the specified one
		    if dist <= 10 then 
		    	local curaga_info = get_curaga_info(party[i])
		    	if best_curaga_info == nil or compare_curaga(best_curaga_info, curaga_info) > 0 then
		    		best_curaga_info = curaga_info
		    	end
		    end
		end
	end

	return best_curaga_info
end

function get_dist(mob1, mob2)
	if mob1 == nil or mob2 == nil then
		return 50
	end
	local dx = mob1.x - mob2.x
	local dy = mob1.y - mob2.y
	return math.sqrt((dx^2)+(dy^2))
end

function get_curaga_info(target_info)
	local info = {members = {}, member_count = 0, total_heal = 0, danger_count = 0, avg_missing_hp = 0, max_missing_hp = 0}
	for i = 1,6 do
		local member = party[i]
		if member and get_dist(target_info.mob, member.mob) <= 10 and member.hpp < 90 then
			local member_missing_hp = (member.hp / (member.hpp/100)) - member.hp
			info['total_heal'] = info['total_heal'] + member_missing_hp
			if member.hpp < 65 then 
				info['danger_count'] = info['danger_count'] + 1 
			end
			info['avg_missing_hp'] = (info['avg_missing_hp'] * info['member_count'] + member_missing_hp) / (info['member_count'] + 1)
			info['members'][info['member_count']] = member
			info['member_count'] = info['member_count'] + 1
			if member_missing_hp > info['max_missing_hp'] then 
				info['max_missing_hp'] = member_missing_hp 
			end
		end
	end
	return info
end

function compare_curaga(info1, info2)
	local r = info2['danger_count'] - info1['danger_count']

	if r==0 then
		r = info2['total_heal'] - info1['total_heal']
	end

	return r
end

function user_job_self_command(commandArgs, eventArgs)
    if commandArgs[1]:lower() == 'smartcure' then
		eventArgs.handled = true
		local targetType = commandArgs[2]:lower()

		if targetType == 'me' or (targetType == nil and (player.target.type == 'NONE' or player.target.type == 'SELF')) then
			-- smartcure self if: arg2 is 'me', or arg2 is nil and target = self or none
			smartcure_target(player.name)
		elseif (targetType == 't' or targetType == nil) and player.target.type ~= 'NONE' then
			-- smartcure target if: arg2 is 't' or nil and player.target isn't none
			smartcure_target(player.target.name)
		elseif targetType ~= nil then
			eventArgs.handled = true
			state.smartcure = true
			windower.chat.input('/ma "Cure" <'..targetType..'>')
		else 
			add_to_chat(123,'Abort SmartCure: target invalid.')		
		end
	end
end