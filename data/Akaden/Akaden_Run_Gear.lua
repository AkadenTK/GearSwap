function user_setup()

	state.OffenseMode:options('Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.HybridMode:options('Normal','DTLite','Tank', 'TankLite')
	state.WeaponskillMode:options('Match','Normal','Acc','FullAcc')
	state.CastingMode:options('Normal','SIRD','Resistant')
	state.PhysicalDefenseMode:options('PDT', 'PDT_HP')
	state.MagicalDefenseMode:options('MDT','MDT_HP','BDT','BDT_HP')
	state.ResistDefenseMode:options('MEVA','Death','Charm')
	state.IdleMode:options('Normal','Tank','KiteTank','Sphere')
	state.Weapons:options('Tank', 'Epeolatry', 'Lionheart', 'Aettir')
	state.BuffMode = M{['description']='Buff Mode', 'Tank', 'Supertank', 'Hybrid', 'DD'}
	state.DowngradeFlash = M(false,'Downgrade Flash')

    state.AutoBuffMode.value = 'Off'
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	gear.enmity_jse_back = {name="Ogma's cape",augments={'INT+20','Eva.+20 /Mag. Eva.+20','Enmity+10',}}
	gear.stp_jse_back = {name="Ogma's cape",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.da_jse_back = {name="Ogma's cape",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

	-- Additional local binds
	--send_command('bind !` gs c SubJobEnmity')
	--send_command('bind @` gs c cycle RuneElement')
	--send_command('bind ^` gs c RuneElement')
	--send_command('bind @pause gs c toggle AutoRuneMode')
	--send_command('bind ^delete input /ja "Provoke" <stnpc>')
	--send_command('bind !delete input /ma "Cure IV" <stal>')
	--send_command('bind @delete input /ma "Flash" <stnpc>')
    --send_command('bind !f11 gs c cycle ExtraDefenseMode')
	--send_command('bind ^\\\\ input /ma "Protect IV" <t>')
	--send_command('bind @\\\\ input /ma "Shell V" <t>')
	--send_command('bind !\\\\ input /ma "Crusade" <me>')
	--send_command('bind ^backspace input /ja "Lunge" <t>')
	--send_command('bind @backspace input /ja "Gambit" <t>')
	--send_command('bind !backspace input /ja "Rayke" <t>')
	--send_command('bind @f8 gs c toggle AutoTankMode')
	--send_command('bind @f10 gs c toggle TankAutoDefense')
	--send_command('bind ^@!` gs c cycle SkillchainMode')
	--send_command('bind !r gs c weapons Lionheart;gs c update')
	
	select_default_macro_book()
end

function init_gear_sets()

    sets.Capacity={back="Aptitude Mantle"}
    augmented_gear.capes={
    	STP_PDT={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
    	Tank={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}, priority=2},
    	DA_STR={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20', 'STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    	WSD_DEX={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
    	FC={ name="Ogma's cape", augments={'HP+60','HP+20','"Fast Cast"+10',}, priority=2}
	}

    sets.Enmity = {
        ammo="Staunch Tathlum +1", -- sird, dt-
	    head="Halitus Helm",
	    body="Emet Harness +1",
	    --body="Runeist's Coat +3",
	    hands="Kurys gloves",
	    legs="Erilaz Leg Guards +1",
	    feet="Ahosi Leggings",
        neck={name="Unmoving Collar +1", priority=2},
	    left_ear={name="Odnowa Earring +1",priority=2},
	    right_ear={name="Tuisto Earring", priority=2},
	    left_ring={name="Eihwaz Ring",priority=2},
	    right_ring={name="Gelatinous Ring +1", priority=2},
	    back=augmented_gear.capes.Tank,
	}

    sets.sird = {
        -- merits: 10
        ammo="Staunch Tathlum +1",           -- 11
        hands="Rawhide gloves",              -- 15
        legs="Carmine Cuisses +1",           -- 20
        feet=augmented_gear.Taeon.SIRD.feet, -- 9
        left_ring="Evanescence ring",        -- 5
        neck="Moonlight Necklace",           -- 15
        back=augmented_gear.capes.FC,        -- 10
        waist="Audumbla sash",               -- 10
    }
		 
    sets.Enmity.SIRD = set_combine(sets.Enmity, sets.sird, {
        body="Futhark Coat +3",
    })
     

    sets.Enmity.DT = set_combine(sets.Enmity, {
        left_ring="Defending Ring",
    })

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{body="Runeist's Coat +3",legs="Futhark Trousers +3"})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{feet="Runeist's Boots +1"})
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{head="Futhark Bandeau +3"})
    sets.precast.JA['Liement'] = set_combine(sets.Enmity,{body="Futhark Coat +3"})
    sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{hands="Runeist's Mitons +1"})
    sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{feet="Futhark Boots"})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity,{hands="Futhark Mitons"})
    sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{back="Evasionist's cape"})
    sets.precast.JA['One For All'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    sets.precast.JA['Vallation'].DT = set_combine(sets.Enmity.DT,{body="Runeist's Coat +3", legs="Futhark Trousers +3"})
    sets.precast.JA['Valiance'].DT = sets.precast.JA['Vallation'].DT
    sets.precast.JA['Pflug'].DT = set_combine(sets.Enmity.DT,{feet="Runeist's Boots +1"})
    sets.precast.JA['Battuta'].DT = set_combine(sets.Enmity.DT,{head="Futhark Bandeau +3"})
    sets.precast.JA['Liement'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +3"})
    sets.precast.JA['Gambit'].DT = set_combine(sets.Enmity.DT,{hands="Runeist's Mitons +1"})
    sets.precast.JA['Rayke'].DT = set_combine(sets.Enmity.DT,{feet="Futhark Boots"})
    sets.precast.JA['Elemental Sforzo'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'].DT = set_combine(sets.Enmity.DT,{hands="Futhark Mitons"})
    sets.precast.JA['Embolden'].DT = set_combine(sets.Enmity.DT,{back="Evasionist's cape"})
    sets.precast.JA['One For All'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Last Resort'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Animated Flourish'].DT = set_combine(sets.Enmity.DT, {})

    sets.precast.JA['Lunge'] = {
		head=augmented_gear.Herculean.WSD.MAB.head,
        neck="Baetyl pendant",
        body="Samnuha coat",
        left_ear="Friomisi earring",
        right_ear="Hecate's earring",
        hands="Carmine Finger Gauntlets +1",
        left_ring="Acumen ring",
        right_ring="Shiva Ring +1",
        waist="Eschan Stone",
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Herculean.WSD.MAB.feet,
    }

	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	sets.element.Earth = {neck="Quanpur Necklace"}

	-- Pulse sets, different stats for different rune modes, stat aligned.
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +1",neck="Incanter's Torque",left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",legs="Rune. Trousers +2"}
    sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
        head="Carmine Mask +1",neck="Unmoving Collar +1",left_ear="Enchntr. Earring +1",right_ear="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,left_ring="Defending Ring",right_ring="Valseur's Ring",
        back="Moonlight Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
    sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	-- Fast cast sets for spells
    sets.precast.FC = {					
    	-- fc 64%, occ. 5%, hp ~2650
	    ammo="Impatiens",				-- occ. 2%
	    head="Rune. Bandeau +3",		-- fc 14%
	    body=augmented_gear.Adhemar.D.body,	-- fc 7%
	    --body="Runeist's coat +3",
	    hands="Leyline Gloves",			-- fc 8%
	    legs="Aya. Cosciales +2",		-- fc 6%
	    feet="Carmine greaves +1",		-- fc 8%
	    neck={name="Unmoving Collar +1", priority=2},
	    left_ear={name="Odnowa Earring +1", priority=2},
	    --right_ear="Tuisto Earring",		-- hp 150
	    waist="Audumbla Sash",			-- SIRD
        left_ring="Weatherspoon Ring",      -- fc 5%, occ 3%
	    right_ring={name="Gelatinous Ring +1", priority=2},
	    back=augmented_gear.capes.FC,	-- fc 10%
	}
			
	sets.precast.FC.DT = {}
			
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    	waist="Siegel Sash", 
    	legs="Futhark Trousers +3"})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck='Magoraga beads', back="Mujin Mantle"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.FC.inspiration4 = { 
		-- fc 35% +48% inspiration > 80%, occ 7%, hp ~2900
	    ammo="Impatiens",				-- occ. 2%
	    head="Rune. Bandeau +3",		-- fc 12%
    	hands="Rawhide gloves",			-- sird 15%
	    legs="Carmine cuisses +1",		-- sird 20%
	    feet="Carmine greaves +1",		-- fc 8%
		neck="Moonlight Necklace",		-- sird 10%
	    left_ring="Lebeche ring",			-- occ. 2%
	    right_ring="Weatherspoon Ring",		-- fc 5%, occ 3%
	    back=augmented_gear.capes.FC,	-- fc 10%
	}
    sets.precast.FC['Enhancing Magic'].inspiration4 = {
    	-- fc 36% + 48% inspiration > 80%, occ 7%, hp ~2900
	    ammo="Impatiens",				-- occ. 2%
    	hands="Rawhide gloves",			-- sird 15%
    	legs="Futhark Trousers +3", 	-- enh. fc 13%
		neck="Moonlight Necklace",		-- sird 10%
	    left_ring="Lebeche ring",			-- occ. 2%
	    right_ring="Weatherspoon Ring",		-- fc 5%, occ 3%
    	waist="Siegel Sash", 			-- enh. fc 8%
	    back=augmented_gear.capes.FC,	-- fc 10%
    }
    sets.precast.FC.Utsusemi.inspiration4 = set_combine(sets.precast.FC.inspiration4, {neck='Magoraga beads', back="Mujin Mantle"})
	sets.precast.FC.Cure.inspiration4 = set_combine(sets.precast.FC.inspiration4, {})

	-- Weaponskill sets
	sets.precast.WS = {
	    ammo="Knobkierrie",
    	head=augmented_gear.Herculean.WSD.STR.head,
	    neck="Fotia Gorget",
	    left_ear="Sherida Earring",
	    right_ear="Moonshade Earring",
	    body="Ayanmo Corazza +2",
	    hands="Meg. Gloves +2",
	    left_ring="Regal Ring",
	    right_ring="Epaminondas's Ring",
	    waist="Fotia Belt",
        legs=augmented_gear.Herculean.WSD.STR.legs,
    	feet=augmented_gear.Herculean.WSD.STR.feet,
    	back=augmented_gear.capes.DA_STR,
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS,{})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS,{})

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,{
        head=augmented_gear.Adhemar.Atk.head,
        body=augmented_gear.Adhemar.Atk.body,
        hands="Meghanada gloves +2",
    	legs="Samnuha Tights",
    	right_ring="Niqmaddu ring",
    	back=augmented_gear.capes.DA_STR,
    	})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'],{
    	head="Rune. Bandeau +3",
    	})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS['Resolution'].Acc,{})

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
    	head=augmented_gear.Lustratio.DEX.head,
    	body=augmented_gear.Herculean.WSD.DEX.body,
    	left_ear="Sherida earring",
    	right_ear="Moonshade Earring",
    	left_ring="Regal ring",
        right_ring="Epaminondas's Ring",
    	back=augmented_gear.capes.WSD_DEX,
    	legs=augmented_gear.Lustratio.DEX.legs,
    	feet=augmented_gear.Lustratio.D.feet,
    })
    sets.precast.WS['Dimidiation'].Tank = set_combine(sets.precast.WS['Dimidiation'], {
    	right_ear="Tuisto Earring",
    	left_ear="Odnowa Earring +1",
    	back="Moonbeam Cape",
    	})
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'],{
	    body="Ayanmo Corazza +2",
    })
	sets.precast.WS['Dimidiation'].FullAcc = set_combine(sets.precast.WS['Dimidiation'].Acc,{
		left_ear="Odr earring",
	})
	
    sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS,{
    	head="Meghanada visor +2",
    	legs="Meghanada chausses +2"
    	})
    sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc,{})
	sets.precast.WS['Ground Strike'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})
		
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast['Lunge'], {})

    sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS, {
        head=augmented_gear.Adhemar.Atk.head,
        body=augmented_gear.Adhemar.Atk.body,
        hands=augmented_gear.Adhemar.Atk.hands,
        legs="Meghanada Chausses +2",
        feet=augmented_gear.Herculean.TA.feet,
        neck="Fotia Gorget",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        --left_ring="Petrov Ring",
        right_ring="Niqmaddu Ring",
    })
    sets.precast.WS['Shockwave'].Acc = set_combine(sets.precast.WS['Shockwave'], {
        head="Carmine Mask +1",
        body="Ayanmo Corazza +2",
        hands="Ayanmo Manopolas +2",
        legs="Ayanmo Cosciales +2",
        feet="Ayanmo Gambieras +2",
        neck="Erra Pendant",
        left_ear="Dignitary Earring",
        right_ear="Gwati Earring",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring +1",
        waist="Eschan Stone",
    })

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
    sets.midcast.FastRecast.inspiration4 = set_combine(sets.precast.FC.inspiration4, {})
			
	sets.midcast.FastRecast.DT = set_combine(sets.midcast.FastRecast,{})

    sets.midcast['Enhancing Magic'] = {
    	head="Erilaz Galea +1",
    	hands="Regal Gauntlets",
    	legs="Futhark Trousers +3",
        neck="Incanter's Torque",
        left_ear="Mimir Earring",
        right_ear="Andoaa Earring",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring +1",
        waist="Olympus Sash",

        --hp swaps
        --body="Runeist's coat +3", 
        feet="Carmine Greaves +1", -- also fc
        back={name="Moonbeam Cape", priority=1},
    }
    sets.midcast['Phalanx'] = {
        head="Futhark Bandeau +3",
        body=augmented_gear.Taeon.Phalanx.body,
        hands="Regal Gauntlets",
        neck="Incanter's Torque",
        legs=augmented_gear.Herculean.Phalanx.legs,
        feet=augmented_gear.Taeon.Phalanx.feet,
        left_ear="Mimir Earring",
        left_ring="Stikini Ring +1",
        waist="Olympus Sash",
        back={name="Moonbeam Cape", priority=1},
	}
    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'],{head="Rune. Bandeau +3"}) 
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'],{head="Erilaz Galea +1"}) 
    sets.midcast['Aquaveil'] = set_combine(sets.sird, {
        head=augmented_gear.Taeon.SIRD.head,
        left_ear={name="Odnowa Earring +1",priority=2},
        right_ear={name="Tuisto earring", priority=2},
        --left_ring="Defending Ring",
        right_ring={name="Gelatinous Ring +1", priority=2},
        back={name="Moonbeam Cape", priority=2},
    })
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {right_ear="Earthcry Earring",waist="Siegel Sash"})
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Foil = set_combine(sets.Enmity, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {}
		
	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})
		
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})


	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}

    sets.idle = set_combine(sets.engaged, {
	    ammo="Staunch Tathlum +1",
	    head="Turms cap +1",
	    body="Runeist's Coat +3",
	    hands="Regal Gauntlets",
        legs="Erilaz Leg guards +1",
	    feet="Turms Leggings +1",
        neck="Futhark Torque +2",
	    waist="Flume Belt",
	    left_ear="Odnowa Earring +1",
	    right_ear="Tuisto Earring",
	    left_ring="Defending Ring",
	    right_ring="Gelatinous Ring +1",
	    back=augmented_gear.capes.Tank,})
		
    sets.idle.Sphere = set_combine(sets.idle,{body="Mekosu. Harness"})
			
	sets.idle.Tank = set_combine(sets.idle, {
		neck="Futhark Torque +2",
        legs="Erilaz Leg Guards +1",
    })
		
	sets.idle.KiteTank = set_combine(sets.idle.Tank, {
        body="Futhark Coat +3",
		legs="Carmine Cuisses +1",
	})

	sets.idle.Weak = set_combine(sets.idle.Tank, {
		back="Moonbeam Cape",
		right_ring="Gelatinous ring +1"})

	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
    sets.idle.Town = set_combine(sets.idle, sets.Kiting, {
    	head="Runeist's Bandeau +3",
    	body="Runeist's Coat +3",
	    hands="Regal Gauntlets",
    })
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {right_ear="Ethereal Earring",waist="Flume Belt"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="Volte Cap", hands=augmented_gear.Herculean.TH.hands,feet="Volte Boots"})
	
	-- Weapons sets
    sets.weapons.Tank = {main="Epeolatry",sub="Refined Grip +1"}
	sets.weapons.Aettir = {main="Aettir",sub="Utu Grip"}
	sets.weapons.Lionheart = {main="Lionheart",sub="Utu Grip"}
	sets.weapons.Epeolatry = {main="Epeolatry",sub="Utu Grip"}
	
	-- Defense Sets
	
	sets.defense.PDT = set_combine(sets.idle.Tank, {})
	sets.defense.PDT_HP = {}
		
	sets.defense.MDT = set_combine(sets.idle.Tank, {})
	sets.defense.MDT_HP = {}
	
	sets.defense.BDT = set_combine(sets.defense.MDT,{})
	sets.defense.BDT_HP = {}
	
	sets.defense.MEVA = set_combine(sets.defense.MDT,{
        hands="Turms mittens +1",
    })
		
	sets.defense.Death = {left_ring="Eihwaz ring"}

	sets.defense.Charm = set_combine(sets.defense.MEVA, { 
        body="Futhark Coat +3", 
        legs="Volte Hose",
        feet="Volte Boots",
        neck={name="Unmoving Collar +1", priority=2},
    })

    sets.defense.Knockback = {body="Futhark Coat +3", legs="Dashing Subligar",feet="Ahosi leggings",back="Repulse Mantle",}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {left_ear="Brutal Earring"}
	sets.AccMaxTP = {left_ear="Telos Earring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {
    	ammo="Aurgelmir orb +1",
        head=augmented_gear.Adhemar.Atk.head,
        body=augmented_gear.Adhemar.Atk.body,
    	hands=augmented_gear.Adhemar.Atk.hands,
	    legs="Samnuha Tights",
    	feet=augmented_gear.Herculean.TA.feet,
        neck="Anu Torque",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        left_ring="Ilabrat Ring",
        right_ring="Petrov Ring",
	    waist="Kentarch Belt +1",
	    back=augmented_gear.capes.STP_PDT,
	}
    sets.engaged.AM = set_combine(sets.engaged, {
        right_ear="Dedition Earring",
        left_ring="Chirich Ring +1",
        right_ring="Niqmaddu Ring",
    })
	sets.engaged.Acc = set_combine(sets.engaged, {
	    ammo="Yamarang",
	    head="Aya. Zucchetto +2",
    	hands=augmented_gear.Adhemar.Acc.hands,
    	waist="Kentarch belt +1",
	})
	sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
		neck="Lissome Necklace",
		left_ear="Dignitary's earring",
	    body="Ayanmo Corazza +2",
    	left_ring="Cacoethic ring +1",
	})
    sets.engaged.DTLite = set_combine(sets.engaged, {
    	head="Ayanmo Zucchetto +2",
    	neck="Loricate Torque +1",
    	body="Ayanmo Corazza +2",
    	left_ring="Defending ring",
    	waist="Flume Belt",
    })
	sets.engaged.Acc.DTLite = set_combine(sets.engaged.Acc, {})
	sets.engaged.FullAcc.DTLite =set_combine(sets.engaged.FullAcc,  {})
	sets.engaged.TankLite = set_combine(sets.engaged, {
    	hands="Turms mittens +1",
	})
	
    sets.engaged.Tank = set_combine(sets.idle.Tank,{
    	hands="Turms mittens +1",
  	})
	sets.engaged.Acc.Tank = set_combine(sets.engaged.Tank,{
    	legs="Ayanmo cosciales +2",
	})
	sets.engaged.FullAcc.Tank = set_combine(sets.engaged.Acc.Tank, {
	})
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Battuta = {}
	
end

function user_job_precast(spell, spellMap, eventArgs)
	if state.DowngradeFlash.value then
		if spell.english:lower() == 'flash' then

			local spell_recasts = windower.ffxi.get_spell_recasts()
			local ability_recasts = windower.ffxi.get_ability_recasts()

			local tagged = info.hate_mobs[spell.target.id]
			local rune_up = is_rune_active()

			if spell_recasts[112] == 0 then 
				-- Cast Flash :D
			elseif tagged and spell_recasts[840] == 0 then
				eventArgs.cancel = true
				change_spell(player, 'Foil')
			elseif spell_recasts[592] == 0 and player.sub_job == "BLU" then
				eventArgs.cancel = true
				change_spell(spell.target, 'Blank Gaze')
            elseif spell_recasts[575] == 0 and player.sub_job == "BLU" then
                eventArgs.cancel = true
                change_spell(spell.target, 'Jettatura')
			elseif spell_recasts[252] == 0 and player.sub_job == "DRK" then
				eventArgs.cancel = true
				change_spell(spell.target, 'Stun')
			elseif ability_recasts[5] == 0 and player.sub_job == "WAR" then
				eventArgs.cancel = true
				change_spell(spell.target, 'Provoke')
			elseif tagged and rune_up and ability_recasts[113] == 0 then
				eventArgs.cancel = true
				change_spell(player, 'Valiance')
			elseif tagged and rune_up and ability_recasts[59] == 0 then
				eventArgs.cancel = true
				change_spell(player, 'Pflug')
			elseif tagged and rune_up and ability_recasts[23] == 0 then
				eventArgs.cancel = true
				change_spell(player, 'Vallation')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then 
					add_to_chat(123,'All Enmity spells on cooldown.') 
					eventArgs.cancel = true
				end
			end
		elseif spell.english:lower() == 'poisonga' or spell.english:lower() == 'sheep song' then

			local spell_recasts = windower.ffxi.get_spell_recasts()
			local ability_recasts = windower.ffxi.get_ability_recasts()

			local tagged = targets_in_range_are_tagged(spell.target, 10)
			local rune_up = is_rune_active()
			if tagged and spell_recasts[840] == 0 then
				eventArgs.cancel = true
				change_spell(player, 'Foil')
			elseif tagged and rune_up and ability_recasts[113] == 0 then
				eventArgs.cancel = true
				change_spell(player, 'Valiance')
			elseif tagged and rune_up and ability_recasts[59] == 0 then
				eventArgs.cancel = true
				change_spell(player, 'Pflug')
			elseif tagged and rune_up and ability_recasts[23] == 0 then
				eventArgs.cancel = true
				change_spell(player, 'Vallation')
			elseif player.sub_job == "BLU" then
				if spell_recasts[584] == 0 then
					if not spell.english:lower() == 'sheep song' then
						eventArgs.cancel = true
						change_spell(spell.target, 'Sheep Song')
					end
				elseif  spell_recasts[605] == 0 then
					eventArgs.cancel = true
					change_spell(spell.target, 'Geist Wall')
				elseif  spell_recasts[598] == 0 then
					eventArgs.cancel = true
					change_spell(spell.target, 'Soporific')
				elseif  spell_recasts[537] == 0 then
					eventArgs.cancel = true
					change_spell(spell.target, 'Stinking Gas')
				else
					add_to_chat(123,'All Enmity spells on cooldown.')
					eventArgs.cancel = true
				end
			elseif player.sub_job == "DRK" and spell_recasts[225] == 0 then
				if not spell.english:lower() == 'poisonga' then
					eventArgs.cancel = true
					change_spell(spell.target, 'Poisonga')
				end
			else
				add_to_chat(123,'All Enmity spells on cooldown.')
				eventArgs.cancel = true
			end
		end
	end
end

--function user_job_precast(spell, spellMap, eventArgs)
--	just_cast_val = nil
--	if (spell.en == "Valiance" or spell.en == "Vallation") and player.merits.inspiration > 0 then
--		add_to_chat(123,"precast: "..spell.en.." inspiration: "..player.merits.inspiration)
--		just_cast_val = {spell= spell.en, fc= player.merits.inspiration}
--	elseif spell.type:lower():contains('magic') and state.fc then
--		add_to_chat(123,"Equipping inspiration FC set")
--		classes.CustomClass = 'inspiration'..state.fc
--	end
--end
--
--function user_job_buff_change(buff, gain)
--	if buff == "Fast Cast"  then
--		if gain then
--			add_to_chat(123,"Gained buff: Fast Cast")
--			if just_cast_val then
--				add_to_chat(123,"Inspiration level = ".. just_cast_val.fc)
--				state.fc = just_cast_val.fc
--			else
--				add_to_chat(123,"Unknown inspiration")
--				just_cast_val = nil
--				state.fc = 3
--			end
--		else
--			add_to_chat(123,"Lost buff: Fast Cast")
--			state.fc = nil
--		end
--	end
--end

function is_rune_active()
	for _,r in pairs(elements.rune_of) do
		if buffactive[r] then
			return true
		end
	end
	return false
end

function targets_in_range_are_tagged(target, range)
	local mobs = windower.ffxi.get_mob_array()
	for _,mob in pairs(mobs) do
		if mob.is_npc then 
			local dX = target.x - mob.x
			local dY = target.y - mob.y
			if target.id == mob.id or (dY * dY) + (dX * dX) <= (range * range) then
				-- target is in range
				if not info.hate_mobs[target.id] then
					return false
				end
			end
		end
	end
	return true
end

function check_recast(spell, spellMap, eventArgs)
	if (spell.english:lower() == 'flash' or spell.english:lower() == 'poisonga' or spell.english:lower() == 'sheep song') and state.DowngradeFlash.value then
		return
	end
        if spell.action_type == 'Ability' and spell.type ~= 'WeaponSkill' then
			if spell.recast_id == 231 or spell.recast_id == 255 or spell.recast_id == 102 or spell.recast_id == 195 then return false end
            local abil_recasts = windower.ffxi.get_ability_recasts()
			if not abil_recasts[spell.recast_id] then
				add_to_chat(123,"Abort: You don't have access to ["..spell.english.."].")
				eventArgs.cancel = true
				return true
            elseif abil_recasts[spell.recast_id] > 0 then
				if spell.english == "Lunge" and abil_recasts[241] == 0 then
					eventArgs.cancel = true
					windower.send_command('@input /ja "Swipe" <t>')
					return true
				else
					add_to_chat(123,'Abort: ['..spell.english..'] waiting on recast. ('..seconds_to_clock(abil_recasts[spell.recast_id])..')')
					eventArgs.cancel = true
					return true
				end
			else
				return false
            end
        elseif spell.action_type == 'Magic' then
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] > 0 then
				if stepdown(spell, eventArgs) then 
					return true
				else
                add_to_chat(123,'Abort: ['..spell.english..'] waiting on recast. ('..seconds_to_clock(spell_recasts[spell.recast_id]/60)..')')
                eventArgs.cancel = true
                return true
				end
			else
				return false
            end
		else
			return false
        end

end

function change_spell(target, spell_name)
	windower.chat.input('/ma "'..spell_name..'" '..target.id)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 11)
    
    windower.chat.input:schedule(1,'/lockstyleset 4')
end

function user_job_tick()
    if state.AutoBuffMode.value ~= 'Off' then
    	local d = check_buffs()
    	if d > 0 then
    		tickdelay = d
    		return true
    	end
	end

    return false
end
function check_buffs()
    local spell_recasts = windower.ffxi.get_spell_recasts()
	local ability_recasts = windower.ffxi.get_ability_recasts()
		--Tank
    if state.BuffMode.value == 'Tank' then
        if not buffactive.Phalanx and spell_recasts[106] == 0 then
            windower.chat.input('/ma "Phalanx" <me>')
            return 200
        elseif not buffactive['Defense Boost'] and not buffactive['Defense Down'] and spell_recasts [547] == 0 and player.sub_job == 'BLU' then
            windower.chat.input('/ma "Cocoon" <me>')
            return 200
        elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
            windower.chat.input('/ma "Crusade" <me>')
            return 200
        elseif player.sub_job == 'BLU' and not buffactive.Haste and spell_recasts [530] == 0 then
            windower.chat.input('/ma "Refueling" <me>')
            return 200
        elseif not buffactive.Refresh and spell_recasts [109] == 0 then
            windower.chat.input('/ma "Refresh" <me>')
            return 200
        elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
            windower.chat.input('/ma "Aquaveil" <me>')
            return 200
        elseif not buffactive.Regen and spell_recasts [477] == 0 then
            send_command('input /ma "Regen IV" <me>')
            return 200
        elseif not buffactive['Shock Spikes'] and spell_recasts [251] == 0 and player.mpp > 50 then
            send_command('input /ma "Shock Spikes" <me>')
            return 200
        else
            add_to_chat(123,'All buffs applied.')
        end
    elseif state.BuffMode.value == 'Supertank' then
        if not buffactive.Aquaveil and spell_recasts [55] == 0 then
            windower.chat.input('/ma "Aquaveil" <me>')
            return 200
        elseif not buffactive.Phalanx and spell_recasts[106] == 0 then
            windower.chat.input('/ma "Phalanx" <me>')
            return 200
        elseif not buffactive['Defense Boost'] and not buffactive['Defense Down'] and spell_recasts [547] == 0 and player.sub_job == 'BLU' then
            windower.chat.input('/ma "Cocoon" <me>')
            return 200
        elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
            windower.chat.input('/ma "Crusade" <me>')
            return 200
        elseif not buffactive['Shock Spikes'] and spell_recasts [251] == 0 and player.mpp > 50 then
            send_command('input /ma "Shock Spikes" <me>')
            return 200
        elseif not buffactive.Refresh and spell_recasts [109] == 0 then
            windower.chat.input('/ma "Refresh" <me>')
            return 200
        elseif player.sub_job == 'BLU' and not buffactive.Haste and spell_recasts [530] == 0 then
            windower.chat.input('/ma "Refueling" <me>')
            return 200
        elseif not buffactive.Regen and spell_recasts [477] == 0 then
            send_command('input /ma "Regen IV" <me>')
            return 200
        else
            add_to_chat(123,'All buffs applied.')
        end

	elseif state.BuffMode.value == 'Hybrid' then
		if not buffactive.Phalanx and spell_recasts[106] == 0 then
		   windower.chat.input('/ma "Phalanx" <me>')
		   return 200
		elseif not buffactive['Defense Boost'] and not buffactive['Defense Down'] and spell_recasts [547] == 0 and player.sub_job == 'BLU' then
			windower.chat.input('/ma "Cocoon" <me>')
			return 200
		elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
			windower.chat.input('/ma "Crusade" <me>')
			return 200
		elseif player.sub_job == 'BLU' and not buffactive.Haste and spell_recasts [530] == 0 then
			windower.chat.input('/ma "Refueling" <me>')
			return 200
		elseif not buffactive.Refresh and spell_recasts [109] == 0 then
			windower.chat.input('/ma "Refresh" <me>')
			return 200
		elseif not buffactive['Multi Strikes'] and spell_recasts[493] == 0 then
			windower.chat.input('/ma "Temper" <me>')
			return 200
		else
			add_to_chat(123,'All buffs applied.')
		end

	elseif state.BuffMode.value == 'DD' then
		if not buffactive['Multi Strikes'] and spell_recasts[493] == 0 then
			windower.chat.input('/ma "Temper" <me>')
			return 200
		elseif player.sub_job == 'BLU' and not buffactive.Haste and spell_recasts [530] == 0 then
			windower.chat.input('/ma "Refueling" <me>')
			return 200
		elseif player.sub_job == 'DRK' and not buffactive['Last Resort'] and ability_recasts[87] == 0 then
			windower.chat.input('/ja "Last Resort" <me>')
			return 200
		elseif not buffactive['Swordplay'] and ability_recasts[24] == 0 then
			windower.chat.input('/ja "Swordplay" <me>')
			return 200
		elseif player.mpp < 70 and spell_recasts[109] == 0 then
			windower.chat.input('/ma "Refresh" <me>')
			return 200
		else
			add_to_chat(123,'All buffs applied.')
		end
	end

	return -1
end

function user_job_self_command(commandArgs, eventArgs)
	if commandArgs[1] == 'Buff' then

		check_buffs()

	elseif commandArgs[1] == 'Provoke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local ability_recasts = windower.ffxi.get_ability_recasts()
		if spell_recasts[112] == 0 then
			send_command('input /ma "Flash" <stnpc>')
		elseif spell_recasts[575] == 0 and player.sub_job == "BLU" then
			send_command('input /ma "Jettatura" <stnpc>')
		elseif spell_recasts[592] == 0 and player.sub_job == "BLU" then
			send_command('input /ma "Blank Gaze" <stnpc>')
		elseif spell_recasts[252] == 0 and player.sub_job == "DRK" then
			send_command('input /ma "Stun" <stnpc>')
		elseif ability_recasts[5] == 0 and player.sub_job == "WAR" then
			send_command('input /ja "Provoke" <stnpc>')
		elseif not check_auto_tank_ws() then
			if not state.AutoTankMode.value then add_to_chat(123,'All Enmity spells on cooldown.') end
		end

	elseif commandArgs[1] == 'AoEnmity' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if spell_recasts[225] == 0 and player.sub_job == "DRK" then
			send_command('input /ma "Poisonga" <stnpc>')
		elseif player.sub_job == "BLU" then
			if spell_recasts[584] == 0 then
				send_command('input /ma "Sheep Song" <stnpc>')
			elseif  spell_recasts[605] == 0 then
				send_command('input /ma "Geist Wall" <stnpc>')
			elseif  spell_recasts[598] == 0 then
				send_command('input /ma "Soporific" <stnpc>')
			elseif  spell_recasts[537] == 0 then
				send_command('input /ma "Stinking Gas" <stnpc>')
			else
				add_to_chat(123,'All Enmity spells on cooldown.')
			end
		else
			add_to_chat(123,'All Enmity spells on cooldown.')
		end

	elseif commandArgs[1] == 'Foil' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if spell_recasts[840] == 0 then
			send_command('input /ma "Foil" <me>')
		elseif player.sub_job == "BLU" then
			if spell_recasts[584] == 0 then
				send_command('input /ma "Sheep Song" <t>')
			elseif  spell_recasts[605] == 0 then
				send_command('input /ma "Geist Wall" <t>')
			elseif  spell_recasts[598] == 0 then
				send_command('input /ma "Soporific" <t>')
			elseif  spell_recasts[537] == 0 then
				send_command('input /ma "Stinking Gas" <t>')
			end
		else
			add_to_chat(123,'All Enmity spells on cooldown.')
		end
	elseif commandArgs[1] == 'turtle' then
		if state.DefenseMode.value == commandArgs[2] then
			handle_set({"DefenseMode","None"})
		else
			handle_set({"DefenseMode",commandArgs[2]})
		end
    end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] == 0 and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = (framerate * 3)
					return true
				else
					return false
				end
			end
		end
	end
	return false
end