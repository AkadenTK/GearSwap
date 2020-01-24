function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal', 'DTLite', 'MoreDT')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
    state.CastingMode:options('Normal','Resistant')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
    state.Weapons:options('DDScythe', 'Algol','None')
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

    sets.Capacity={back="Aptitude Mantle"}

    sets.weapons = {}
    sets.weapons.Algol = {main='Raetic Algol +1', sub="Utu Grip"}
    sets.weapons.DDScythe = {main='Anguta', sub="Utu Grip"}
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA['Diabolic Eye'] = {}
	sets.precast.JA['Arcane Circle'] = {}
	sets.precast.JA['Souleater'] = {}
	sets.precast.JA['Weapon Bash'] = {hands="Ignominy gauntlets +2"}
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
	    head="Carmine Mask +1",
	    body={ name="Odyss. Chestplate", augments={'"Fast Cast"+5','VIT+7','"Mag.Atk.Bns."+6',}},
	    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    neck="Baetyl Pendant",
	    ear1="Cessance Earring",
	    ear2="Brutal Earring",
	    ring1="Kishar Ring",
	    ring2="Weather. Ring",
	}

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {})
	--sets.precast.FC['Dark Magic'] = set_combine(sets.precast.FC, {head="Fallen's Burgeonet"})
		
	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{})
                   
	-- Specific spells 

	sets.MagicAccuracy = {
	    ammo="Pemphredo Tathlum",
	    head="Flam. Zucchetto +2",
	    body="Flamma Korazin +1",
	    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    feet="Flam. Gambieras +2",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    ear1="Hermetic Earring",
	    ear2="Digni. Earring",
	    ring2="Sangoma Ring",	
	}
 
	sets.midcast['Dark Magic'] = set_combine(sets.MagicAccuracy, {
		body="Carmine Scale Mail",
	    hands={ name="Fall. Fin. Gaunt. +1", augments={'Enhances "Diabolic Eye" effect',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    neck="Erra Pendant",
	    ring1="Stikini Ring",
	    ring2="Kishar ring",
	    back={ name="Niht Mantle", augments={'Attack+14','Dark magic skill +6','"Drain" and "Aspir" potency +24',}},
	    feet="Ratri Sollerets",
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
	    ear1="Odnowa Earring +1",
	    ear2="Odnowa Earring",
	    ring1="Praan Ring",
	    ring2="Moonbeam Ring",
	    back="Moonbeam Cape",
    })
	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
		back="Chuparrosa Mantle",
		ring2="Kishar Ring",})
	sets.midcast.Absorb.Resistant = set_combine(sets.midcast.Absorb, {
		back={ name="Ankou's Mantle", augments={'Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
		hands="Ratri gadlings",
		legs="Flamma Dirs +1"
	})
           
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'],{})
                   
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
	    ammo="Pemphredo Tathlum",
	    head="Pixie Hairpin +1",
	    hands={ name="Fall. Fin. Gaunt. +1", augments={'Enhances "Diabolic Eye" effect',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    neck="Erra Pendant",
	    ring1="Archon Ring",
	    ring2="Evanescence Ring",
	    waist="Fucho-no-Obi",
    })
                   
	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {})
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash", legs="Flamma dirs +1"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash", legs="Flamma dirs +1"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    	ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Brutal earring",
    	body="Ignominy cuirass +3",
		hands="Sulev. Gauntlets +2",
    	ring1="Niqmaddu ring",
		ring2="Regal Ring",
    	back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs="Ignominy Flanchard +3",
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
    	ear2="Ishvara Earring",
		back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10'}},
    })
    sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS['Torcleaver'], {
    	ammo="Seething Bomblet",
    	head="Sulevia's mask +2",
    	ear2="Telos Earring",
    	})
    sets.precast.WS['Torcleaver'].FullAcc = set_combine(sets.precast.WS['Torcleaver'].Acc, {
    	ear1="Dignitary's earring",
    	ring2="Flamma ring",
    	})

    sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {
    	head="Ratri Sallet",
    	hands="Ratri Gadlings",
    	ring1="Shiva ring +1",
    	})
    sets.precast.WS['Entropy'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Entropy'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Entropy'].Fodder = set_combine(sets.precast.WS.Fodder, {})
     
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
    	head="Argosy Celata +1",
    	feet="Argosy Sollerets +1",
    	back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	})
    sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {
    	ammo="Seething Bomblet",
    	ear2="Cessance Earring",
    	})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})     
     
    sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
    	head="Ratri Sallet",
    	hands="Ratri Gadlings",
    	ear2="Ishvara earring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
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
	    head="Argosy celata +1",
	    body=augmented_gear.Valorous.TP.body,
	    hands="Argosy mufflers +1",
	    legs="Ignominy Flanchard +3",
	    feet="Flamma Gambieras +2",
	    neck="Asperity Necklace",
	    waist="Ioskeha Belt",
	    ear1="Cessance Earring",
	    ear2="Brutal Earring",
	    ring1="Niqmaddu Ring",
	    ring2="Flamma Ring",
    	back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	sets.engaged.Acc = set_combine(sets.engaged,{
		neck="Lissome Necklace",
		ammo="Seething Bomblet",
		ear1="Dignitary's earring",})
    sets.engaged.FullAcc = set_combine(sets.engaged.Acc,{
		ear2="Telos earring",
		hands="Ignominy gauntlets +2",
	})

    sets.engaged.DTLite = set_combine(sets.engaged, {
    	head="Sulevia's Mask +2",
    	neck="Loricate Torque",
	    legs="Sulev. Cuisses +2",
	    ring1="Defending Ring",
	})

    sets.engaged.MoreDT = set_combine(sets.engaged.DTLite, {
    	body="Sulevia's platemail +1",
    	feet="Sulevia's Leggings +2",
	})

    sets.dt = {
	    head="Sulevia's Mask +2",
	    body="Sulevia's Plate. +1",
	    hands="Sulev. Gauntlets +2",
	    legs="Sulev. Cuisses +2",
	    feet="Sulev. Leggings +2",
	    neck="Loricate Torque",
	    waist="Flume Belt",
	    ear2="Ethereal Earring",
	    ring1="Defending Ring",
	    ring2="Warden's Ring",
	    back="Moonbeam Cape",
	}
     
    -- Idle sets
           
    sets.idle = set_combine(sets.engaged,{
    	ammo="Staunch Tathlum +1",
    	head=empty,
    	neck="Coatl gorget +1",
    	body="Lugra Cloak +1",
    	hands="Sulev. Gauntlets +2",
	    ring1="Defending Ring",
	    ring2="Paguroidea ring",
	    waist="Flume Belt",
	    legs="Sulev. Cuisses +2",
	    feet="Sulev. Leggings +2",
    	})
		
    sets.idle.PDT = {
	    ammo="Knobkierrie",
	    head="Sulevia's Mask +2",
	    body="Sulevia's Plate. +1",
	    hands="Sulev. Gauntlets +2",
	    legs="Sulev. Cuisses +2",
	    feet="Sulev. Leggings +2",
	    neck="Loricate Torque",
	    waist="Flume Belt",
	    ear2="Ethereal Earring",
	    ring1="Defending Ring",
	    ring2="Warden's Ring",
	    back="Moonbeam Cape",
	}

	--sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
		
	--sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
           
    -- Defense sets
	sets.defense.PDT = {
	    ammo="Knobkierrie",
	    head="Sulevia's Mask +2",
	    body="Sulevia's Plate. +1",
	    hands="Sulev. Gauntlets +2",
	    legs="Sulev. Cuisses +2",
	    feet="Sulev. Leggings +2",
	    neck="Loricate Torque",
	    waist="Flume Belt",
	    ear2="Ethereal Earring",
	    ring1="Defending Ring",
	    ring2="Warden's Ring",
	    back="Moonbeam Cape",
	}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = {
	    ammo="Knobkierrie",
	    head="Sulevia's Mask +2",
	    body="Sulevia's Plate. +1",
	    hands="Sulev. Gauntlets +2",
	    legs="Sulev. Cuisses +2",
	    feet="Sulev. Leggings +2",
	    neck="Loricate Torque",
	    waist="Flume Belt",
	    ear2="Ethereal Earring",
	    ring2="Defending Ring",
	    back="Moonbeam Cape",
	}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.defense.MEVA = {}
     
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.passive.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Berserker's Torque"}
	--Extra Special Sets
	
	sets.buff.Souleater = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	
    end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 7)
    
    windower.chat.input('/lockstyleset 5')
end


function user_job_self_command(commandArgs, eventArgs)
	if commandArgs[1]:lower() == "setgs" and state.Weapons.value ~= "Algol" then
		windower.send_command("gs c set Weapons Algol")
	elseif commandArgs[1]:lower() == "setscythe" and state.Weapons.value ~= "DDScythe" then
		windower.send_command("gs c set Weapons DDScythe")
	end
end