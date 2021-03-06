
    include('smartcure.lua')
-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','PDT','TPEat')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')

    state.AutoSubMode.value = true

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
	smart_cure_potencies = {['Cure'] = 115, ['Cure II'] = 245, ['Cure III'] = 584, ['Cure IV'] = 1057, ['Cure V'] = 1289, ['Cure VI'] = 1665, ['Curaga'] = 179, ['Curaga II'] = 368, ['Curaga III'] = 745, ['Curaga IV'] = 1331, ['Curaga V'] = 1859}
	smart_overcure_allowance = 0.85
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

	augmented_gear.capes = {}
    augmented_gear.capes.fc = { name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
    augmented_gear.capes.cure = augmented_gear.capes.fc
    augmented_gear.capes.macc_mnd = augmented_gear.capes.fc

	augmented_gear.capes.idle = augmented_gear.capes.fc
	augmented_gear.capes.macc_mnd = augmented_gear.capes.fc
	augmented_gear.capes.cure = augmented_gear.capes.fc
	
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
        main="Oranyan",                -- 7
        sub="Achaq grip",
    	head="Haruspex hat",           --8
    	neck="Cleric's Torque",        --6
    	body="Inyanga jubbah +2",      --14
    	hands="Gendewitha gages +1",   --7
    	left_ring="Lebeche Ring",      --QM 2
        right_ring="Kishar Ring",      --4
    	waist="Witful Belt",           --3
    	legs="Kaykaus Tights",         --6
    	feet="Regal pumps +1",         --5-7
    	back=augmented_gear.capes.idle,--10
    }
		
    sets.precast.FC.DT = set_combine(sets.precast.FC, {})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {}) --waist="Siegel Sash"	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +1"})
    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
        head="Piety cap",
        hands="Gendewitha gages +1", 
        feet="Vanya Clogs",
        right_ear="Nourishing Earring +1",})	
	sets.precast.FC.Cure.DT = set_combine(sets.precast.FC.Cure, {})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +3"}

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
	--sets.DayIdle = {}
	--sets.NightIdle = {back="Umbra Cape"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {}
	sets.Cure_Received = {}
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
        head=augmented_gear.Kaykaus.C.head,
	    body=augmented_gear.Kaykaus.B.body,
        --body="Theophany Briault +2",
	    hands="Theophany Mitts +3",
	    legs="Ebers Pantaloons +1",
	    feet=augmented_gear.Kaykaus.D.feet,
	    neck="Cleric's torque",
	    waist="Cleric's Belt",
	    left_ear="Glorious Earring",
	    right_ear="Nourishing Earring +1",
	    left_ring="Menelaus's Ring",
	    right_ring="Sirona's Ring",
	    back=augmented_gear.capes.cure,
	}
	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {main="Chatoyant Staff",sub="Enki Strap",waist="Hachirin-no-obi"})
	sets.midcast.LightDayCure = set_combine(sets.midcast.LightWeatherCure, {})

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})        
    sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.LightWeatherCure, {})        
    sets.midcast.LightDayCuraga = set_combine(sets.midcast.LightDayCure, {})
		
    sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {body="Ebers Bliaud +1",})
    sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.LightWeatherCure, {body="Ebers Bliaud +1", right_ring="Kuchekula Ring",})
	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.LightDayCure, {body="Ebers Bliaud +1",})
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = set_combine(sets.midcast.Cure, {})		
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-obi"})

	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-obi"})

    sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1"})
    sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-obi"})
    sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-obi"})


    sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-obi"})

	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})

    sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
    sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-obi"})
    sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-obi"})
	

    sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure, {})     
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-obi"})

	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-obi"})

    sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
    sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-obi"})
    sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-obi"})

	sets.midcast.StatusRemoval = {
		main="Yagrush",
	    sub="Sors Shield",
	    body="Ebers Bliaud +1",
	    hands="Theophany Mitts +3",
	    legs="Ebers Pantaloons +1",
	    feet="Healer's Duckbills",
	    left_ear="Orison Earring",
	    left_ring="Sirona's Ring",
	}

	sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        head="Vanya Hood",
        hands="Fanatic gloves",
        legs="Theophany Pantaloons +3",
        feet="Vanya Clogs",
		neck="Malison medallion",
		left_ring="Menelaus's ring",
		right_ring="Haoma's ring",
		back=augmented_gear.capes.fc,
    })

	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's torque"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {
		main="Oranyan",
		sub="Achaq grip",
		head="Telchine cap",
		body="Telchine Chasuble",
		hands="Telchine gloves",
		right_ring="Stikini ring",
		back="Mending Cape",
		waist="Embla Sash",
		legs="Telchine Braconi",
		feet="Theophany duckbills +3",
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",right_ear="Earthcry Earring",waist="Siegel Sash"})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",waist="Emphatikos Rope"})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2", body="Piety Briault +3", hands="Ebers mitts +1",legs="Theophany Pantaloons +3",})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring",feet="Piety Duckbills +1",left_ear="Gifted Earring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring",feet="Piety Duckbills +1",left_ear="Gifted Earring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring",legs="Piety Pantaloons +3",left_ear="Gifted Earring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring",legs="Piety Pantaloons +3",left_ear="Gifted Earring"})
	
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
		main="Beneficus",
		sub="Sors Shield",
		head="Ebers cap +1",
		body="Ebers Bliaud +1",
		hands="Ebers mitts +1",
		legs="Piety Pantaloons +3",
		feet="Orison duckbills +1"
	})

	sets.midcast.Impact = {}
		
	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast['Divine Magic'] = {}
		
	sets.midcast.Holy = {
        main="Oranyan",
        sub="Enki Strap",
        hands="Fanatic gloves",
        legs=augmented_gear.Chironic.macc.legs,
        neck="Sanctity necklace",
        left_ear="Malignance Earring",
        right_ear="Regal Earring",
        right_ring="Acumen Ring",
        waist="Eschan Stone",
    }

	sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = {}

    sets.midcast.Drain.Resistant = {}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {}

	sets.midcast.Stun.Resistant = {}

	sets.midcast['Enfeebling Magic'] = {    
		main="Oranyan",
	    sub="Enki Strap",
	    ammo="Plumose Sachet",
	    head="Inyanga Tiara +2",
	    body="Theophany Briault +2",
	    hands="Inyan. Dastanas +2",
	    legs=augmented_gear.Chironic.macc.legs,
	    feet="Theophany Duckbills +3",
	    neck="Sanctity Necklace",
	    left_ear="Malignance Earring",
	    right_ear="Regal Earring",
	    left_ring="Inyanga Ring",
	    right_ring="Stikini Ring",
	    waist="Ovate Rope",
	    back=augmented_gear.capes.macc_mnd,
	}

	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
		
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
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back="Alaunus's Cape",left_ring="Stikini Ring"})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = set_combine(sets.midcast.Cure, {ammo="Homiliary", 
		head="Inyanga tiara +2", 
		neck="Twilight Torque",
		body="Piety Briault +3", 
		hands="Inyanga Dastanas +2",
		left_ring="Defending Ring",
		right_ring="Inyanga ring",
		back="Alaunus's cape",
		legs="Assiduity pants +1",
		feet="Inyanga Crackows +2"})

	sets.idle.PDT = {}
		
    sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})

	sets.idle.Weak = set_combine(sets.idle, {})

    sets.idle.Town = set_combine(sets.idle, {
        main="Yagrush",
        sub="Sors Shield"
    })

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