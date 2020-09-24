function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','FullAcc')
    state.WeaponskillMode:options('Match','Normal', 'Acc', 'FullAcc')
    state.HybridMode:options('Normal', 'DTLite', 'CounterHybrid','MEVA')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Verethragna','Godhands','Spharai','Staff','Barehanded','None')

	state.AutoBoost = M(false, 'Auto Boost Mode')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}

    update_melee_groups()
	
	-- Additional local binds
	--send_command('bind ^` input /ja "Boost" <me>')
	--send_command('bind !` input /ja "Perfect Counter" <me>')
	--send_command('bind ^backspace input /ja "Mantra" <me>')
    --send_command('bind !f11 gs c cycle ExtraMeleeMode')
	--send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

function init_gear_sets()

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands=augmented_gear.Herculean.TH.hands,legs="Volte Hose",feet="Volte Boots"})

    augmented_gear.capes = {}
    augmented_gear.capes.tp_da = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    augmented_gear.capes.str_crit = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}
	augmented_gear.capes.str_wsd = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	augmented_gear.capes.dex_wsd = augmented_gear.capes.str_wsd
	augmented_gear.capes.dex_da = augmented_gear.capes.tp_da
	augmented_gear.capes.tp_counter = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	sets.enmity = {
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys gloves",
		neck="Moonbeam Necklace",
		left_ring="Eihwaz ring",
		right_ring="Petrov Ring",
		left_ear="Friomisi Earring",
		ammo="Sapience orb",
	}
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"}
	sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +3"}
	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +3"}
	sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
	sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +3"}
	sets.precast.JA['Footwork'] = {feet="Bhikku gaiters +1"}
	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas +3"}
	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +3"}
	sets.precast.JA['Provoke'] = set_combine(sets.enmity, {})
	sets.midcast['Flash'] = set_combine(sets.enmity, {})

	sets.precast.JA['Chi Blast'] = {head="Hesychast's crown +3"}
	
	sets.precast.JA['Chakra'] = {
		body="Anchorite's Cyclas +3",hands="Hesychast's Gloves",
		legs="Hes. Hose +1",feet="Anchorite's Gaiters +3"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}
		
	sets.precast.Flourish1 = {}


	-- Fast cast sets for spells
	
	sets.precast.FC = {
		ammo="Sapience Orb",
    	head="Herculean Helm",
		neck="Baetyl Pendant",
		body=augmented_gear.Adhemar.D.body,
		hands="Leyline Gloves",
		left_ring="Lebeche Ring",
		right_ring="Weatherspoon Ring",
		legs=augmented_gear.Herculean.FC.legs,
		feet=augmented_gear.Herculean.FC.feet,
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads", body="Passion Jacket"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
	    ammo="Knobkierrie",
	    neck="Fotia Gorget",
		head="Hesychast's crown +3",
        body=augmented_gear.Herculean.WSD.STR.body,
        hands="Anchorite's gloves +3",
	    left_ear="Sherida Earring",
	    right_ear="Moonshade Earring",
	    back=augmented_gear.capes.str_wsd,
	    waist="Moonbow Belt +1",
    	left_ring="Gere Ring",
	    right_ring="Niqmaddu Ring",
    	legs="Hiza. Hizayoroi +2",
	    feet=augmented_gear.Herculean.WSD.STR.feet,

	}
	sets.precast.WSAcc = {}
	sets.precast.WSFullAcc = {}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)

	-- Specific weaponskill sets.

	sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {
		head=augmented_gear.Adhemar.Atk.head,
		body=augmented_gear.Adhemar.Atk.body,
    	hands=augmented_gear.Adhemar.Atk.hands,
    	left_ring="Gere Ring",
    	neck="Monk's Nodowa",
    	waist="Moonbow Belt +1",})
	sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
	sets.precast.WS["Raging Fists"].FullAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFullAcc)


	sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {})
	sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
	sets.precast.WS["Howling Fist"].FullAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFullAcc)


	sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {})
	sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
	sets.precast.WS["Asuran Fists"].FullAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFullAcc)


	sets.precast.WS['Ascetic\'s Fury']  = set_combine(sets.precast.WS, {
        head=augmented_gear.Adhemar.Atk.head,
    	hands=augmented_gear.Ryuo.STR.hands,
	    legs="Hesychast's Hose +3",
	    left_ear="Odr Earring",
    	neck="Caro Necklace",
	    right_ring="Begrudging Ring",
	    back=augmented_gear.capes.str_crit,
	})
	sets.precast.WS['Ascetic\'s Fury'].Impetus = {
		body="Bhikku Cyclas +1",}
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], {
		feet="Mummu Gamash. +2"})
	sets.precast.WS['Ascetic\'s Fury'].Acc.Impetus = {
		body="Bhikku Cyclas +1",}
	sets.precast.WS["Ascetic's Fury"].FullAcc = set_combine(sets.precast.WS["Ascetic's Fury"], {
		head="Mummu Bonnet +2",
		})
	sets.precast.WS['Ascetic\'s Fury'].FullAcc.Impetus = {
		body="Bhikku Cyclas +1",}

	sets.precast.WS['Final Heaven'] = {
	    ammo="Knobkierrie",
	    neck="Fotia Gorget",
		head="Hesychast's crown +3",
        body=augmented_gear.Herculean.WSD.STR.body,
        hands="Anchorite's gloves +3",
	    left_ear="Sherida Earring",
	    right_ear="Tuisto Earring",
	    back=augmented_gear.capes.str_wsd,
	    waist="Moonbow Belt +1",
    	left_ring="Regal Ring",
	    right_ring="Niqmaddu Ring",
    	legs="Hiza. Hizayoroi +2",
	    feet=augmented_gear.Herculean.WSD.STR.feet,

	}


	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {
        head=augmented_gear.Adhemar.Atk.head,
    	hands=augmented_gear.Ryuo.STR.hands,
    	body="Anchorite's Cyclas +3",
	    legs="Hesychast's Hose +3",
	    left_ear="Sherida Earring",
	    right_ear="Moonshade Earring",
	    left_ring="Gere Ring",
    	feet=augmented_gear.Herculean.CritDMG.STR.feet,
    	neck="Fotia Gorget",
	    back=augmented_gear.capes.str_crit,})
	sets.precast.WS["Victory Smite"].Impetus = {
		body="Bhikku Cyclas +1",
		right_ear="Ishvara Earring",}
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], {
	    left_ring="Regal Ring",
		feet="Mummu Gamash. +2"})
	sets.precast.WS["Victory Smite"].Acc.Impetus = {
		body="Bhikku Cyclas +1",
		right_ear="Ishvara Earring",}
	sets.precast.WS["Victory Smite"].FullAcc = set_combine(sets.precast.WS["Victory Smite"].Acc, {
		head="Mummu Bonnet +2"})
	sets.precast.WS["Victory Smite"].FullAcc.Impetus = {
		body="Bhikku Cyclas +1",
		right_ear="Ishvara Earring",}


	sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {
        head=augmented_gear.Adhemar.Atk.head,
		neck="Monk's Nodowa +2",
	    legs="Hesychast's Hose +3",
		right_ear='Odr earring',
	    back=augmented_gear.capes.dex_da,
	})
	sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
	sets.precast.WS["Shijin Spiral"].FullAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFullAcc)


	sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {
    	neck="Monk's Nodowa +2",
		feet="Anchorite's Gaiters +3"
	})
	sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
	sets.precast.WS["Dragon Kick"].FullAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFullAcc)


	sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {
    	neck="Monk's Nodowa +2",
		feet="Anchorite's Gaiters +3"
	})
	sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)
	sets.precast.WS["Tornado Kick"].FullAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFullAcc)


	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Cataclysm'] = {
	    ammo="Knobkierrie",
	    head="Pixie Hairpin +1",
	    body="Samnuha Coat",
	    hands="Leyline Gloves",
	    legs=augmented_gear.Herculean.WSD.MAB.legs,
    	feet=augmented_gear.Herculean.WSD.MAB.feet,
	    neck="Baetyl Pendant",
	    waist="Eschan Stone",
	    left_ear="Moonshade Earring",
	    right_ear="Friomisi Earring",
	    left_ring="Archon Ring",
	    right_ring="Acumen Ring",
	    back=augmented_gear.capes.str_wsd,
	}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {left_ear="Brutal Earring",right_ear="Sherida Earring",}
	sets.AccMaxTP = {left_ear="Zennaroi Earring",right_ear="Telos Earring"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}

	sets.Cure_Received = {neck="Phalaina Locket",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		neck="Loricate Torque +1",
		left_ear="Tuisto Earring",
		right_ear="Hearty Earring",
		head="Malignance Chapeau",
		body="Hesychast's Cyclas +3",
		hands="Malignance Gloves",
		left_ring="Defending Ring",
		right_ring="Sheltered Ring",
		legs="Malignance Tights",
		feet="Herald's Gaiters",
	    back=augmented_gear.capes.tp_da,
	    waist="Moonbow Belt +1",
	}

	sets.idle.Weak = set_combine(sets.idle, {})

	sets.idle.PDT = set_combine(sets.idle, {})	

	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle.PDT, {})
		
	-- Defense sets
	sets.defense.HP = set_combine(sets.idle, {})

	sets.defense.MDT = set_combine(sets.idle, {})
		
	sets.defense.MEVA = set_combine(sets.idle, {})

	sets.Kiting = {feet="Herald's Gaiters"}

	sets.idle.Town = {
		head="Kendatsuba Jinpachi +1",
		body="Hesychast's Cyclas +3",
		hands="Rao Kote +1",
		legs="Hesychast's Hose +3",
		feet="Herald's Gaiters",
		neck="Monk's Nodowa +2",
	}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.counter = {
		head="Rao Kabuto +1",
		body="Hesychast's Cyclas +3",
		hands="Rao Kote +1",
		legs="Anchorite's hose +3",
		feet="Hesychast's Gaiters +3",
	    back=augmented_gear.capes.tp_counter,
	    --right_ear="Genmei Earring",
	}
	-- Normal melee sets
	sets.engaged =  {
		ammo="Aurgelmir orb +1",
        head=augmented_gear.Adhemar.Atk.head,
        body="Ken. Samue +1",
        hands=augmented_gear.Adhemar.Atk.hands,
	    legs="Hesychast's Hose +3",
    	feet="Anchorite's Gaiters +3",
	    neck="Monk's Nodowa +2",
	    waist="Moonbow Belt +1",
	    left_ear="Sherida Earring",
	    right_ear="Telos Earring",
	    left_ring="Gere Ring",
	    right_ring="Niqmaddu Ring",
	    back=augmented_gear.capes.tp_da,}
	sets.engaged.Impetus = {body="Bhikku Cyclas +1"}
	sets.engaged.Reikikon = set_combine(sets.engaged, {
		legs="Samnuha Tights",
    	feet=augmented_gear.Herculean.TA.feet,})
	sets.engaged.Acc = set_combine(sets.engaged, {
	    head="kendatsuba Jinpachi +1",
        hands=augmented_gear.Adhemar.Acc.hands,
	    })
	sets.engaged.Acc.Impetus = {body="Bhikku Cyclas +1"}
	sets.engaged.Acc.Reikikon = set_combine(sets.engaged.Acc, {
		legs="Samnuha Tights",
    	feet=augmented_gear.Herculean.TA.feet,})
	sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
	    ammo="Falcon Eye",
	    body="Malignance Tabard",
	    left_ear="Odr earring",
	    left_ring="Regal Ring",
	})
	sets.engaged.FullAcc.Impetus = {body="Bhikku Cyclas +1"}

	-- Defensive melee hybrid sets
	sets.engaged.DTLite = set_combine(sets.engaged, {
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		left_ring="Defending Ring",
		ammo="Staunch Tathlum +1",
	})
	sets.engaged.DTLite.Impetus = {body="Bhikku Cyclas +1"}
	sets.engaged.CounterHybrid = set_combine(sets.engaged, sets.counter, {
		head="Malignance Chapeau",
		feet="Malignance boots",
		neck="Loricate Torque +1",
		left_ring="Defending Ring",
		ammo="Staunch Tathlum +1",
	})
	--sets.engaged.Acc.PDT = {}
	--sets.engaged.FullAcc.PDT = {}
	sets.engaged.MEVA = set_combine(sets.engaged, {
		head="Kendatsuba Jinpachi +1",
		body="Malignance Tabard",
		--legs="Kendatsuba Hakama",
		--feet="Kendatsuba Sune-ate",
	})
	--sets.engaged.Acc.PDTOnly = {}
	--sets.engaged.FullAcc.PDTOnly = {}

	-- Hundred Fists/Impetus melee set mods
	
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})
	sets.engaged.FullAcc.HF = set_combine(sets.engaged.FullAcc, {})

	sets.buff.Doom = set_combine(sets.buff.Doom, {right_ring="Saida Ring"})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	--sets.buff.Impetus = {body="Bhikku Cyclas +1"}
	sets.buff.Footwork = {} -- feet="Shukuyu Sune-Ate"
	sets.buff['Perfect Counter'] = {
		head="Rao kabuto +1",
		feet="Hesychast's gaiters +3",
	} -- feet="Shukuyu Sune-Ate"
	sets.buff['Boost'] ={
		waist="Ask Sash",
	}
	
	sets.FootworkWS = {feet="Shukuyu Sune-Ate"}
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.Skillchain = {}
	
	-- Weapons sets
	sets.weapons.Godhands = {main="Godhands"}
	sets.weapons.Verethragna = {main="Verethragna"}
	sets.weapons.Spharai = {main="Spharai"}
	sets.weapons.Staff = {main="Malignance Pole",sub="Niobid Strap"}
	sets.weapons.Barehanded = {main=empty}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(3, 1)

	windower.chat.input:schedule(1,'/lockstyleset 1')
end


function user_customize_melee_set(meleeSet)
    if buffactive.Impetus and meleeSet.Impetus then
		meleeSet = set_combine(meleeSet, meleeSet.Impetus)
    end
    if buffactive['Perfect Counter'] and state.DefenseMode.value == 'None' then
        meleeSet = set_combine(meleeSet, sets.buff['Perfect Counter'])
    end
	
    return meleeSet
end

function user_post_precast(spell, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current == 'None' then
        local WSset = get_precast_set(spell, spellMap)
        if buffactive.Impetus and WSset.Impetus then
			equip(WSset.Impetus)
        end
	end
end