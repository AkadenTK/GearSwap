-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None','Knockback','SuppaBrutal','DWEarrings','DWMax'}
	
	gear.wsd_jse_back = {name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.da_jse_back = {name="Andartia's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	
	send_command('bind ^` input /ja "Innin" <me>')
    send_command('bind !` input /ja "Yonin" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
	utsusemi_cancel_delay = .4
	utsusemi_ni_cancel_delay = .1
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.Enmity = {}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands=augmented_gear.Herculean.TH.hands,legs="Volte Hose",feet="Volte Boots"})
    
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {} --legs="Mochizuki Hakama"
    sets.precast.JA['Futae'] = {}
    sets.precast.JA['Sange'] = {} --legs="Mochizuki Chainmail"
	sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Warcry'] = sets.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {}

    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head="Herculean Helm",
        body=augmented_gear.Adhemar.FC.body,
        hands="Leyline gloves",
        legs="Gyve trousers",
        feet="Amalric nails +1"
    }
		
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket",feet="Hattori Kyahan +1"})
	sets.precast.FC.Shadows = set_combine(sets.precast.FC.Utsusemi, {})
    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Ginsen",
        head=augmented_gear.Adhemar.Atk.head,
        neck="Asperity Necklace",
        left_ear='Suppanomimi',
        right_ear="Brutal Earring",
        body=augmented_gear.Adhemar.Atk.body,
        hands=augmented_gear.Adhemar.Atk.hands,
        left_ring="Ilabrat ring",
        right_ring="Epona's ring",
        back="Atheling Mantle",
        waist="Windbuffet belt +1",
        legs="Samnuha tights",
        feet=augmented_gear.Herculean.TA.feet,
    }
    sets.engaged.Acc = {
        head=augmented_gear.Adhemar.Acc.head,
        body=augmented_gear.Adhemar.Acc.body,
        hands=augmented_gear.Adhemar.Acc.hands,}
    sets.engaged.FullAcc = {}

    -- Snapshot for ranged
    sets.precast.RA = {}
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {
        ammo="Jukukik Feather",
        head=augmented_gear.Adhemar.Atk.head,
        body="Mummu Jacket +1",
        hands="Meg. Gloves +2",
        legs=augmented_gear.Herculean.CritDMG.DEX.legs,
        feet="Mummu Gamash. +1",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Ishvara Earring",
        right_ear="Brutal Earring",
        left_ring="Ilabrat Ring",
        right_ring="Ifrit Ring +1",
        back="Kayapa Cape",
    })
    sets.precast.WS['Blade: Jin'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Blade: Jin'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Jin'].Fodder = set_combine(sets.precast.WS['Blade: Jin'], {})
	
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Blade: Hi'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Blade: Hi'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Hi'].Fodder = set_combine(sets.precast.WS['Blade: Hi'], {})

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Blade: Shun'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Blade: Shun'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Shun'].Fodder = set_combine(sets.precast.WS['Blade: Shun'], {})

    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {
        ammo="Jukukik Feather",
        head=augmented_gear.Adhemar.Atk.head,
        body="Mummu Jacket +1",
        hands="Meg. Gloves +2",
        legs=augmented_gear.Herculean.CritDMG.DEX.legs,
        feet="Mummu Gamash. +1",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Ishvara Earring",
        right_ear="Brutal Earring",
        left_ring="Ilabrat Ring",
        right_ring="Ifrit Ring +1",
        back="Kayapa Cape",
    })
    sets.precast.WS['Blade: Ten'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Blade: Ten'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Ten'].Fodder = set_combine(sets.precast.WS['Blade: Ten'], {})
	
    sets.precast.WS['Aeolian Edge'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

    sets.midcast.ElementalNinjutsu = {}
		
    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})
	
	sets.MagicBurst = {}
	
	sets.element.Earth = {}

    sets.midcast.NinjutsuDebuff = {}

    sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {})
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {})

    sets.midcast.RA = {}
		
    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = set_combine(sets.engaged, {})

    sets.idle.PDT = {}
		
    sets.idle.Sphere = set_combine(sets.idle, {})
		
    sets.idle.Weak = {}
    
    -- Defense sets
    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
	sets.defense.MEVA = {}


    sets.Kiting = {feet="Danzo sune-ate"}
	sets.DuskKiting = {feet="Ninja kyahan"}
	sets.DuskIdle = {}
	sets.DayIdle = {}
	sets.NightIdle = {}


		
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Yonin = {} --
    sets.buff.Innin = {} --head="Hattori Zukin +1"
	
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.SuppaBrutal = {}
	sets.DWEarrings = {}
	sets.DWMax = {}
	sets.Weapons = {}
	sets.MagicWeapons = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", waist = "Chaac belt",hands=augmented_gear.Herculean.TH.hands})
	sets.Skillchain = {}
	
	sets.RedProcDagger = {}
	sets.RedProcSword = {}
	sets.RedProcGreatSword = {}
	sets.RedProcScythe = {}
	sets.RedProcPolearm = {}
	sets.RedProcGreatKatana = {}
	sets.RedProcKatana = {}
	sets.RedProcClub = {}
	sets.RedProcStaff = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
        set_macro_page(1, 4)
end