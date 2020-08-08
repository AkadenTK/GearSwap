
    include('smartcure.lua')
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Accuracy')
    state.HybridMode:options('Normal', 'DTLite', 'FullDT')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'TPEat','DTHippo')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('CroceaDaybreak','CroceaTernion','NaeglingThibron','NaeglingTauret','NaeglingUllr','TauretThibron','TauretTernion','Odin','Nuking','NukingShield','Domain','None')
    state.EnhancingMode = M('Always', 'Never', '300', '1000')
    state.EnfeeblingMode = M('Never', 'Always','300', '1000')
    state.NukingMode = M('Never', 'Always','300', '1000')
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = "Toro Cape"
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = "Toro Cape"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

    enhancing_spells = T{'Aquaveil', 'Stoneskin', 'Protect', 'Shell', 'Temper', 'Temper II', 
                         'Enthunder', 'Enstone', 'Enaero', 'Enblizzard', 'Enfire', 'Enwater', 'Enthunder II', 'Enstone II', 'Enaero II', 'Enblizzard II', 'Enfire II', 'Enwater II', 
                         'Gain-STR', 'Gain-DEX', 'Gain-AGI', 'Gain-VIT', 'Gain-INT', 'Gain-MND', 'Gain-CHR',}
		-- Additional local binds
	--send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	--send_command('bind ^@!` input /ja "Accession" <me>')
	--send_command('bind ^backspace input /ja "Saboteur" <me>')
	--send_command('bind !backspace input /ja "Spontaneity" <t>')
	--send_command('bind @backspace input /ja "Composure" <me>')
	--send_command('bind @f8 gs c toggle AutoNukeMode')
	--send_command('bind != input /ja "Penury" <me>')
	--send_command('bind @= input /ja "Parsimony" <me>')
	--send_command('bind ^delete input /ja "Dark Arts" <me>')
	--send_command('bind !delete input /ja "Addendum: Black" <me>')
	--send_command('bind @delete input /ja "Manifestation" <me>')
	--send_command('bind ^\\\\ input /ma "Protect V" <t>')
	--send_command('bind @\\\\ input /ma "Shell V" <t>')
	--send_command('bind !\\\\ input /ma "Reraise" <me>')
	--send_command('bind @f10 gs c cycle RecoverMode')
	
	select_default_macro_book()
end

function init_gear_sets()

    augmented_gear.capes = {}
    augmented_gear.capes.dex_crit = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
    augmented_gear.capes.str_wsd = { name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    augmented_gear.capes.mnd_wsd = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
    augmented_gear.capes.stp = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    augmented_gear.capes.mnd_macc = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20',}}
    augmented_gear.capes.int_mab = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    augmented_gear.capes.int_macc = augmented_gear.capes.int_mab
    augmented_gear.capes.dw ={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Dual Wield"+10','Phys. dmg. taken-10%',}}

	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = { 
        ammo="Impatiens",           -- qc 2
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, -- 14
        body="Vitiation Tabard +3", -- 15
        hands="Leyline Gloves",     -- 8
        legs="Psyloth Lappas",      -- 7
        feet="Carmine Greaves +1",  -- 8
        neck="Loricate torque +1",
        back=augmented_gear.capes.stp,
        waist="Witful Belt",        -- 3, qc 3
        right_ear="Ethereal earring",
        left_ear="Eabani earring",
        left_ring="Weatherspoon Ring", -- 5
        right_ring="Lebeche Ring",  -- qc 3
    }
    sets.precast.FC['CroceaDaybreak'] = set_combine(sets.precast.FC, {
        body="Malignance Tabard",
        hands="Malignance gloves",
        legs="Malignance Tights",
    })
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        ammo="Regal Gem",
        head='Vitiation Chapeau +3',
        body="Shamash Robe",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear="Regal Earring",
        left_ring="Ilabrat Ring",
        right_ring="Stikini Ring +1",
        back=augmented_gear.capes.mnd_macc,
    })
	
	sets.precast.WS['Chant Du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Jukukik Feather",
        head=augmented_gear.Taeon.Crit.head,
        body="Ayanmo Corazza +2",
        hands="Malignance Gloves",
        legs=augmented_gear.Taeon.TP.legs,
        feet="Thereoid Greaves",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear="Mache Earring +1",
        left_ring="Ilabrat Ring",
        right_ring="Begrudging Ring",
        back=augmented_gear.capes.dex_crit,
    })

	sets.precast.WS['Savage Blade'] = {
        ammo="Aurgelmir orb +1",
        head="Vitiation Chapeau +3",
        body="Vitiation Tabard +3",
        hands="Atrophy gloves +3",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Dualist's Torque +1",
        waist="Sailfi Belt +1",
        left_ear="Ishvara Earring",
        right_ear="Moonshade Earring",
        left_ring="Rufescent Ring",
        right_ring="Epaminondas's ring",
        back=augmented_gear.capes.str_wsd,
    }

    sets.precast.WS['Savage Blade'].CappedAttack = set_combine(sets.precast.WS['Savage Blade'], {
    })
        
    sets.precast.WS['Sanguine Blade'] = {
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body="Amalric Doublet +1",
        hands="Jhakri Cuffs +2",
        legs="Amalric Slops +1",
        feet="Vitiation Boots +3",
        neck="Baetyl Pendant",
        waist="Orpheus's sash",
        left_ear="Regal Earring",
        right_ear="Malignance earring",
        left_ring="Archon Ring",
        right_ring="Epaminondas's ring",
        back=augmented_gear.capes.mnd_wsd,
    }
    sets.precast.WS['Sanguine Blade'].Accuracy = set_combine(sets.precast.WS['Sanguine Blade'], {
        legs=augmented_gear.Merlinic.Damage.legs,
    })

        
    sets.precast.WS['Seraph Blade'] = {
        ammo="Pemphredo Tathlum",
        head="Cath palug crown",
        body="Amalric Doublet +1",
        hands="Jhakri Cuffs +2",
        legs="Amalric Slops +1",
        feet="Vitiation Boots +3",
        --neck="Fotia Gorget",
        --waist="Fotia Belt",
        neck="Baetyl Pendant",
        waist="Orpheus's sash",
        left_ear="Moonshade Earring",
        right_ear="Malignance earring",
        left_ring="Freke Ring",
        right_ring="Weatherspoon Ring",
        back=augmented_gear.capes.mnd_wsd,
    }
    sets.precast.WS['Seraph Blade'].Accuracy = set_combine(sets.precast.WS['Seraph Blade'], {
        legs=augmented_gear.Merlinic.Damage.legs,
    })

    sets.precast.WS['Black Halo'] = {
        ammo="Regal Gem",
        head="Vitiation Chapeau +3",
        body="Vitiation Tabard +3",
        hands="Atrophy gloves +3",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Dualist's Torque +1",
        waist="Sailfi Belt +1",
        left_ear="Regal Earring",
        right_ear="Moonshade Earring",
        left_ring="Rufescent Ring",
        right_ring="Epaminondas's ring",
        back=augmented_gear.capes.mnd_wsd,
    }

    sets.precast.WS['Empyreal Arrow'] = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Fotia Gorget",
        waist="Yemaya Belt",
        left_ear="Suppanomimi",
        right_ear="Telos Earring",
        left_ring="Cacoethic Ring +1",
        right_ring="Rufescent Ring",
    }

    sets.precast.WS['Aeolian Edge'] = {
        --ammo="Pemphredo Tathlum",
        --head="Cath palug crown",
        --body=augmented_gear.Merlinic.Damage.body,
        --hands="Jhakri Cuffs +2",
        --legs="Amalric Slops +1",
        --feet=augmented_gear.Merlinic.Damage.feet,
        --neck="Baetyl Pendant",
        --waist="Refoccilation Stone",
        --left_ear="Regal Earring",
        --right_ear="Malignance earring",
        --left_ring="Freke Ring",
        --right_ring="Epaminondas's ring",
        --back=augmented_gear.capes.int_mab,
    }

	
	-- Midcast Sets

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1",waist="Chaac Belt",legs="Volte Hose",feet="Volte Boots"})
	
	
	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Earth = {neck="Quanpur Necklace"}

	sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
        ammo="Regal Gem",
        head="Viti. Chapeau +3",
        body="Shamash Robe",
        hands="Telchine Gloves",
        legs="Atrophy Tights +2",
        feet="Medium's Sabots",
        neck="Nodens Gorget",
        waist="Emphatikos Rope",-- sp. intr. rate.
        left_ear="Mendi. Earring",
        right_ear="Regal Earring",
        left_ring="Stikini Ring +1",
        right_ring="Weather. Ring",
        back="Solemnity Cape",
    }
		
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {})
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {head="Amalric Coif +1", waist="Gishdubar Sash"}

	sets.midcast['Enhancing Magic'] = {
        main='Crocea Mors',
        sub='Ammurapi Shield',
        head=augmented_gear.Telchine.Enhancing.head,
        body="Vitiation Tabard +3",
        hands="Atrophy gloves +3",
        legs="Carmine Cuisses +1",
        feet="Leth. Houseaux +1",
        neck="Dls. Torque +1",
        waist="Embla Sash",
        left_ear="Halasz Earring",
        right_ear="Andoaa Earring",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring +1",
        back="Ghostfyre Cape",
    }

    sets.enhancing_skill = set_combine(sets.midcast['Enhancing Magic'], {
        main="Pukulatmuj +1",
        sub="Pukulatmuj",
        head="Befouled Crown",
        hands="Vitiation gloves +3",
        legs="Atrophy Tights +2",
        neck="Incanter's Torque",
        waist="Olympus sash",
        --waist="Embla Sash",
        left_ear="Mimir Earring",
        right_ear="Andoaa Earring",
    })

    sets.midcast.Phalanx = set_combine(sets.enhancing_skill, {
        head=augmented_gear.Taeon.Phalanx.head,
        body=augmented_gear.Taeon.Phalanx.body,
        hands=augmented_gear.Taeon.Phalanx.hands,
        feet=augmented_gear.Taeon.Phalanx.feet,
        waist="Embla Sash",
    })

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.		
	sets.buff.ComposureOther = set_combine(sets.midcast['Enhancing Magic'], {head="Telchine Cap",body="Lethargy Sayon +1",hands="Atrophy gloves +3",legs="Lethargy Fuseau +1",feet="Leth. Houseaux +1",})
		
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1", waist="Gishdubar Sash",legs="Leth. Fuseau +1"})
	sets.midcast.Aquaveil = set_combine(sets.enhancing_skill, {head="Amalric Coif +1", waist="Emphatikos Rope"})
	sets.midcast.BarElement = set_combine(sets.enhancing_skill, {})
    sets.midcast.Stoneskin = set_combine(sets.enhancing_skill, {neck="Nodens Gorget",waist="Siegel Sash"})
	sets.midcast.BoostStat = set_combine(sets.enhancing_skill, {})
	sets.midcast.Protect = {right_ring="Sheltered Ring"}
	sets.midcast.Shell = {right_ring="Sheltered Ring"}
    sets.midcast.Temper = set_combine(sets.enhancing_skill, {})
    sets.midcast["Temper II"] = sets.midcast.Temper
	
	sets.midcast['Enfeebling Magic'] = {
        main="Crocea Mors",
        sub="Daybreak",
        ammo="Regal Gem",
        head="Vitiation Chapeau +3",
        body="Lethargy Sayon +1",
        hands="Leth. Gantherots +1",
        legs=augmented_gear.Chironic.Macc.MND.legs,
        feet="Vitiation Boots +3",
        neck="Duelist's torque +1",
        waist="Eschan Stone",
        left_ear="Snotra Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring +1",
        right_ring="Kishar Ring",
        back=augmented_gear.capes.mnd_macc,
    }
    sets.midcast['Enfeebling Magic']['NukingMode'] = set_combine(sets.midcast['Enfeebling Magic'], {main='Daybreak',sub='Nibiru Cudgel'})
    sets.midcast['Enfeebling Magic']['NukingShield'] = set_combine(sets.midcast['Enfeebling Magic'], {main='Daybreak',sub='Ammurapi Shield'})

		
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
        ranged="Ullr",
        ammo="Demon Arrow",
        body="Amalric doublet +1",
    })
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
        back=augmented_gear.capes.int_macc,
        legs=augmented_gear.Chironic.Macc.INT.legs,
    })
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
        back=augmented_gear.capes.int_macc,
        legs=augmented_gear.Chironic.Macc.INT.legs,
    })

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast['Distract III'] = set_combine(sets.midcast.MndEnfeebles, {hands="Leth. Gantherots +1",right_ring="Stikini Ring +1"})
	sets.midcast['Distract III'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {})
    sets.midcast['Frazzle III'] = set_combine(sets.midcast.MndEnfeebles, {hands="Leth. Gantherots +1",right_ring="Stikini Ring +1"})
    sets.midcast['Frazzle III'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {})

    sets.midcast['Frazzle II'] = set_combine(sets.midcast.MndEnfeebles.Resistant, {hands="Leth. Gantherots +1",right_ring="Stikini Ring +1"})
    sets.midcast['Frazzle II'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +3"})
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +3"})

	sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +3"})
	sets.midcast['Slow II'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Viti. Chapeau +3"})

    -- Gear that converts elemental damage done to recover MP.  
    sets.RecoverMP = {body="Seidr Cotehardie"}
    
    -- Gear for Magic Burst mode.
    sets.MagicBurst = {
        head="Ea Hat",
        body="Ea Houppelande",
        neck="Mizu. Kubikazari",
        hands="Amalric Gages +1",
        right_ring="Mujin Band",
        legs=augmented_gear.Merlinic.Burst.legs,
        feet="Jhakri Pigaches +2"
    }
    sets.RecoverBurst = set_combine(sets.MagicBurst, {})
	
    sets.midcast['Elemental Magic'] = {
        main="Maxentius",
        sub="Daybreak",
        ammo="Pemphredo Tathlum",
        head="Cath palug crown",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
        legs="Amalric Slops +1",
        feet="Amalric Nails +1",
        neck="Baetyl Pendant",
        waist=gear.ElementalObi,
        left_ear="Regal Earring",
        right_ear="Malignance Earring",
        left_ring="Freke Ring",
        right_ring="Shiva Ring +1",
        back=augmented_gear.capes.int_mab,
    }
		
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        feet="Vitiation Boots +3",
        left_ear="Heretic Earring",
        left_ring="Stikini Ring +1",
    })

    sets.midcast['Elemental Magic'].Proc = {}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
		
	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {head=empty,body="Twilight Cloak",back=augmented_gear.capes.int_macc,})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {head=empty,body="Twilight Cloak",back=augmented_gear.capes.int_macc,})

    sets.midcast.Drain = set_combine(sets.midcast['Elemental Magic'], {
        head="Pixie Hairpin +1",
        left_ring="Archon Ring",
        right_ring="Evanescence Ring",
    })

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = set_combine(sets.midcast['Enfeebling Magic'], {})
		
	sets.midcast.Stun.Resistant = {}

	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = {hands="Leth. Gantherots +1"}
	
	sets.HPDown = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.

	-- Engaged sets

	sets.engaged = {
        ammo="Aurgelmir orb +1",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        legs="Malignance tights",
        hands="Malignance Gloves",
        feet="Malignance Boots",
        neck="Anu Torque",
        waist="Windbuffet Belt +1",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        left_ring="Ilabrat Ring",
        right_ring="Hetairoi Ring",
        back=augmented_gear.capes.stp,
    }

	sets.engaged.DW = set_combine(sets.engaged, {
        back=augmented_gear.capes.dw,
    })

    sets.engaged.DW.Enspell = set_combine(sets.engaged.DW, {
        hands="Ayanmo Manopolas +2",
    })

    sets.engaged['CroceaDaybreak'] = set_combine(sets.engaged.DW, {
        hands="Ayanmo Manopolas +2",
        waist="Orpheus's Sash",
    })
    sets.engaged['CroceaTernion'] = sets.engaged['CroceaDaybreak']

    sets.engaged['Odin'] = set_combine(sets.engaged.DW.Enspell, {
        head="Carmine Mask +1",
        body="Ayanmo Corazza +2",
        legs="Carmine Cuisses +1",
        --feet=augmented_gear.Taeon.TP.feet,
        neck="Dls. Torque +1",
        --left_ear="Eabani earring",
        --right_ear="Suppanomimi",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring +1",
        waist="Orpheus's sash",
    })
        
    sets.engaged.DTLite = set_combine(sets.engaged, {
        neck="Loricate Torque +1",
        right_ring="Defending Ring",
    })
        
    sets.engaged.DTLite.DW = set_combine(sets.engaged.DW, {
        neck="Loricate Torque +1",
        right_ring="Defending Ring",
    })

    sets.engaged.DTLite.DW.Enspell = set_combine(sets.engaged.DTLite.DW, {
        hands="Ayanmo Manopolas +2",
    })

    sets.engaged['CroceaDaybreak'].DTLite = set_combine(sets.engaged.DTLite.DW, {
        hands="Ayanmo Manopolas +2",
        waist="Orpheus's Sash",
    })
    sets.engaged['CroceaTernion'].DTLite = sets.engaged['CroceaDaybreak'].DTLite
        
    sets.engaged.FullDT = set_combine(sets.engaged.DTLite, {})
        
    sets.engaged.FullDT.DW = set_combine(sets.engaged.DTLite.DW, {})

    sets.engaged['CroceaDaybreak'].FullDT = set_combine(sets.engaged.FullDT.DW, {
        hands="Ayanmo Manopolas +2",
        waist="Orpheus's Sash",
    })
    sets.engaged['CroceaTernion'].FullDT = sets.engaged['CroceaDaybreak'].FullDT


    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = set_combine(sets.engaged.DW, {
        ammo="Homiliary",
        head="Vitiation Chapeau +3",
        body="Shamash Robe",
        hands="Malignance Gloves",
        neck="Loricate Torque +1",
        waist="Flume belt",
        legs="Malignance Tights",
        feet="Malignance Boots",
        left_ear="Ethereal earring",
        right_ear="Hearty earring",
        left_ring="Sheltered ring",
        right_ring="Defending Ring",
    })
        
    sets.idle.PDT = set_combine(sets.idle, {})
        
    sets.idle.MDT = set_combine(sets.idle, {})
        
    sets.idle.Weak = set_combine(sets.idle, {})
    
    sets.idle.DTHippo = set_combine(sets.idle.PDT, {})
    sets.idle.Town = set_combine(sets.idle, {
        hands="Vitiation Gloves +3",
        legs="Carmine Cuisses +1",
        feet="Vitiation Boots +3",
        waist="Orpheus's sash",
    })
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.NukeLock = sets.midcast['Elemental Magic']
        
    sets.defense.MDT = {}
        
    sets.defense.MEVA = {}
        
    sets.idle.TPEat = set_combine(sets.idle, {})

    sets.Kiting = {legs="Carmine Cuisses +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    sets.DayIdle = {}
    sets.NightIdle = {}
    
    -- Weapons sets
    sets.weapons.CroceaDaybreak = {main="Crocea Mors", sub="Daybreak", }
    sets.weapons.CroceaTernion = {main="Crocea Mors", sub="Ternion Dagger +1", }
    sets.weapons.NaeglingThibron = {main="Naegling", sub="Thibron", }
    sets.weapons.NaeglingTernion = {main="Naegling", sub="Ternion Dagger +1", }
    sets.weapons.NaeglingTauret = {main="Naegling", sub="Tauret", }
    sets.weapons.NaeglingUllr = {main="Naegling", sub="Tauret", range="Ullr", ammo="Demon Arrow"}
    sets.weapons.Domain = {main="Naegling", sub="Daybreak", range="Ullr", ammo="Demon Arrow"}
    sets.weapons.TauretThibron = {main="Tauret", sub="Thibron", range="Ullr", ammo="Demon Arrow"}
    sets.weapons.TauretTernion = {main="Tauret", sub="Ternion Dagger +1"}
    sets.weapons.Odin = {main='Ceremonial Dagger',sub="Ceremonial Dagger", range="Ullr", ammo="Demon Arrow"}
    sets.weapons.Nuking = {main='Maxentius',sub="Daybreak"}
    sets.weapons.NukingShield = {main='Daybreak',sub="Ammurapi Shield"}

end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	set_macro_page(1, 19)

    if player.sub_job == 'NIN' then
        windower.chat.input:schedule(1,'/lockstyleset 84')
    else
        windower.chat.input:schedule(1,'/lockstyleset 84')
    end
end

function user_job_precast(spell, spellMap, eventArgs)
    if state.smartcure and spell.english:lower() == 'cure' then
        state.smartcure = false
        eventArgs.cancel = true
        smartcure_target(spell.target.name)     
    end
    state.smartcure = false

end

function user_job_aftercast(spell, spellMap, eventArgs)
    if ((spell.skill == 'Enhancing Magic' and enhancing_spells:contains(spell.english) and state.EnhancingMode.value ~= 'Never') or 
       ((spell.skill == 'Enfeebling Magic' or spell.en == 'Impact') and state.EnfeeblingMode.value ~= 'Never') or
        (spell.skill == 'Elemental Magic' and state.NukingMode.value ~= 'Never')) then
        enable('main')
        enable('sub')
        enable('ranged')
        enable('range')
        enable('ammo')
        for slot,piece in pairs(sets.weapons[state.Weapons.Value]) do
            local s = {}
            s[slot] = sets.weapons[state.Weapons.Value][slot]
            equip(s)
            disable(slot)
        end
    end
end

function user_job_post_precast(spell, spellMap, eventArgs)
    if ((spell.skill == 'Enhancing Magic' and enhancing_spells:contains(spell.english) and state.EnhancingMode.value ~= 'Never' and (state.EnhancingMode.value == 'Always' or tonumber(state.EnhancingMode.value) > player.tp)) or 
       ((spell.skill == 'Enfeebling Magic' or spell.en == 'Impact') and state.EnfeeblingMode.value ~= 'Never' and (state.EnfeeblingMode.value == 'Always' or tonumber(state.EnfeeblingMode.value) > player.tp)) or
        (spell.skill == 'Elemental Magic' and state.NukingMode.value ~= 'Never' and (state.NukingMode.value == 'Always' or tonumber(state.NukingMode.value) > player.tp))) then
        enable('main')
        enable('sub')
        enable('ranged')
        enable('range')
        enable('ammo')
    end
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