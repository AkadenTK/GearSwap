function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
	state.Weapons:options('Montante','Misanthropy')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','MP','Twilight'}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    include('augmented_gear.lua')

    sets.Capacity={back="Aptitude Mantle"}
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA['Diabolic Eye'] = {}
	sets.precast.JA['Arcane Circle'] = {}
	sets.precast.JA['Souleater'] = {}
	sets.precast.JA['Weapon Bash'] = {}
	sets.precast.JA['Nether Void'] = {}
	sets.precast.JA['Blood Weapon'] = {}
	sets.precast.JA['Dark Seal'] = {head="Fallen's burgeonet"}
	sets.precast.JA['Last Resort'] = {back="Ankou's Mantle"}
                   
	sets.buff['Dark Seal'] = set_combine(sets.precast.JA['Dark Seal'], {})
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
                   
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
           
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", waist = "Chaac belt"})
		   
	-- Fast cast sets for spells

	sets.precast.FC = {
	    head="Flam. Zucchetto +2",
	    body={ name="Odyss. Chestplate", augments={'"Fast Cast"+5','VIT+7','"Mag.Atk.Bns."+6',}},
	    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    neck="Baetyl Pendant",
	    left_ear="Cessance Earring",
	    right_ear="Brutal Earring",
	    left_ring="Kishar Ring",
	    right_ring="Weather. Ring",
	}

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {})
		
	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{})
                   
	-- Specific spells 

	sets.MagicAccuracy = {
	    ammo="Pemphredo Tathlum",
	    head="Flam. Zucchetto +2",
	    body="Flamma Korazin +1",
	    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    feet="Flam. Gambieras +1",
	    neck="Erra Pendant",
	    waist="Salire Belt",
	    left_ear="Hermetic Earring",
	    right_ear="Digni. Earring",
	    right_ring="Sangoma Ring",	
	}
 
	sets.midcast['Dark Magic'] = set_combine(sets.MagicAccuracy, {
		body="Carmine Scale Mail",
	    hands={ name="Fall. Fin. Gaunt. +1", augments={'Enhances "Diabolic Eye" effect',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    feet="Flam. Gambieras +1",
	    neck="Erra Pendant",
	    left_ring="Stikini Ring",
	    back={ name="Niht Mantle", augments={'Attack+14','Dark magic skill +6','"Drain" and "Aspir" potency +24',}},
	})
           
	sets.midcast['Enfeebling Magic'] = {}
		   
	sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
		ammo="Egoist's tathlum",
	    head="Ratri Sallet",
	    body="Heathen's Cuirass +1",
	    hands="Ratri Gadlings",
	    legs="Flamma Dirs +1",
	    feet="Ratri Sollerets",
	    neck="Sanctity Necklace",
	    waist="Oneiros Belt",
	    left_ear="Ethereal Earring",
	    right_ear="Cassie Earring",
	    left_ring="Praan Ring",
	    right_ring="Etana Ring",
	    back="Moonbeam Cape",
    })
	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {back="Ankou Mantle",right_ring="Kishar Ring"})
           
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],{})
                   
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
	    ammo="Pemphredo Tathlum",
	    head="Pixie Hairpin +1",
	    hands={ name="Fall. Fin. Gaunt. +1", augments={'Enhances "Diabolic Eye" effect',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    neck="Erra Pendant",
	    left_ring="Archon Ring",
	    right_ring="Evanescence Ring",
    })
                   
	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {})
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    	ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Brutal earring",
		body="Sulevia's Platemail +1",
		hands="Sulev. Gauntlets +2",
		ring1="Hetairoi Ring",
		ring2="Ifrit Ring +1",
    	back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs="Sulevia's Cuisses +1",
		feet="Sulevia's leggings +2"}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
    sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Catastrophe'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Catastrophe'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Catastrophe'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
    	head=augmented_gear.Valorous.WSD.VIT.head,
    	Ring1="Petrov Ring",
    	ring2="Titan ring",
    	ear2="Ishvara Earring",
		back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10'}},
    })
    sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS['Torcleaver'], {})
    sets.precast.WS['Torcleaver'].FullAcc = set_combine(sets.precast.WS['Torcleaver'].Acc, {})

    sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Entropy'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Entropy'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Entropy'].Fodder = set_combine(sets.precast.WS.Fodder, {})
     
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
    	body="Argosy Hauberk",
    	feet="Flamma gambieras +2",
    	back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	})
    sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})     
     
    sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
    	feet="Flamma gambieras +2",
    	back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	})
    sets.precast.WS['Cross Reaper'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Cross Reaper'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Cross Reaper'].Fodder = set_combine(sets.precast.WS.Fodder, {})  

           
     -- Sets to return to when not performing an action.
           
     -- Resting sets
     sets.resting = {}
           
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {ear2="Telos Earring"}
     
	-- Engaged sets
	sets.engaged = {
	    ammo="Ginsen",
	    head="Flam. Zucchetto +2",
	    body=augmented_gear.Valorous.TP.body,
	    hands="Sulev. Gauntlets +2",
	    legs={ name="Odyssean Cuisses", augments={'Accuracy+23 Attack+23','Weapon Skill Acc.+3','STR+6','Accuracy+15','Attack+3',}},
	    feet="Flamma Gambieras +2",
	    neck="Lissome Necklace",
	    waist="Ioskeha Belt",
	    left_ear="Cessance Earring",
	    right_ear="Telos Earring",
	    left_ring="Petrov Ring",
	    right_ring="Flamma Ring",
	    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
	}
	sets.engaged.Acc = set_combine(sets.engaged,{
		ammo="Seething Bomblet",
		ear1="Dignitary's earring",
		ear2="Telos earring",
	})
    sets.engaged.FullAcc = set_combine(sets.engaged.Acc,{})

    sets.dt = {
	    head="Sulevia's Mask +1",
	    body="Sulevia's Plate. +1",
	    hands="Sulev. Gauntlets +2",
	    legs="Sulevi. Cuisses +1",
	    feet="Sulev. Leggings +2",
	    neck="Twilight Torque",
	    waist="Flume Belt",
	    right_ear="Ethereal Earring",
	    left_ring="Yacuruna Ring",
	    right_ring="Warden's Ring",
	    back="Moonbeam Cape",
	}
     
    -- Idle sets
           
    sets.idle = set_combine(sets.dt,{
    	head=empty,
    	body="Lugra Cloak +1",
    	neck="Coatl gorget +1",
    	})
		
    sets.idle.PDT = {
	    ammo="Knobkierrie",
	    head="Sulevia's Mask +1",
	    body="Sulevia's Plate. +1",
	    hands="Sulev. Gauntlets +2",
	    legs="Sulevi. Cuisses +1",
	    feet="Sulev. Leggings +2",
	    neck="Twilight Torque",
	    waist="Flume Belt",
	    right_ear="Ethereal Earring",
	    left_ring="Yacuruna Ring",
	    right_ring="Warden's Ring",
	    back="Moonbeam Cape",
	}

	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
           
    -- Defense sets
	sets.defense.PDT = {
	    ammo="Knobkierrie",
	    head="Sulevia's Mask +1",
	    body="Sulevia's Plate. +1",
	    hands="Sulev. Gauntlets +2",
	    legs="Sulevi. Cuisses +1",
	    feet="Sulev. Leggings +2",
	    neck="Twilight Torque",
	    waist="Flume Belt",
	    right_ear="Ethereal Earring",
	    left_ring="Yacuruna Ring",
	    right_ring="Warden's Ring",
	    back="Moonbeam Cape",
	}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = {
	    ammo="Knobkierrie",
	    head="Sulevia's Mask +1",
	    body="Sulevia's Plate. +1",
	    hands="Sulev. Gauntlets +2",
	    legs="Sulevi. Cuisses +1",
	    feet="Sulev. Leggings +2",
	    neck="Twilight Torque",
	    waist="Flume Belt",
	    right_ear="Ethereal Earring",
	    left_ring="Yacuruna Ring",
	    right_ring="Warden's Ring",
	    back="Moonbeam Cape",
	}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.defense.MEVA = {}
     
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.passive.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	--Extra Special Sets
	
	sets.buff.Souleater = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Montante = {main="Montante +1",sub="Utu Grip"}
	sets.weapons.Misanthropy = {main="Misanthropy",sub="Utu Grip"}
	
    end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 7)
end