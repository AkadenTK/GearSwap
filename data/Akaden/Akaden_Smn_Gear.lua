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
    sets.staves = {
        magicbp = "Grioavolr",
        magicaccbp = "Grioavolr",
        physicalbp = "Gridarvor",
        smnskill = { name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','System: 2 ID: 153 Val: 3',}},
        perp = "Gridarvor",
        refresh = "Bolelabunga"
    }
    gada={ name="Gada", augments={'Enh. Mag. eff. dur. +5','Mag. Acc.+4',}}

    --[#2 Augmented Items & JSE Cape ]--
    sets.campestres = {
        magic = { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20',}},
        atk = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10',}},
        --atk = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10',}},
        idle = { name="Campestres's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}},
        fc = { name="Campestres's Cape", augments={'MP+60','MP+18','"Fast Cast"+10',}}
    } 

    mag_apogee_augments = {'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',}
    mag_apogee_augments_1 = {'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}
    phy_apogee_augments = {'MP+60','Pet: Attack+30','Blood Pact Dmg.+7',}
    phy_apogee_augments_1 = {'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}
    sets.apogee = {}
    sets.apogee.magical={
        head={ name="Apogee Crown", augments=mag_apogee_augments},
        --body={ name="Apogee Doublet", augments=mag_apogee_augments},
        --hands={ name="Apogee Mitts", augments=mag_apogee_augments},
        legs={ name="Apogee Slacks", augments=mag_apogee_augments},
        feet={ name="Apogee Pumps", augments=mag_apogee_augments},
    }
    sets.apogee.physical = set_combine(sets.apogee.magical, {
        head={ name="Apogee Crown", augments=phy_apogee_augments},
        hands = { name= "Apogee Mitts", augments=phy_apogee_augments},
        feet = { name= "Apogee Pumps", augments=phy_apogee_augments},
    })
    sets.apogee.hybrid = set_combine(sets.apogee.magical, {})

    sets.convoker = {
        head="Convoker's Horn +1",
        body="Convoker's Doublet +3",
        --hands="Convoker's Bracers",
        --legs="Convoker's spats",
        --feet="Convoker's pigaches"
    }
    sets.glyphic = {
        head="Summoner's horn",
        body="Glyphic doublet +1",
        hands="Glyphic bracers",
        legs="Summoner's spats",
        feet="Glyphic pigaches +1"
    }
    sets.beckoner = {
        head="Beckoner's horn +1",
        body="Beckoner's doublet",
        hands="Caller's bracers +1",
        legs="Beckoner's spats",
        feet="Beckoner's pigaches"
    }

    elan_strap = "Elan Strap"
    sancus_sachet = "Sancus Sachet"

    merlinic_head_fc="Merlinic Hood"
    merlinic_head_mab={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Mag. Acc.+12','"Mag.Atk.Bns."+10',}}
    merlinic_body_mab={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Fast Cast"+1','MND+7','Mag. Acc.+10','"Mag.Atk.Bns."+15',}}

    merlinic_hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+9','System: 1 ID: 1792 Val: 8','Pet: Mag. Acc.+7','Pet: "Mag.Atk.Bns."+9',}}
    merlinic_hands_fc = { name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+6','INT+10','Mag. Acc.+11',}} --6
    merlinic_hands_mab={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+8','Pet: DEX+4','Pet: "Mag.Atk.Bns."+5',}}
    merlinic_hands_refresh={ name="Merlinic Dastanas", augments={'Pet: DEX+14','Pet: Accuracy+17 Pet: Rng. Acc.+17','"Refresh"+2',}}


    merlinic_legs_mburst={ name="Merlinic Shalwar", augments={'"Snapshot"+1','"Conserve MP"+1','Magic burst mdg.+15%','Accuracy+13 Attack+13','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}--15

    merlinic_feet_fc="Merlinic Crackows"
    merlinic_feet_refresh={ name="Merlinic Crackows", augments={'STR+10','Pet: "Mag.Atk.Bns."+23','"Refresh"+2','Accuracy+4 Attack+4','Mag. Acc.+9 "Mag.Atk.Bns."+9',}}


    amal_head={ name="Amalric Coif", augments={'INT+10','Mag. Acc.+20','Enmity-5',}}
    amal_hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}

sets.smnskill = { 
    main=sets.staves.smnskill,
    sub="Vox Grip",
    ammo=sancus_sachet,
    head=sets.convoker.head,
    body=sets.beckoner.body,
    hands=sets.glyphic.hands,
    legs=sets.beckoner.legs,
    feet=sets.apogee.magical.feet,
    neck="Melic Torque",
    waist="Lucidity Sash",
    ear1="Summoning earring",
    ear2="Andoaa earring",
    ring1="Globidonta Ring",
    ring2="Evoker's ring",
    back="Conveyance Cape"
    --ammo="Seraphicaller",
    --head="Convoker's Horn +2",
}

    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {waist="Chaac Belt"})
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head="Glyphic Horn"}
    
    sets.precast.JA['Elemental Siphon'] = {
        main=sets.staves.smnskill,
        sub="Vox Grip",
        ammo="Esper Stone +1",
        head=sets.convoker.head,
        body=sets.beckoner.body,
        hands=sets.glyphic.hands,
        legs=sets.beckoner.legs,
        feet=sets.beckoner.feet,
        neck="Melic Torque",
        waist="Lucidity Sash",
        ear1="Summoning earring",
        ear2="Andoaa earring",
        ring1="Zodiac Ring",--use on all but light or darks day
        ring2="Evoker's Ring",
        back="Conveyance Cape"
    }

    sets.precast.JA['Mana Cede'] = {hands="Caller's Bracers +2"}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = { --I just stack it all because when I do salvage or a gear slot is locked by a NM it's nice
        main=sets.staves.smnskill, --II -2
        ammo=sancus_sachet, --II -5
        head=sets.convoker.head,-- -8
        body=sets.glyphic.body, --6
        hands=sets.glyphic.hands,--6
        legs=sets.glyphic.legs,
        feet=sets.glyphic.feet,
        ear1="Evans Earring",--2
        back="Conveyance Cape" --II -3
    }

    sets.precast.BloodPactRage = set_combine(sets.precast.BloodPactWard, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        main=sets.staves.fc,--9
        sub="Vivid Strap",--1
        head="Merlinic Hood",
        hands="Amalric gages",
        body="Merlinic Jubbah", --13
        ring1={name="Mephitas's Ring +1",priority=3},
        ring2={name="Mephitas's Ring",priority=3},
        waist="Channeler's stone", --3
        legs="Psycloth Lappas", --7
        feet="Amalric Nails",
        back=sets.campestres.fc,--10
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
    sub="Vox Grip",
        ammo=sancus_sachet,
        head=sets.apogee.magical.head,
        body=sets.beckoner.body,
        hands="Lamassu mitts +1",
        legs="Beck. Spats +1",
        feet=sets.apogee.magical.feet,
        neck="Sanctity Necklace",
        waist="Shinjutsu-no-Obi +1",
        ear1="Etiolation Earring",
        ear2=moonshade,
        ring1={name="Mephitas's Ring +1",priority=3},
        ring2={name="Mephitas's Ring",priority=3},
        back="Conveyance Cape"
        --ear1="Evans Earring",
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
        ear1="Mendicant's earring",--5%
        neck="Nodens Gorget",--5%
        waist="Witful Belt",
        back="Solemnity Cape",
        --ring2="Sirona's Ring",
        --back="Thaumaturge's Cape",
    }
		
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Elemental Magic'] = {}
		
	sets.midcast['Elemental Magic'].Resistant = {}

    sets.midcast['Divine Magic'] = {}
		
    sets.midcast['Dark Magic'] = {}
	
	sets.midcast.Drain = {}
    
    sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})
		
    sets.midcast.Stun = {}
		
    sets.midcast.Stun.Resistant = {}
		
	sets.midcast['Enfeebling Magic'] = {}
		
	sets.midcast['Enfeebling Magic'].Resistant = {}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
		
    sets.midcast['Enhancing Magic'] = {head="Telchine Cap",body="Telchine Chasuble",hands="Telchine Gloves",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    -- Avatar pact sets.  All pacts are Ability type.

    
    sets.midcast.Pet.BloodPactWard = set_combine(sets.smnskill, { --uses the smnskill set as base, if you want to override anything htat set you may do so here
        head=sets.beckoner.head,
        body=sets.beckoner.body,
    })

    sets.midcast.Pet.DebuffBloodPactWard = set_combine(sets.midcast.Pet.BloodPactWard, {main=sets.staves.magicaccbp,})
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = set_combine(sets.midcast.Pet.DebuffBloodPactWard, {})
    
    sets.midcast.Pet.PhysicalBloodPactRage = {
        main=sets.staves.physicalbp,
        sub=elan_strap,
        ammo=sancus_sachet,
        head=sets.apogee.physical.head,
        body=sets.convoker.body,
        hands=sets.apogee.physical.hands,
        legs="Enticer's pants",
        neck="Shulmanu collar",
        --waist="Mujin Obi",
        waist="Regal Belt",
        ear1="Gelos Earring",
        ear2="Esper earring",
        ring1={name="Varar Ring",priority=3},
        ring2={name="Varar Ring",priority=3},
        back=sets.campestres.atk,
        feet=sets.apogee.physical.feet,
        --back="Conveyance Cape",
        --ring2="Evoker's ring",
        --ammo="Seraphicaller",
    }
		
    sets.midcast.Pet.PhysicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {})

    sets.midcast.Pet.MagicalBloodPactRage = {
        main=magbpstaff,
        sub=elan_strap,
        head=sets.apogee.magical.head,
        hands=merlinic_hands_mab,
        body=sets.convoker.body,
        legs=sets.apogee.magical.legs,
        --legs="Enticer's pants",
        feet=sets.apogee.magical.feet,
        main=sets.staves.magicbp,
        ammo=sancus_sachet,
        --neck="Deino Collar",
        neck="Adad Amulet",
        waist="Regal Belt",
        ear1="Gelos Earring",
        ear2="Esper earring",
        ring1="Varar Ring",
        ring2="Varar Ring",
        back=sets.campestres.magic,
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
        main=sets.staves.refresh,
        sub="Genbu's shield",
        ammo=sancus_sachet,
        head=sets.convoker.head,
        body="Amalric Doublet",
        hands="Serpentes cuffs",
        legs="Assiduity pants +1",
        feet="Serpentese Sabots",
        neck="Loricate Torque +1",
        waist="Fucho-no-obi",
        ear1="Ethereal Earring",
        ear2="Halasz earring",
        ring1={name="Mephitas's Ring +1",priority=4},
        ring2="Defending Ring",
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
        main=sets.staves.perp,
        sub="Vox Grip",
        head=sets.beckoner.head,
        body="Amalric doublet",
        --hands="Asteria Mitts +1",
        hands="Serpentes cuffs",
        legs="Assiduity pants +1",
        feet=sets.apogee.magical.feet,
        neck="Caller's Pendant",
        ammo=sancus_sachet,
        waist="Lucidity sash",
        ring1={name="Mephitas's Ring +1",priority=3},
        ring2="Evoker's ring"
    }
		
    sets.idle.PDT.Avatar = set_combine(sets.idle.Avatar, {})

    sets.idle.Spirit = set_combine(sets.idle.Avatar, {})
		
    sets.idle.PDT.Spirit = set_combine(sets.idle.Avatar.PDT, {})
		
	sets.idle.TPEat.Avatar = set_combine(sets.idle.Avatar, {})
		
	--Favor always up and head is best in slot idle so no specific items here at the moment.
    sets.idle.Avatar.Favor = {}
    sets.idle.Avatar.Melee = {}
	
	sets.idle.Avatar.Melee.Carbuncle = {}
	sets.idle.Avatar.Melee['Cait Sith'] = {}
        
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
