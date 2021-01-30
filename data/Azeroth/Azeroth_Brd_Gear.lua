function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant','AoE')
    state.IdleMode:options('Normal','NoRefresh','DT')
	state.Weapons:options('None','Aeneas','DWAeneasTPBonus','DWAeneasTernion')

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Genmei Shield"}
	sets.weapons.DWAeneasTPBonus = {main="Aeneas",sub="Fusetto +2"}
	sets.weapons.DWAeneasTernion = {main="Aeneas",sub="Blurred Knife +1"}

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}


	augmented_gear.Linos = {
	    cure={ name="Linos", augments={'"Cure" potency +4%','MND+7',}},
	    stp={ name="Linos", augments={'Accuracy+14','"Store TP"+4','Quadruple Attack +3',}},
	    dex_wsd={ name="Linos", augments={'Attack+15','Weapon skill damage +3%','DEX+8',}},
	}
	augmented_gear.Capes = {}
	augmented_gear.Capes.macc = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
	augmented_gear.Capes.fc = augmented_gear.Capes.macc
	augmented_gear.Capes.stp = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}}
	augmented_gear.Capes.rudra = augmented_gear.Capes.stp

	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		main="Kali",
		sub="Genmei Shield",
		--ammo="Impatiens",
		head="Nahtirah Hat",
		body="Inyanga Jubbah +2",
		hands="Leyline Gloves",
		legs="Aya. Cosciales +2",
		feet="Kaykaus boots +1",
		--neck="Loricate Torque +1",
		neck="Voltsurge Torque",
		--left_ear="Enchntr. Earring +1",
		--right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
		back=augmented_gear.Capes.fc,
		waist="Witful Belt",
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Kaykaus Bliaut +1",feet="Vanya Clogs"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	sets.precast.FC.BardSong = set_combine(sets.precast.FC,{
		range="Gjallarhorn",
		ammo=empty,
		head="Fili Calot +1",
		feet="Telchine Pigaches",
	})

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Daurdabla"})
	sets.precast.FC.Lullaby = {range="Marsyas"}
	sets.precast.FC.Lullaby.Resistant = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby II'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Daurdabla"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps +1"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}
	sets.precast.WS["Rudra's Storm"] = {
		range=augmented_gear.Linos.dex_wsd,
	    head="Lustratio Cap +1",
	    body="Ayanmo Corazza +2",
	    hands="Lustr. Mittens +1",
	    legs="Lustr. Subligar +1",
	    feet="Lustra. Leggings +1",
	    neck="Caro Necklace",
	    waist="Chiner's Belt +1",
	    left_ear="Moonshade Earring",
	    right_ear="Ishvara Earring",
	    left_ring="Karieyh Ring",
	    right_ring="Ilabrat Ring",
	    back=augmented_gear.Capes.rudra,
	}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {left_ear="Ishvara Earring",right_ear="Telos Earring",}
	sets.AccMaxTP = {left_ear="Mache Earring +1",right_ear="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
	sets.midcast.Lullaby = {range="Marsyas"}
	sets.midcast.Lullaby.Resistant = {range="Daurdabla"}
	sets.midcast['Horde Lullaby'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Daurdabla"}
	sets.midcast['Horde Lullaby'].AoE = {range="Daurdabla"}
	sets.midcast['Horde Lullaby II'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Daurdabla"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Daurdabla"}
	sets.midcast.Madrigal = {head="Fili Calot +1"}
	sets.midcast.Paeon = {}
	sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {body="Fili Hongreline +1"}
	sets.midcast.Minne = {}
	sets.midcast.Carol = {}
	sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
	sets.midcast['Magic Finale'] = {range="Daurdabla"}
	sets.midcast.Mazurka = {range="Marsyas"}
	--sets.midcast["Knight's Minne"] = {}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
    	main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
		sub="Genmei Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +2",
		neck="Moonbow Whistle +1",

	}
		
	--sets.midcast.SongEffect.DW = set_combine(sets.midcast.SongEffect, {
	--	sub="Kali",
	--})

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
		main="Tauret",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands="Inyanga Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +2",
		neck="Moonbow Whistle +1",
		left_ear="Regal Earring",
		right_ear="Dignitary Earring",
		left_ring="Stikini Ring",
		waist="Ovate Rope",
		--back=
	}
		
	sets.midcast.SongDebuff.DW = set_combine(sets.midcast.SongDebuff, {})

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = set_combine(sets.midcast.SongDebuff, {})

	-- Song-specific recast reduction
	sets.midcast.SongRecast = set_combine(sets.precast.FC, {})
		
	sets.midcast.SongDebuff.DW = set_combine(sets.midcast.SongRecast, {})

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})
    sets.midcast.DaurdablaDummy.DW = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})
	sets.midcast["Knight's Minne"] = sets.midcast.DaurdablaDummy
	sets.midcast["Knight's Minne"].DW = sets.midcast.DaurdablaDummy
	sets.midcast["Knight's Minne II"] = sets.midcast.DaurdablaDummy
	sets.midcast["Knight's Minne II"].DW = sets.midcast.DaurdablaDummy

	-- Other general spells and classes.
	sets.midcast.Cure = {
		main="Daybreak",
		sub="Ammurapi Shield",
	    range=augmented_gear.Linos.cure,
	    head=augmented_gear.Kaykaus.C.head,
	    body=augmented_gear.Kaykaus.B.body,
	    hands="Inyanga Dastanas +2",
	    legs="Vanya Slops",
	    feet="Vanya Clogs",
	    left_ear="Meili earring",
	    right_ear="Regal Earring",
	    left_ring="Menelaus's Ring",
	    right_ring="Sirona's Ring",}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	--sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	--sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	--sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] = {
		main="Pukulatmuj +1",
		sub="Ammurapi Shield",
		head="Telchine Cap",
		body="Telchine Chas.",
		hands="Telchine Gloves",
		legs="Telchine Braconi",
		feet="Telchine Pigaches",
		neck="Voltsurge Torque",
		left_ear="Andoaa Earring",
		right_ear="Mimir Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Intarabus's Cape",
		waist="Embla Sash",
	}
		
	--sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",right_ear="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
		
	sets.midcast['Elemental Magic'] = {}
		
	sets.midcast['Elemental Magic'].Resistant = {}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",left_ring="Haoma's Ring",right_ring="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	-- Resting sets
	--sets.resting = {main="Chatoyant Staff",sub="Oneiros Grip",}
	
	sets.idle = {
    	main={ name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}},
		sub="Genmei Shield",
		range="Gjallarhorn",
		head="Inyanga Tiara +2",
		body="Kaykaus Bliaut +1",
		hands="Inyanga Dastanas +2",
		legs="Assiduity Pants +1",
		feet="Inyanga Crackows +2",
		neck="Twilight Torque",
		left_ring="Defending Ring",
		right_ring="Inyanga Ring",
	}
		
	sets.idle.NoRefresh = {}

	sets.idle.DT = {}
	
	-- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.Kiting = {feet="Fili Cothurnes +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {
		range=augmented_gear.Linos.stp,
		head="Aya. Zucchetto +2",
	    body="Ayanmo Corazza +2",
	    hands="Aya. Manopolas +2",
	    legs="Aya. Cosciales +2",
	    feet="Aya. Gambieras +2",
	    neck="Ainia Collar",
	    waist="Kentarch Belt +1",
	    left_ear="Suppanomimi",
	    right_ear="Eabani Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Petrov Ring",
	    back=augmented_gear.Capes.stp,
	}
	sets.engaged.Acc = {}
	sets.engaged.DW = set_combine(sets.engaged, {})
	sets.engaged.DW.Acc = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(10, 10)

    windower.chat.input:schedule(1,'/lockstyleset 8')
end