function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','FullAcc')
    state.WeaponskillMode:options('Match','Normal', 'Acc', 'FullAcc')
    state.HybridMode:options('Normal', 'PDT','PDTOnly')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Verethragna','JoltCounters','Staff','Barehanded','None')

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
    include('augmented_gear.lua')

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {waist = "Chaac belt",hands=augmented_gear.Herculean.TH.hands,feet=augmented_gear.Herculean.TH.feet})

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
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"}
	sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +1"}
	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +3"}
	sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
	sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +1"}
	sets.precast.JA['Footwork'] = {feet="Bhikku gaiters +1"}
	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
	sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +1"}

	sets.precast.JA['Chi Blast'] = {}
	
	sets.precast.JA['Chakra'] = {
		head="Dampening Tam",
		body="Anchorite's Cyclas +1",hands="Hesychast's Gloves +1",
		legs="Hes. Hose +1",feet="Anch. Gaiters +1"}

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
		ring1="Lebeche Ring",
		ring2="Weatherspoon Ring",
		legs=augmented_gear.Herculean.FC.legs,
		feet=augmented_gear.Herculean.FC.feet,
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
	    ammo="Knobkierrie",
	    neck="Fotia Gorget",
        head=augmented_gear.Adhemar.Atk.head,
        body=augmented_gear.Adhemar.Atk.body,
        hands=augmented_gear.Adhemar.Atk.hands,
	    ear1="Sherida Earring",
	    ear2="Moonshade Earring",
	    back=augmented_gear.capes.str_wsd,
	    waist="Moonbow Belt",
	    ring1="Regal Ring",
	    ring2="Niqmaddu Ring",
    	legs="Hiza. Hizayoroi +2",
	    feet=augmented_gear.Herculean.WSD.STR.feet,

	}
	sets.precast.WSAcc = {}
	sets.precast.WSFullAcc = {}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)

	-- Specific weaponskill sets.

	sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {
	    head=augmented_gear.Herculean.WSD.STR.head,
    	hands=augmented_gear.Ryuo.STR.hands,
    	neck="Caro Necklace",
    	waist="Moonbow Belt",})
	sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
	sets.precast.WS["Raging Fists"].FullAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFullAcc)


	sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {})
	sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
	sets.precast.WS["Howling Fist"].FullAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFullAcc)


	sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {})
	sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
	sets.precast.WS["Asuran Fists"].FullAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFullAcc)


	sets.precast.WS['Ascetic\'s Fury']  = set_combine(sets.precast.WS, {
    	hands=augmented_gear.Ryuo.STR.hands,
	    legs="Hesychast's Hose +3",
    	neck="Caro Necklace",
	    ring2="Begrudging Ring",
	    back=augmented_gear.capes.str_crit,
	})
	sets.precast.WS['Ascetic\'s Fury'].Impetus = {
		body= "Bhikku's Cyclas +1",}
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], {
		feet="Mummu Gamash. +2"})
	sets.precast.WS['Ascetic\'s Fury'].Acc.Impetus = {
		body= "Bhikku's Cyclas +1",}
	sets.precast.WS["Ascetic's Fury"].FullAcc = set_combine(sets.precast.WS["Ascetic's Fury"], {
		head="Mummu Bonnet +2",
		})
	sets.precast.WS['Ascetic\'s Fury'].FullAcc.Impetus = {
		body= "Bhikku's Cyclas +1",}



	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {
    	hands=augmented_gear.Ryuo.STR.hands,
    	body="Kendatsuba Samue",
	    legs="Hesychast's Hose +3",
    	feet=augmented_gear.Herculean.CritDMG.STR.feet,
    	neck="Caro Necklace",
	    back=augmented_gear.capes.str_crit,})
	sets.precast.WS["Victory Smite"].Impetus = {
		body="Bhikku Cyclas +1",}
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], {
		feet="Mummu Gamash. +2"})
	sets.precast.WS["Victory Smite"].Acc.Impetus = {
		body="Bhikku Cyclas +1",}
	sets.precast.WS["Victory Smite"].FullAcc = set_combine(sets.precast.WS["Victory Smite"], {
		head="Mummu Bonnet +2"})
	sets.precast.WS["Victory Smite"].FullAcc.Impetus = {
		body="Bhikku Cyclas +1",}


	sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {
		neck="Caro Necklace",
	    legs="Hesychast's Hose +3",
		ear2='Mache Earring +1',
	    back=augmented_gear.capes.dex_da,
	})
	sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
	sets.precast.WS["Shijin Spiral"].FullAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFullAcc)


	sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {
	})
	sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
	sets.precast.WS["Dragon Kick"].FullAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFullAcc)


	sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {
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
	    ear1="Moonshade Earring",
	    ear2="Friomisi Earring",
	    ring1="Archon Ring",
	    ring2="Acumen Ring",
	    back=augmented_gear.capes.str_wsd,
	}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring",ear2="Sherida Earring",}
	sets.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}
	

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum",
		neck="Loricate Torque +1",
		ear1="Odnowa earring +1",
		ear2="Hearty Earring",
		head="kendatsuba Jinpachi",
		body="Hesychast's Cyclas +3",
		hands="Kurys gloves",
		ring1="Defending Ring",
		ring2="Paguroidea ring",
		legs="Mummu Kecks +2",
	    back=augmented_gear.capes.tp_da,
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
		body="Hesychast's Cyclas +3",
		hands="Rao Kote +1",
		legs="Hesychast's Hose +3",
		feet="Herald's Gaiters",
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
	    back=augmented_gear.capes.tp_counter,
	}
	-- Normal melee sets
	sets.engaged =  {
		ammo="Ginsen",
        head=augmented_gear.Adhemar.Atk.head,
        body="kendatsuba Samue",
        hands=augmented_gear.Adhemar.Atk.hands,
	    legs="Hesychast's Hose +3",
    	feet="Anchorite's Gaiters +3",
	    neck="Moonbeam Nodowa",
	    waist="Moonbow Belt",
	    ear1="Sherida Earring",
	    ear2="Telos Earring",
	    ring1="Epona's Ring",
	    ring2="Niqmaddu Ring",
	    back=augmented_gear.capes.tp_da,}
	sets.engaged.Impetus = {body="Bhikku Cyclas +1"}
	sets.engaged.Reikikon = set_combine(sets.engaged, {
		legs="Samnuha Tights",
    	feet=augmented_gear.Herculean.TA.feet,})
	sets.engaged.Acc = set_combine(sets.engaged, {
	    head="kendatsuba Jinpachi",
	    })
	sets.engaged.Acc.Impetus = {body="Bhikku Cyclas +1"}
	sets.engaged.Acc.Reikikon = set_combine(sets.engaged.Acc, {
		legs="Samnuha Tights",
    	feet=augmented_gear.Herculean.TA.feet,})
	sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
	    ammo="Falcon Eye",
	    body="Mummu Jacket +2",
	    hands="Mummu Wrists +2",
	    ear1="Mache Earring +1",
	    ring1="Regal Ring",
	})
	sets.engaged.FullAcc.Impetus = {body="Bhikku Cyclas +1"}

	-- Defensive melee hybrid sets
	sets.engaged.PDT = {}
	sets.engaged.Acc.PDT = {}
	sets.engaged.FullAcc.PDT = {}
	sets.engaged.PDTOnly = {}
	sets.engaged.Acc.PDTOnly = {}
	sets.engaged.FullAcc.PDTOnly = {}

	-- Hundred Fists/Impetus melee set mods
	
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})
	sets.engaged.FullAcc.HF = set_combine(sets.engaged.FullAcc, {})

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	--sets.buff.Impetus = {body="Bhikku Cyclas +1"}
	sets.buff.Footwork = {} -- feet="Shukuyu Sune-Ate"
	
	sets.FootworkWS = {feet="Shukuyu Sune-Ate"}
	sets.DayIdle = {}
	sets.NightIdle = {}
    sets.Knockback = {}
	sets.Skillchain = {}
	
	-- Weapons sets
	--sets.weapons.Godhands = {main="Jolt Counter"}
	sets.weapons.Verethragna = {main="Verethragna"}
	sets.weapons.JoltCounters = {main="Jolt Counter"}
	sets.weapons.Staff = {main="Reikikon",sub="Niobid Strap"}
	sets.weapons.Barehanded = {main=empty}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(3, 1)

	windower.chat.input:schedule(1,'/lockstyleset 1')
end