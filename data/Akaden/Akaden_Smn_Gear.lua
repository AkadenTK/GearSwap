-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'TPEat')

    gear.perp_staff = {name="Gridarvor"}
	
	gear.magic_jse_back = {name="Campestres's Cape",augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}}
	gear.phys_jse_back = {name="Campestres's Cape",augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}}
	
    send_command('bind !` input /ja "Release" <me>')
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind ^` gs c toggle PactSpamMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    include('organizer-lib')
    sets.Capacity = {back="Aptitude Mantle"}
    staves = {
        magicbp = { name="Grioavolr", augments={'Blood Pact Dmg.+10','Pet: INT+11','Pet: Mag. Acc.+17','Pet: "Mag.Atk.Bns."+24','DMG:+22',}},
        magicaccbp = "Grioavolr",
        physicalbp = "Gridarvor",
        smnskill = "Espiritus",
        perp = "Gridarvor",
        refresh = "Daybreak",
        fc = "Grioavolr",
    }

    --[#2 Augmented Items & JSE Cape ]--
    augmented_gear.capes = {
        magic= { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10',}},
        atk = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
        --atk = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10',}},
        idle = { name="Campestres's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}},
    } 
    augmented_gear.capes.fc = augmented_gear.capes.magic

    sets.smnskill = { 
        main=staves.smnskill,
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +1",
        body="Beckoner's doublet",
        hands="Glyphic Bracers +1",
        legs="Beckoner's Spats +1",
        feet=augmented_gear.Apogee.Magic.feet,
        neck="Incanter's Torque",
        waist="Lucidity Sash",
        left_ear="Summoning earring",
        right_ear="Andoaa earring",
        left_ring="Stikini Ring",
        right_ring="Evoker's ring",
        back="Conveyance Cape"
        --ammo="Seraphicaller",
        --head="Convoker's Horn +2",
    }

    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {waist="Chaac Belt",legs="Volte Hose",feet="Volte Boots"})
	
    -- Precast sets to enhance JAs
    --sets.precast.JA['Astral Flow'] = {head="Glyphic Horn"}
    
    sets.precast.JA['Elemental Siphon'] = {
        main=staves.smnskill,
        sub="Vox Grip",
        ammo="Esper Stone +1",
        head="Convoker's Horn +1",
        body="Beckoner's doublet",
        hands="Glyphic Bracers +1",
        legs="Beckoner's Spats +1",
        feet="Beckoner's pigaches",
        neck="Incanter's Torque",
        waist="Lucidity Sash",
        left_ear="Summoning earring",
        right_ear="Andoaa earring",
        left_ring="Zodiac Ring",--use on all but light or darks day
        right_ring="Evoker's Ring",
        back="Conveyance Cape"
    }

    sets.precast.JA['Mana Cede'] = {hands="Caller's Bracers +2"}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = set_combine(sets.smnskill, { --I just stack it all because when I do salvage or a gear slot is locked by a NM it's nice
        main=staves.smnskill, -- II -2
        ammo="Sancus Sachet", -- II -5
        head="Beckoner's horn +1",-- Favor +3, skill +13
        body="Convoker's Doublet +3", -- I -15, skill +17
        hands="Glyphic Bracers +1",-- I -5, skill +17
        back="Conveyance Cape" --II -3
    })

    sets.precast.BloodPactRage = set_combine(sets.precast.BloodPactWard, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        main=staves.fc,--4
        sub="Vivid Strap",--1
        ammo="Impatiens",
        head="Cath Palug Crown", -- 8
        hands="Amalric gages +1",
        body="Merlinic Jubbah", -- 6
        right_ear="Malignance Earring", --4
        left_ring={name="Mephitas's Ring +1",priority=3},
        right_ring="Weatherspoon ring",  -- 5
        neck="Baetyl Pendant", -- 4
        waist="Embla Sash", --5
        legs="Psycloth Lappas", --7
        feet="Amalric Nails +1",
        back=augmented_gear.capes.fc,--10
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        main="Tamaxchi",
        sub="Sors shield",
        })
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {
        --sub="Vox Grip",
        ammo="Sancus Sachet",
        head=augmented_gear.Apogee.Magic.head,
        body="Beckoner's doublet",
        hands="Lamassu mitts +1",
        legs="Beck. Spats +1",
        feet=augmented_gear.Apogee.Magic.feet,
        neck="Sanctity Necklace",
        waist="Shinjutsu-no-Obi +1",
        left_ear="Etiolation Earring",
        right_ear=moonshade,
        left_ring={name="Mephitas's Ring +1",priority=3},
        right_ring={name="Mephitas's Ring",priority=3},
        back="Conveyance Cape"
        --left_ear="Evans Earring",
        --ammo="Seraphicaller",
    }

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}
	
    sets.midcast.Cure = {
        main="Tamaxchi",
        sub="Genbu's shield",
        body="Vanya robe",
        hands="Telchine gloves",
        legs="Gyve trousers",
        left_ear="Mendicant's earring",--5%
        neck="Nodens Gorget",--5%
        waist="Witful Belt",
        back="Solemnity Cape",
        --right_ring="Sirona's Ring",
        --back="Thaumaturge's Cape",
    }
		
	sets.Self_Healing = {neck="Phalaina Locket",left_ring="Kunaji Ring",right_ring="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",left_ring="Kunaji Ring",right_ring="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {head="Amalric Coif +1",back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Elemental Magic'] = {}
		
	sets.midcast['Elemental Magic'].Resistant = {}

    sets.midcast['Divine Magic'] = {}
		
    sets.midcast['Dark Magic'] = {}
	
	sets.midcast.Drain = {}
    
    sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})
		
    sets.midcast.Stun = {}
		
    sets.midcast.Stun.Resistant = {
        head=augmented_gear.Merlinic.Damage.head,
        body=augmented_gear.Merlinic.Damage.body,
        legs=augmented_gear.Merlinic.Damage.legs,
        body=augmented_gear.Merlinic.Damage.feet,
    }
		
	sets.midcast['Enfeebling Magic'] = {}
		
	sets.midcast['Enfeebling Magic'].Resistant = {}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
		
    sets.midcast['Enhancing Magic'] = {head="Telchine Cap",body="Telchine Chasuble",hands="Telchine Gloves",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1",})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    -- Avatar pact sets.  All pacts are Ability type.

    
    sets.midcast.Pet.BloodPactWard = set_combine(sets.smnskill, { --uses the smnskill set as base, if you want to override anything htat set you may do so here
    })

    sets.midcast.Pet.DebuffBloodPactWard = set_combine(sets.midcast.Pet.BloodPactWard, {main=staves.magicaccbp,})
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = set_combine(sets.midcast.Pet.DebuffBloodPactWard, {})
    
    sets.midcast.Pet.PhysicalBloodPactRage = {
        main=staves.physicalbp,
        sub="Elan Strap",
        ammo="Sancus Sachet",
        head=augmented_gear.Apogee.Physical.head,
        body="Convoker's Doublet +3",
        hands=augmented_gear.Merlinic.Pet.Atk.hands,
        legs="Enticer's pants",
        feet="Convoker's pigaches +2",
        neck="Shulmanu collar",
        --waist="Mujin Obi",
        waist="Regal Belt",
        left_ear="Gelos Earring",
        right_ear="Lugalbanda earring",
        left_ring={name="Varar Ring",priority=3},
        right_ring={name="Varar Ring",priority=3},
        back=augmented_gear.capes.atk,
        --back="Conveyance Cape",
        --right_ring="Evoker's ring",
        --ammo="Seraphicaller",
    }
		
    sets.midcast.Pet.PhysicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {})

    sets.midcast.Pet.MagicalBloodPactRage = {
        main=magbpstaff,
        sub="Elan Strap",
        head="Cath Palug Crown",
        hands=augmented_gear.Merlinic.Pet.MAB.hands,
        body="Convoker's Doublet +3",
        legs=augmented_gear.Apogee.Magic.legs,
        --legs="Enticer's pants",
        feet=augmented_gear.Apogee.Magic.feet,
        main=staves.magicbp,
        ammo="Sancus Sachet",
        --neck="Deino Collar",
        neck="Adad Amulet",
        waist="Regal Belt",
        left_ear="Gelos Earring",
        right_ear="Lugalbanda earring",
        left_ring="Varar Ring",
        right_ring="Varar Ring",
        back=augmented_gear.capes.magic,
    }

    sets.midcast.Pet.MagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {})

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {} --legs="Summoner's Spats"
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {}) --legs="Summoner's Spats"

    sets.midcast.Pet['Elemental Magic'].Resistant = {}
    
	sets.midcast.Pet['Flaming Crush'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {

    })
		
	sets.midcast.Pet['Flaming Crush'].Acc = set_combine(sets.midcast.Pet['Flaming Crush'], {})

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {
        main="Chatoyant Staff",
        sub="Oneiros grip",
        waist="Fucho-no-obi",
        legs="Assiduity pants +1",
    }
    
    -- Idle sets
    sets.idle = {
        main=staves.refresh,
        sub="Genbu's shield",
        ammo="Sancus Sachet",
        head="Convoker's Horn +1",
        body="Amalric Doublet +1",
        hands="Serpentes cuffs",
        legs="Assiduity pants +1",
        feet="Serpentese Sabots",
        neck="Loricate Torque +1",
        waist="Fucho-no-obi",
        left_ear="Ethereal Earring",
        right_ear="Halasz earring",
        left_ring={name="Mephitas's Ring +1",priority=4},
        right_ring="Defending Ring",
        back="Conveyance Cape",
    }

    sets.idle.PDT = set_combine(sets.idle, {})
		
	sets.idle.TPEat = set_combine(sets.idle, {})


    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- -perp gear:
    -- Gridarvor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Con. Pigaches +1: -4
    -- total: -18
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = {
        main=staves.perp,
        sub="Vox Grip",
        head="Beckoner's horn +1",
        body="Amalric doublet +1",
        --hands="Asteria Mitts +1",
        hands="Serpentes cuffs",
        legs="Assiduity pants +1",
        feet=augmented_gear.Apogee.Magic.feet,
        neck="Caller's Pendant",
        ammo="Sancus Sachet",
        waist="Lucidity sash",
        left_ring={name="Mephitas's Ring +1",priority=3},
        right_ring="Evoker's ring"
    }
		
    sets.idle.PDT.Avatar = set_combine(sets.idle.Avatar, {})

    sets.idle.Spirit = set_combine(sets.idle.Avatar, {})
		
    sets.idle.PDT.Spirit = set_combine(sets.idle.Avatar.PDT, {})
		
	sets.idle.TPEat.Avatar = set_combine(sets.idle.Avatar, {})
		
	--Favor always up and head is best in slot idle so no specific items here at the moment.
    sets.idle.Avatar.Favor = {}
    sets.idle.Avatar.Engaged = {}
	
	sets.idle.Avatar.Engaged.Carbuncle = {}
	sets.idle.Avatar.Engaged['Cait Sith'] = {}
        
    sets.perp = {}
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    sets.perp.Day = {}
    sets.perp.Weather = {}
	
	sets.perp.Carbuncle = {}
    sets.perp.Diabolos = {}
    sets.perp.Alexander = set_combine(sets.midcast.Pet.BloodPactWard, {})

	-- Not really used anymore, was for the days of specific staves for specific avatars.
    sets.perp.staff_and_grip = {}
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.defense.MEVA = {}
		
    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.HPDown = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Sacrifice Torque"}
	sets.Weapons = {}
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 5)
    windower.chat.input:schedule(1,'/lockstyleset 6')
end
