
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
    sets.Capacity={back="Aptitude Mantle"}



    sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="Volte cap", hands=augmented_gear.Herculean.TH.hands,feet="Volte Boots"})

    sets.dt = {}

	sets.weapons = {}
	sets.weapons.SwordTP = {main='Naegling', sub="Colada"}
    sets.weapons.SwordAcc = {main="Tizona",sub="Naegling"}
	--sets.weapons.SavageBlade = {main="Sequence",sub="Colada"}
	sets.weapons.MagicWeapons = {main="Naegling", sub="Tauret"}
    sets.weapons.ClubTP = {main="Maxentius", sub="Thibron"}
	sets.weapons.ClubAcc = {main="Maxentius", sub="Naegling"}
	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +1"}

	sets.enmity = set_combine(sets.dt, {})

	sets.precast.JA['Provoke'] = set_combine(sets.enmity, {})


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}

	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells

	sets.precast.FC = set_combine(sets.engaged, {
        head="Haruspex hat",
        body="Samnuha coat",
        hands="Leyline Gloves",
        legs="Ayanmo Cociales +2",
        left_ring="Kishar Ring",
        right_ring="Lebeche Ring",
        neck="Voltsurge Torque",
        waist="Witful Belt",
    })

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga beads"})

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})


	-- Weaponskill sets
	-- Default set for any weap}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {})

	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})

	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
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

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {})
    sets.precast.WS['Chant du Cygne'].BigAcc = set_combine(sets.precast.WS['Chant du Cygne'].Acc, {})
    sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS['Chant du Cygne'].BigAcc, {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        head=augmented_gear.Herculean.WSD.STR.head,
        body="Jhakri Robe +1",
        hands="Jhakri Cuffs +2",
        legs=augmented_gear.Herculean.WSD.STR.legs,
        feet=augmented_gear.Herculean.WSD.STR.feet,
        neck="Caro Necklace",
        waist="Prosilio belt",
        left_ear="Moonshade earring",
        right_ear="Ishvara earring",
        right_ring="Karieyh ring",
        back=augmented_gear.capes.str_wsd,
    })
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
    sets.precast.WS['Savage Blade'].BigAcc = set_combine(sets.precast.WS['Savage Blade'].Acc, {
    })
    sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'].BigAcc, {})

	--sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1",left_ear="Cessance Earring", right_ear="Brutal Earring",right_ring="Begrudging Ring",back=gear.crit_jse_back,feet="Thereoid Greaves"})
	--sets.precast.WS['Vorpal Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet +1",right_ring="Begrudging Ring",back=gear.crit_jse_back})
	--sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {back=gear.crit_jse_back})
	--sets.precast.WS['Vorpal Blade'].HighAcc = set_combine(sets.precast.WS.HighAcc, {})
	--sets.precast.WS['Vorpal Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	--sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS['Vorpal Blade'], {})

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Expiacion'].Atk_Cap = set_combine(sets.precast.WS['Expiacion'], {})
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS['Expiacion'], {})
    sets.precast.WS['Expiacion'].BigAcc = set_combine(sets.precast.WS['Expiacion'].Acc, {})
    sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS['Expiacion'].BigAcc, {})


	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {})
    sets.precast.WS['Black Halo'].BigAcc = set_combine(sets.precast.WS['Black Halo'].Acc, {})
    sets.precast.WS['Black Halo'].FullAcc = set_combine(sets.precast.WS['Black Halo'].BigAcc, {})

    sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Sanguine Blade'] = {}

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

	sets.midcast['Blue Magic'].Physical = {}

	sets.midcast['Blue Magic'].Physical.Resistant = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].Physical.Fodder = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = set_combine(sets.midcast['Blue Magic'].Fodder, {})

	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
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

	sets.midcast['Blue Magic'].Magical = {}

	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].Magical.Fodder = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {head="Assimilator's Keffiyeh +3",})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {head="Assimilator's Keffiyeh +3",})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {head="Assimilator's Keffiyeh +3",legs="Luhlaza Shalwar +3",})
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {hands="Jhakri cuffs +2"})
	sets.midcast['Blue Magic'].MagicalStr = set_combine(sets.midcast['Blue Magic'].Magical, {body="Shamash Robe",legs="Luhlaza Shalwar +3",})
    sets.midcast['Blue Magic'].MagicalAgi = set_combine(sets.midcast['Blue Magic'].Magical, {head="Assimilator's Keffiyeh +3",legs="Luhlaza Shalwar +3",})

	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {})

	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Enhancing Magic'] = {}

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1", })

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1", waist="Emphatikos rope",})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {})

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
        hands="Telchine Gloves",
        left_ring="Menelaus's ring",
        right_ring="Lebeche ring",
    }

	-- Breath Spells --

	sets.midcast['Blue Magic'].Breath = {}

	-- Physical Added Effect Spells most notably "Stun" spells --

	sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Blue Magic'].Stun.Resistant = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Blue Magic'].Stun.Fodder = set_combine(sets.midcast['Blue Magic'].Stun, {})

	-- Other Specific Spells --

	sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast.FastRecast, sets.midcast.Cure, {
        head="volte cap",
        body="Adhemar Jacket +1",
        legs="Carmine Cuisses +1",
        left_ear="Eabani earring",  
        left_ring="Ilabrat ring",
    })
					
	sets.midcast['Blue Magic']['Healing Breeze'] = set_combine(sets.midcast.Cure, {})

	sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast.Cure, {})

	sets.midcast['Blue Magic']['Tenebral Crush'] = set_combine(sets.midcast['Blue Magic'].Magical, sets.element.dark)
	sets.midcast['Blue Magic']['Tenebral Crush'].Resistant = set_combine(sets.midcast['Blue Magic'].Magical.Resistant, {})

	sets.midcast['Blue Magic']['Blank Gaze'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})
	sets.midcast['Blue Magic']['Blank Gaze'].Enmity = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.enmity)

	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = set_combine(sets.midcast.Cure,{})

	sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'].SkillBasedBuff, {hands="Hashishin Bazubands +1",})
	sets.midcast['Blue Magic']['Diamondhide'] = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {head="Amalric Coif +1", })

	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

	sets.midcast['Blue Magic']['Dream Flower'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

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
        ammo="Ginsen",
        head=augmented_gear.Adhemar.Atk.head,
        body=augmented_gear.Adhemar.Atk.body,
        hands=augmented_gear.Adhemar.Atk.hands,
        legs="Samnuha Tights",
        feet=augmented_gear.Herculean.TA.feet,
        neck="Ainia Collar",
        left_ring="Petrov Ring",
        right_ring="Epona's ring",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        waist="Kentarch belt +1",
        back=augmented_gear.capes.stp,
    }

	sets.engaged.AM = set_combine(sets.engaged, {})

	sets.engaged.Acc = set_combine(sets.engaged, {})

	sets.engaged.Acc.AM = set_combine(sets.engaged.Acc, {})

	sets.engaged.BigAcc = set_combine(sets.engaged.Acc, {})

	sets.engaged.BigAcc.AM = set_combine(sets.engaged.BigAcc, {})

    sets.engaged.FullAcc = set_combine(sets.engaged.BigAcc, {})

    sets.engaged.FullAcc.AM = set_combine(sets.engaged.FullAcc, {})

	sets.engaged.Fodder = set_combine(sets.engaged, {})


	sets.engaged.DTLite = set_combine(sets.engaged, { })
    sets.engaged.DTLite.AM = set_combine(sets.engaged.DTLite, {})

	sets.engaged.DTMid = set_combine(sets.engaged.DTLite, {})    

	sets.engaged.DT = set_combine(sets.engaged.DTMid, {})


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
	sets.idle = set_combine(sets.engaged, {})
	--sets.idle.Town = set_combine(sets.idle, {
	--	legs="Carmine Cuisses +1"
    --})

	sets.idle.Refresh = set_combine(sets.idle, {})

	sets.idle.DT = set_combine(sets.idle, {})

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
    sets.defense.Knockback = {legs="Dashing Subligar",back="Repulse Mantle",}

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
	set_macro_page(1, 11)
    
    windower.chat.input:schedule(1,'/lockstyleset 9')
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
