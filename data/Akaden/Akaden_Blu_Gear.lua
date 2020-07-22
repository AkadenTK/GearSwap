
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal', 'Atk_Cap','Acc','BigAcc','FullAcc','None')
	state.HybridMode:options('Normal','DTLite','DTMid','DT')
    state.WeaponskillMode:options('Match','Normal','Acc','BigAcc','FullAcc','Fodder')
    state.CastingMode:options('Normal','Resistant','Enmity')
    state.IdleMode:options('Normal', 'DT','Refresh', 'DTKite')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	--state.Weapons:options('Default','SavageBlade','MagicWeapons','DDClubs', 'None')
	state.Weapons:options('SwordTP','SwordAcc','MagicWeapons','ClubTP', 'ClubAcc','None')


    state.AutoUnbridled.value = true

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'MP','SuppaBrutal', 'DWEarrings','DWMax'}

	gear.da_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.stp_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.crit_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.wsd_jse_back = {name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.mab_jse_back = {name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

	gear.obi_cure_waist = "Luminary Sash"
	gear.obi_nuke_waist = "Yamabuki-no-Obi"

	-- Additional local binds
	--send_command('bind ^` input /ja "Chain Affinity" <me>')
	--send_command('bind @` input /ja "Efflux" <me>')
	--send_command('bind !` input /ja "Burst Affinity" <me>')
	--send_command('bind ^@!` gs c cycle SkillchainMode')
	----send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	----send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	--send_command('bind @backspace input /ja "Convergence" <me>')
    --send_command('bind !f11 gs c cycle ExtraMeleeMode')
	--send_command('bind @f10 gs c toggle LearningMode')
	--send_command('bind ^@!` gs c cycle MagicBurstMode')
	--send_command('bind @f8 gs c toggle AutoNukeMode')
	--send_command('bind !@^f7 gs c toggle AutoWSMode')
	----send_command('bind !r gs c weapons MagicWeapons;gs c update')
	--send_command('bind @q gs c weapons MaccWeapons;gs c update')
	--send_command('bind ^q gs c weapons Almace;gs c update')
	--send_command('bind !q gs c weapons HybridWeapons;gs c update')

	update_combat_form()
	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

    augmented_gear.capes = {}
    augmented_gear.capes.stp = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    augmented_gear.capes.str_wsd = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10',}}
    augmented_gear.capes.mnd_wsd = augmented_gear.capes.str_wsd
    augmented_gear.capes.dex_crit = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20', 'DEX+10','Crit.hit rate+10',}}
    augmented_gear.capes.int_mab = { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
    augmented_gear.capes.FC = { name="Rosmerta's Cape", augments={'"Fast Cast"+10',}}

	sets.buff['Burst Affinity'] = {feet="Mavi Basmak +1"}
	sets.buff['Chain Affinity'] = {head="Mavi Kavuk +2", feet="Assimilator's Charuqs +1"}
	--sets.buff.Convergence = {head="Luh. Keffiyeh +1"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs +3"}
	sets.buff.Enchainment = {body="Luhlaza Jubbah"}
	sets.buff.Efflux = {back="Rosmerta's cape",legs="Hashishin Tayt +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.HPDown = {}


    sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands=augmented_gear.Herculean.TH.hands,legs="Volte Hose",feet="Volte Boots"})

    sets.dt = {
    	ammo="Staunch Tathlum +1",
    	head="Malignance Chapeau",
    	body="Malignance Tabard",
    	hands="Malignance gloves",
    	legs="Volte Hose",
    	feet="Volte Boots",
        neck="Loricate Torque +1",
        left_ear="Ethereal Earring",
        left_ring="Defending ring",
        right_ring="Warden's ring",
        waist="Flume belt",     
        back=augmented_gear.capes.stp,
	}

	sets.weapons = {}
	sets.weapons.SwordTP = {main="Tizona",sub="Thibron"}
    sets.weapons.SwordAcc = {main="Tizona",sub="Naegling"}
	--sets.weapons.SavageBlade = {main="Sequence",sub="Colada"}
	sets.weapons.MagicWeapons = {main="Maxentius", sub="Naegling"}
    sets.weapons.ClubTP = {main="Maxentius", sub="Thibron"}
	sets.weapons.ClubAcc = {main="Maxentius", sub="Naegling"}
	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +1"}

	sets.enmity = set_combine(sets.dt, {
		neck="Warder's charm +1",
		body="Emet Harness +1",
		left_ear="Friomisi earring",
		left_ring="Begrudging ring",
		right_ring="Eihwaz ring",
		waist="Kasiri Belt",
		legs="Dux Cuisses",
	})

	sets.precast.JA['Provoke'] = set_combine(sets.enmity, {})


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}

	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells

	sets.precast.FC = set_combine(sets.engaged, {
        head="Carmine Mask +1",
        body=augmented_gear.Adhemar.D.body,
        hands="Leyline gloves",
        legs="Psycloth lappas",
        feet="Carmine Greaves +1",
		ammo="Impatiens",
        neck="Baetyl pendant", 
        left_ear="Halasz earring", -- mp
        right_ear="Andoaa Earring", -- mp
        left_ring="Kishar ring",
        right_ring="Weatherspoon ring",
        back=augmented_gear.capes.FC,
        waist="Witful Belt",
    })

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga beads"})

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
        ammo="Jukukik feather",
    	head=augmented_gear.Herculean.WSD.STR.head,
        neck="Rancor collar",
        body="Assimilator's Jubbah +3",
        hands="jhakri cuffs +2",
        right_ear="Ishvara Earring",
        left_ear="Moonshade earring",
        back=augmented_gear.capes.str_wsd,
        waist="Fotia Belt",
        legs=augmented_gear.Herculean.WSD.STR.legs,
    	feet=augmented_gear.Herculean.WSD.STR.feet,
    }

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {})

	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})

	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
            head="Jhakri coronal +2",
            hands="jhakri cuffs +2",
            body="Assim. Jubbah +3",
            legs="Hashishin tayt +1",
            feet="Jhakri pigaches +2",
            left_ring="Stikini Ring +1",
            ammo="Hasty pinion +1"
	})
	sets.precast.WS['Requiescat'].SomeAcc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].HighAcc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})

	--sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {head="Jhakri Coronal +2",left_ear="Regal Earring",body="Jhakri Robe +2",right_ring="Rufescent Ring",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})
	--sets.precast.WS['Realmrazer'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Jhakri Coronal +2",left_ear="Regal Earring",right_ear="Telos Earring",body="Jhakri Robe +2",right_ring="Rufescent Ring",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})
	--sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc, {head="Jhakri Coronal +2",left_ear="Regal Earring",right_ear="Telos Earring",left_ring="Rufescent Ring",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})
	--sets.precast.WS['Realmrazer'].HighAcc = set_combine(sets.precast.WS.HighAcc, {left_ring="Rufescent Ring",feet="Jhakri Pigaches +2"}),
	--sets.precast.WS['Realmrazer'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	--sets.precast.WS['Realmrazer'].Fodder = set_combine(sets.precast.WS['Realmrazer'], {})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Jukukik feather",
        head=augmented_gear.Adhemar.Atk.head,
        body="Abnoba Kaftan",
        hands=augmented_gear.Adhemar.Atk.hands,
        legs=augmented_gear.Herculean.CritDMG.DEX.legs,
        feet="Thereoid Greaves",
        neck='Mirage Stole +2',
        right_ear="Odr earring",
        left_ring="Ilabrat Ring",
        right_ring="Begrudging ring",
        waist="Fotia Belt",
        back=augmented_gear.capes.dex_crit,
    })
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
		ammo="Falcon Eye",
		right_ear="Telos earring",
		feet="Ayanmo gambieras +2",
	})
    sets.precast.WS['Chant du Cygne'].BigAcc = set_combine(sets.precast.WS['Chant du Cygne'].Acc, {
        head="Malignance Chapeau",
        hands=augmented_gear.Adhemar.Acc.hands,
        left_ear="Regal Earring",
    })
    sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS['Chant du Cygne'].BigAcc, {
        body="Assimilator's Jubbah +3",
        left_ear="Regal Earring",
    })

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir orb +1",
    	head=augmented_gear.Herculean.WSD.STR.head,
        body="Assimilator's Jubbah +3",
        hands="jhakri cuffs +2",
        legs="Luhlaza Shalwar +3",
    	feet=augmented_gear.Herculean.WSD.STR.feet,
        neck='Mirage Stole +2',
        right_ear="Ishvara Earring",
        left_ring="Ilabrat ring",
        right_ring="Rufescent ring",
        waist="Sailfi Belt +1",
        back=augmented_gear.capes.str_wsd,
    })
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        right_ear="Regal Earring",
        right_ring="Rufescent ring",
        ammo="Falcon Eye",
    })
    sets.precast.WS['Savage Blade'].BigAcc = set_combine(sets.precast.WS['Savage Blade'].Acc, {
        neck="Subtlety Spectacles",
    })
    sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'].BigAcc, {
        head="Carmine Mask +1",
        legs="Carmine Cuisses +1",
        waist="Eschan Stone",
    })

	--sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1",left_ear="Cessance Earring", right_ear="Brutal Earring",right_ring="Begrudging Ring",back=gear.crit_jse_back,feet="Thereoid Greaves"})
	--sets.precast.WS['Vorpal Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet +1",right_ring="Begrudging Ring",back=gear.crit_jse_back})
	--sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {back=gear.crit_jse_back})
	--sets.precast.WS['Vorpal Blade'].HighAcc = set_combine(sets.precast.WS.HighAcc, {})
	--sets.precast.WS['Vorpal Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	--sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS['Vorpal Blade'], {})

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir orb +1",
    	head=augmented_gear.Herculean.WSD.STR.head,
        body="Assimilator's Jubbah +3",
        hands="Jhakri Cuffs +2",
        legs="Luhlaza Shalwar +3",
        feet=augmented_gear.Herculean.WSD.STR.feet,
        neck='Mirage Stole +2',
        right_ear="Ishvara Earring",
        left_ear="Moonshade earring",
        right_ring="Ifrit ring +1",
        left_ring="Epaminondas's ring",
        waist="Sailfi Belt +1",
        back=augmented_gear.capes.str_wsd,
    })
    sets.precast.WS['Expiacion'].Atk_Cap = set_combine(sets.precast.WS['Expiacion'], {
        head="Malignance Chapeau",
        right_ring="Metamorph Ring +1",
    })
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS['Expiacion'], {
        right_ear="Regal Earring",
        right_ring="Rufescent ring",
        ammo="Falcon Eye",
    })
    sets.precast.WS['Expiacion'].BigAcc = set_combine(sets.precast.WS['Expiacion'].Acc, {
        neck="Subtlety Spectacles",
    })
    sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS['Expiacion'].BigAcc, {
        head="Carmine Mask +1",
        legs="Carmine Cuisses +1",
        waist="Eschan Stone",
    })


	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir orb +1",
    	head=augmented_gear.Herculean.WSD.STR.head,
        body="Assimilator's Jubbah +3",
        hands="jhakri cuffs +2",
        legs="Luhlaza Shalwar +3",
    	feet=augmented_gear.Herculean.WSD.STR.feet,
        neck='Mirage Stole +2',
        left_ear="Moonshade earring",
        right_ear="Ishvara Earring",
        right_ring="Rufescent ring",
        left_ring="Epaminondas's ring",
        waist="Sailfi Belt +1",
        back=augmented_gear.capes.mnd_wsd,
    })
    sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {
        right_ear="Regal Earring",
        right_ring="Rufescent ring",
        ammo="Falcon Eye",
    })
    sets.precast.WS['Black Halo'].BigAcc = set_combine(sets.precast.WS['Black Halo'].Acc, {
        neck="Subtlety Spectacles",
    })
    sets.precast.WS['Black Halo'].FullAcc = set_combine(sets.precast.WS['Black Halo'].BigAcc, {
        head="Carmine Mask +1",
        legs="Carmine Cuisses +1",
        waist="Eschan Stone",
    })

    sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir orb +1",
        head=augmented_gear.Adhemar.Atk.head,
        body="Assimilator's Jubbah +3",
        hands="jhakri cuffs +2",
        legs="Luhlaza Shalwar +3",
        feet=augmented_gear.Herculean.WSD.STR.feet,
        neck="Fotia Gorget",
        left_ear="Regal earring",
        right_ear="Brutal Earring",
        right_ring="Rufescent ring",
        left_ring="Stikini Ring +1",
        waist="Fotia belt",
        back=augmented_gear.capes.mnd_wsd,
    })

	sets.precast.WS['Sanguine Blade'] = {
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body="Amalric Doublet +1",
        hands="Jhakri cuffs +2",
        legs="Luhlaza Shalwar +3",
        feet="Amalric Nails +1",
        neck="Baetyl pendant",
        left_ear="Friomisi earring",
        right_ear="Regal earring",
        left_ring="Epaminondas's ring",
        right_ring="Archon ring",
        waist="Eschan Stone",
        back=augmented_gear.capes.mnd_wsd,
    }

	--sets.precast.WS['Flash Nova'] = {ammo="Pemphredo Tathlum",
	--		         head="Jhakri Coronal +2",neck="Baetyl Pendant",left_ear="Regal Earring",right_ear="Friomisi Earring",
	--	             body="Jhakri Robe +2",hands="Jhakri Cuffs +2",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
	--		         back=gear.mab_jse_back,waist="Yamabuki-no-Obi",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	--sets.MaxTP = {left_ear="Cessance Earring",right_ear="Brutal Earring"}
	--sets.AccMaxTP = {left_ear="Cessance Earring",right_ear="Dignitary's Earring"}

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

    sets.midcast['Diaga'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

	sets.midcast['Blue Magic'] = {}

	-- Physical Spells --

	sets.midcast['Blue Magic'].Physical = {
        head=augmented_gear.Herculean.WSD.STR.head,
        neck="Caro necklace",
        left_ear="Assuage earring",
        right_ear="Moonshade earring",
        body=augmented_gear.Adhemar.Atk.body,
    	hands=augmented_gear.Adhemar.Atk.hands,
        right_ring="Ifrit ring +1",
        back="Buquwik Cape",
        waist="Sailfi Belt +1",
        legs=augmented_gear.Herculean.WSD.STR.legs,
        feet="Rawhide boots"
    }

	sets.midcast['Blue Magic'].Physical.Resistant = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].Physical.Fodder = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = set_combine(sets.midcast['Blue Magic'].Fodder, {})

	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
    	hands=augmented_gear.Adhemar.Atk.hands,
        legs="Hashishin Tayt",
        back=augmented_gear.capes.dex_crit,
    })
	sets.midcast['Blue Magic'].PhysicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalDex.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalVit.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalInt.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalInt.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalChr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalHP.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalHP.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})


	-- Magical Spells --

	sets.midcast['Blue Magic'].Magical = {
		ammo="Pemphredo Tathlum",
        head="Jhakri coronal +2",
        neck="Baetyl pendant",
        body="Amalric Doublet +1",
        left_ear="Friomisi earring",
        right_ear="Regal earring",
        hands="Amalric gages +1",
        left_ring="Shiva ring +1",
        right_ring="Metamorph Ring +1",
        waist=gear.ElementalObi,
        legs="Amalric Slops +1",
        feet="Amalric nails +1",
    	back=augmented_gear.capes.int_mab,
    }

	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
        ammo="Pemphredo Tathlum",
        head="Assimilator's Keffiyeh +3",
        body="Shamash Robe",
        neck="Encanter's torque",
        hands="Jhakri cuffs +2",
        right_ear="Regal earring",
        left_ear="Dignitary's earring",
        left_ring="Weatherspoon ring",
        right_ring="Metamorph Ring +1",
        legs="Luhlaza Shalwar +3",
        feet="Jhakri pigaches +2"
		})

	sets.midcast['Blue Magic'].Magical.Fodder = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {head="Assimilator's Keffiyeh +3",})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {head="Assimilator's Keffiyeh +3",})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {head="Assimilator's Keffiyeh +3",legs="Luhlaza Shalwar +3",})
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {hands="Jhakri cuffs +2"})
	sets.midcast['Blue Magic'].MagicalStr = set_combine(sets.midcast['Blue Magic'].Magical, {body="Shamash Robe",legs="Luhlaza Shalwar +3",})
    sets.midcast['Blue Magic'].MagicalAgi = set_combine(sets.midcast['Blue Magic'].Magical, {head="Assimilator's Keffiyeh +3",legs="Luhlaza Shalwar +3",})

	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {
        neck="Mirage Stole +2",
        leg="Assim. Shalwar +3",
    })

	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Enhancing Magic'] = {
        head="Telchine cap",
        hands="Telchine gloves",
        legs="Carmine Cuisses +1",
        neck="Incanter's torque",
        waist="Olympus sash",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring +1",
        left_ear="Andoaa earring",
        right_ear="Mimir earring", 
    }

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1", })

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1", waist="Emphatikos rope",})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
        head=augmented_gear.Taeon.Phalanx.head,
        body=augmented_gear.Taeon.Phalanx.body,
        hands=augmented_gear.Taeon.Phalanx.hands,
        legs=augmented_gear.Herculean.Phalanx.legs,
        feet=augmented_gear.Taeon.Phalanx.feet,
    })

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast['Divine Magic'] = {}

	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast.Helix.Resistant = set_combine(sets.midcast['Elemental Magic'].Fodder, {})

	sets.element.Dark = {head="Pixie Hairpin +1", right_ring="Archon Ring"}
	sets.element.Earth = {neck="Quanpur Necklace"}
	sets.element.Light = {right_ring="Weatherspoon Ring"}

	sets.midcast.Cure = {
        head="Rabid Visor",
        neck="Phalaina locket",
        body="Rawhide Vest",
        hands="Telchine Gloves",
        legs="Psycloth Lappas",
        feet="Medium's sabots",
        left_ear="Mendi. Earring",
        right_ring="Lebeche ring",
        back="Solemnity cape",
        legs="Gyve trousers"
    }

	-- Breath Spells --

	sets.midcast['Blue Magic'].Breath = {}

	-- Physical Added Effect Spells most notably "Stun" spells --

	sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Blue Magic'].Stun.Resistant = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Blue Magic'].Stun.Fodder = set_combine(sets.midcast['Blue Magic'].Stun, {})

	-- Other Specific Spells --

	sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast.FastRecast, sets.midcast.Cure, {
		ammo="Falcon eye",
		head="Assimilator's Keffiyeh +3",
		body="Assimilator's Jubbah +3",
		right_ear="Ethereal earring",
		left_ring="Ilabrat ring",
		back="moonbeam cape"
	})
					
	sets.midcast['Blue Magic']['Healing Breeze'] = set_combine(sets.midcast.Cure, {})

	sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast.Cure, {})

	sets.midcast['Blue Magic']['Tenebral Crush'] = set_combine(sets.midcast['Blue Magic'].Magical, sets.element.dark)
	sets.midcast['Blue Magic']['Tenebral Crush'].Resistant = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {})

	sets.midcast['Blue Magic']['Blank Gaze'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})
	sets.midcast['Blue Magic']['Blank Gaze'].Enmity = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.enmity)

	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = set_combine(sets.midcast.Cure,{})

	sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(sets.midcast.FastRecast, {
		ammo="Mavi Tathlum",
		body="Assimilator's jubbah +3",
		hands="Rawhide gloves",
		legs="Hashishin tayt +1",
		feet="Luhlaza Charuqs +3",
        neck="Mirage Stole +2",
        right_ear="Njordr earring",
        left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Cornflower cape",
	})

	sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'].SkillBasedBuff, {hands="Hashishin Bazubands +1",})
	sets.midcast['Blue Magic']['Diamondhide'] = set_combine(sets.midcast.FastRecast, {
		hands="Hashishin Bazubands +1",
		legs="Hashishin tayt +1",
		left_ring="Stikini Ring +1",
		})

	sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast.FastRecast, {
		hands="Hashishin Bazubands +1",
	})

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {head="Amalric Coif +1", })

	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

	sets.midcast['Blue Magic']['Dream Flower'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
		ammo="Staunch Tathlum +1",
        hands="Rawhide Gloves",
        legs="Assimilator's Shalwar +3",
		waist="Emphatikos rope",
        left_ear="Halasz earring",
	})

	sets.midcast['Blue Magic']['Sheep Song'] = set_combine(sets.midcast['Blue Magic']['Dream Flower'], {})

    sets.midcast['Blue Magic']['Sound Blast'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.TreasureHunter)
    
	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = set_combine(sets.midcast['Blue Magic'].SkillBasedBuff, {hands="Assim. Bazu. +3"})

	-- Engaged sets

	sets.engaged = {
        ammo="Aurgelmir orb +1",
        head=augmented_gear.Adhemar.Atk.head,
        body=augmented_gear.Adhemar.Atk.body,
    	hands=augmented_gear.Adhemar.Atk.hands,
        legs="Samnuha tights",
    	feet=augmented_gear.Herculean.TA.feet,
        neck="Mirage Stole +2",
        left_ear='Suppanomimi',
        right_ear="Brutal Earring",
        left_ring="Hetairoi ring",
        right_ring="Epona's ring",
        back=augmented_gear.capes.stp,
        waist="Windbuffet belt +1",
    }

	sets.engaged.AM = set_combine(sets.engaged, {
        head="Malignance Chapeau",
        right_ear="Dedition earring",
        left_ring="Ilabrat ring",
        right_ring="Chirich Ring +1", 
        waist="Kentarch Belt +1", })

	sets.engaged.Acc = set_combine(sets.engaged, {
        head="Malignance Chapeau",
        body=augmented_gear.Adhemar.Acc.body,
    	hands=augmented_gear.Adhemar.Acc.hands,
        neck='Mirage Stole +2',
        right_ear="Telos earring",
        right_ring="Chirich ring +1",
        waist="Kentarch belt +1",
    })

	sets.engaged.Acc.AM = set_combine(sets.engaged.Acc, {
        left_ring="Ilabrat ring",
    })

	sets.engaged.BigAcc = set_combine(sets.engaged.Acc, {
        head="Carmine Mask +1",
        legs="Carmine Cuisses +1",
        left_ear="Cessance earring",
    })

	sets.engaged.BigAcc.AM = set_combine(sets.engaged.BigAcc, {
        left_ring="Ilabrat ring",
    })

    sets.engaged.FullAcc = set_combine(sets.engaged.BigAcc, {
        ammo="Falcon Eye",
        body="Malignance Tabard",
        left_ring="Cacoethic ring +1",
        feet="Malignance boots",
    })

    sets.engaged.FullAcc.AM = set_combine(sets.engaged.FullAcc, {})

	sets.engaged.Fodder = set_combine(sets.engaged, {})


	sets.engaged.DTLite = set_combine(sets.engaged, { -- 39 pdt, 27mdt
    	head="Malignance Chapeau",
    	neck="Loricate Torque +1",
    	hands="Malignance Gloves",
    	left_ring="Defending Ring"
	})
    sets.engaged.DTLite.AM = set_combine(sets.engaged.DTLite, {
        right_ear="Dedition earring",
        right_ring="Chirich Ring +1", 
        waist="Kentarch Belt +1", 
    })

	sets.engaged.DTMid = set_combine(sets.engaged.DTLite, { -- 46 pdt, 34mdt
    	legs="Malignance Tights",
	})    

	sets.engaged.DT = set_combine(sets.engaged.DTMid, { -- 49 pdt, 37 mdt
		ammo="Staunch Tathlum +1",
    })


    sets.engaged.Acc.DTLite = set_combine(sets.engaged.DTLite, {})
    sets.engaged.Acc.DTMid = set_combine(sets.engaged.DTMid, {})
    sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {})

    sets.engaged.BigAcc.DTLite = set_combine(sets.engaged.Acc.DTLite, {})
    sets.engaged.BigAcc.DTMid = set_combine(sets.engaged.Acc.DTMid, {})
    sets.engaged.BigAcc.DT = set_combine(sets.engaged.Acc.DT, {})

    sets.engaged.FullAcc.DTLite = set_combine(sets.engaged.BigAcc.DTLite, {})
    sets.engaged.FullAcc.DTMid = set_combine(sets.engaged.BigAcc.DTMid, {})
	sets.engaged.FullAcc.DT = set_combine(sets.engaged.BigAcc.DT, {})

	-- Idle sets
	sets.idle = set_combine(sets.engaged, {
        ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        body="Shamash robe",
		hands=augmented_gear.Herculean.Refresh.hands,
		legs=augmented_gear.Herculean.Refresh.legs,
        feet=augmented_gear.Herculean.Refresh.feet,
        neck="Loricate Torque +1",
        left_ear="Eabani Earring",
        right_ear="Hearty earring",
        left_ring="Defending ring",
        right_ring="Sheltered Ring",
        waist="Flume Belt",
        back=augmented_gear.capes.stp,
    })
	--sets.idle.Town = set_combine(sets.idle, {
	--	legs="Carmine Cuisses +1"
    --})

	sets.idle.Refresh = set_combine(sets.idle, {
        head="Rawhide mask",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring +1",
    })

	sets.idle.DT = set_combine(sets.idle, {
        hands="Malignance Gloves",
        legs="Malignance Tights",
    })

	sets.idle.DTKite = set_combine(sets.idle.DT, {
		legs="Carmine Cuisses +1",
	})

    -- Resting sets
    sets.resting = set_combine(sets.idle.Refresh, {})

	-- Defense sets
	sets.defense.PDT = set_combine(sets.dt, {})
	sets.defense.MDT = set_combine(sets.dt, {})
    sets.defense.MEVA = set_combine(sets.MDT, {
    	--neck="Warder's Charm +1",
    })

	sets.defense.Death = {left_ring="Eihwaz ring"}

	sets.defense.NukeLock = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.MP = {waist="Flume Belt",left_ear="Suppanomimi", right_ear="Ethereal Earring"}
    sets.MP_Knockback = {}
	sets.SuppaBrutal = {left_ear="Suppanomimi", right_ear="Brutal Earring"}
	sets.DWEarrings = {left_ear="Dudgeon Earring",right_ear="Heartseeker Earring"}
	sets.DWMax = {left_ear="Dudgeon Earring",right_ear="Heartseeker Earring",body="Adhemar Jacket",waist="Reiki Yotai",legs="Carmine Cuisses +1"}
	sets.Assault = {left_ring="Balrahn's Ring"}

	sets.Self_Healing = {neck="Phalaina locket"}
	sets.Self_Healing_Club = {}
	sets.Self_Healing_DWClub = {}
	sets.Healing_Club = {}
	sets.Healing_DWClub = {}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {}
	--sets.MagicBurst = {hands="Amalric Gages +1",left_ring="Mujin Band",right_ring="Locus Ring"}
	sets.midcast['Trust'] = set_combine(sets.midcast.FastRecast, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 18)

	if player.sub_job == 'RDM' then
		windower.chat.input:schedule(1,'/lockstyleset 7')
	else
		windower.chat.input:schedule(1,'/lockstyleset 8')
	end
end

--Job Specific Trust Overwrite
function check_trust()
	--if not moving then
	--	if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
	--		local party = windower.ffxi.get_party()
	--		if party.p5 == nil then
	--			local spell_recasts = windower.ffxi.get_spell_recasts()
--
	--			if spell_recasts[980] == 0 and not have_trust("Yoran-Oran") then
	--				windower.chat.input('/ma "Yoran-Oran (UC)" <me>')
	--				tickdelay = 250
	--				return true
	--			elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
	--				windower.chat.input('/ma "Koru-Moru" <me>')
	--				tickdelay = 250
	--				return true
	--			elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
	--				windower.chat.input('/ma "Qultada" <me>')
	--				tickdelay = 250
	--				return true
	--			elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
	--				windower.chat.input('/ma "Ulmia" <me>')
	--				tickdelay = 250
	--				return true
	--			elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
	--				windower.chat.input('/ma "Selh\'teus" <me>')
	--				tickdelay = 250
	--				return true
	--			else
	--				return false
	--			end
	--		end
	--	end
	--end
	return false
end
