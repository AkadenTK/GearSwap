-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal', 'DTLite', 'FullDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
    state.NukingMode = M('Never', 'Always','300', '1000')
    state.Weapons:options('Kikoku', 'KikokuMB', 'Gokotai','SavageBlade','Proc_Sword', 'Proc_Katana', 'Proc_Dagger', 'Proc_Club', 'Proc_GKT', 'Proc_Staff', 'Proc_Scythe', 'Proc_Polearm', 'Proc_GS','None')
	
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

    organizer_items = {
        "Shihei",
        "inoshishinofuda",
        "Chonofuda",
        "Shikanofuda",
        "Shinobi-Tabi",
        "Sanjaku-Tenugui",
    }

    sets.weapons = {}
    sets.weapons.Gokotai = { main = "Gokotai", sub = "Kanaria" }
    sets.weapons.Kikoku = { main = "Kikoku", sub = "Kanaria" }
    sets.weapons.KikokuMB = { main = "Kikoku", sub="Gokotai",}
    sets.weapons.SavageBlade = { main = "Naegling", sub = "Kanaria" }

    sets.weapons.Proc_Katana = {main = 'Gassan', sub = empty, }
    sets.weapons.Proc_Sword = {main = 'Save the Queen II', sub = empty, }
    sets.weapons.Proc_Dagger = {main = 'Ceremonial Dagger', sub = empty, }
    sets.weapons.Proc_Club = {main = 'Caduceus', sub = empty, }
    sets.weapons.Proc_GKT = {main = 'Zanmato', sub = empty, }
    sets.weapons.Proc_Staff = {main = 'Earth Staff', sub = empty, }
    sets.weapons.Proc_Scythe = {main = 'Hoe', sub = empty, }
    sets.weapons.Proc_Polearm = {main = 'Tzee Xicu\'s Blade', sub = empty, }
    sets.weapons.Proc_GS = {main = 'Lament', sub = empty, }

    capes = {}
    capes.DA_TP = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    capes.MAB = { name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}}
    capes.STR_WSD = { name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    capes.AGI_WSD = "Sacro Mantle"
    capes.DEX_WSD = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}

    sets.Enmity = {
        body="Emet Harness +1",
        hands="Kurys gloves",
        legs="Zoar Subligar +1",
        feet="Ahosi Leggings",
        neck="Moonlight Necklace",
        left_ear="Friomisi Earring",
        left_ring={name="Eihwaz Ring",priority=2},
        right_ring="Petrov Ring",
    }
    sets.TreasureHunter = {hands=augmented_gear.Herculean.TH.hands,legs="Volte Hose",feet="Volte Boots"}
    
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {} --legs="Mochizuki Hakama"
    sets.precast.JA['Futae'] = {}
    sets.precast.JA['Sange'] = {} --legs="Mochizuki Chainmail"
	sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Warcry'] = sets.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        body="Passion Jacket",
    }
	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {}

    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head="Herculean Helm",
        body=augmented_gear.Adhemar.D.body,
        hands="Leyline gloves",
        legs="Gyve trousers",
        left_ring="Kishar Ring",
        right_ring="Weatherspoon Ring",
    }
		
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket",feet="Hattori Kyahan"})
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
        ammo="Happo Shuriken",
        head=augmented_gear.Adhemar.Atk.head,
        body="Ken. Samue +1",
        hands=augmented_gear.Adhemar.Atk.hands,
        back="Atheling Mantle",
        legs="Samnuha tights",
        feet=augmented_gear.Herculean.TA.feet,
        neck="Ninja Nodowa +2",
        left_ear='Telos Earring',
        right_ear="Dedition Earring",
        left_ring="Gere ring",
        right_ring="Epona's ring",
        waist="Windbuffet belt +1",
        back=capes.DA_TP,
    }
    sets.engaged.Acc = set_combine(sets.engaged, {
        head="Malignance chapeau",
        hands=augmented_gear.Adhemar.Acc.hands,
        right_ear="Mache earring +1",
    })
    sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
        hands="Malignance gloves",
        legs="Malignance tights",
        feet="Malignance boots",
        waist="Kentarch belt +1",
        left_ring="Ilabrat ring",
    })

    sets.engaged.DTLite = set_combine(sets.engaged, {
        head="Malignance chapeau",
        body="Malignance tabard",
        feet="Malignance boots",
    })
    sets.engaged.FullDT = set_combine(sets.engaged.DTLite, {
        hands="Malignance gloves",
        legs="Malignance tights",
        right_ring="Defending Ring",
    })

    -- Snapshot for ranged
    sets.precast.RA = {}
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir orb +1",
        head=augmented_gear.Adhemar.Atk.head,
        body="Mummu Jacket +1",
        hands="Ryuo Tekko +1",
        legs=augmented_gear.Herculean.CritDMG.DEX.legs,
        feet="Mummu Gamash. +1",
        neck="Ninja Nodowa +2",
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
	
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir orb +1",
        head="Ken. Jinpachi +1",
        body="Ken. Samue +1",
        hands="Mummu wrists +2",
        legs="Mummu kecks +2",
        feet="Mummu Gamash. +2",
        neck="Ninja Nodowa +2",
        waist="Windbuffet Belt +1",
        left_ear="Odr Earring",
        right_ear="Brutal Earring",
        left_ring="Mummu Ring",
        right_ring="Regal Ring",
        back=capes.AGI_WSD,})
    sets.precast.WS['Blade: Hi'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Blade: Hi'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Hi'].Fodder = set_combine(sets.precast.WS['Blade: Hi'], {})

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir orb +1",
        head="Ken. Jinpachi +1",
        body="Ken. Samue +1",
        hands="Ken. tekko +1",
        legs="Jokushu Haidate",
        feet="Ken. sune-ate +1",
        neck="Ninja Nodowa +2",
        left_ear="Brutal Earring",
        right_ear="Moonshade earring",        
        left_ring="Gere Ring",
        right_ring="Regal Ring",
        waist="Fotia Belt",
        back=capes.DA_TP,
    })
    sets.precast.WS['Blade: Shun'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Blade: Shun'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Shun'].Fodder = set_combine(sets.precast.WS['Blade: Shun'], {})

    sets.precast.WS['Blade: Metsu'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir orb +1",
        head="Adhemar jacket +1",
        body="Ken. Samue +1",
        hands="Ken. tekko +1",
        legs="Mochizuki hakama +3",
        feet="Ken. sune-ate +1",
        neck="Ninja Nodowa +2",
        left_ear="Ishvara Earring",
        right_ear="Odr earring",        
        left_ring="Epaminondas's Ring",
        right_ring="Regal Ring",
        waist="Fotia Belt",
        back=capes.DEX_WSD,
    })

    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir orb +1",
        head="Ken. Jinpachi +1",
        body="Ken. Samue +1",
        hands="Ken. tekko +1",
        legs="Jokushu Haidate",
        feet="Ken. sune-ate +1",
        neck="Ninja Nodowa +2",
        left_ear="Mache earring +1",
        right_ear="Odr Earring",   
        left_ring="Gere Ring",
        right_ring="Regal Ring",
        waist="Fotia Belt",
        back=capes.DA_TP,
    })
    sets.precast.WS['Blade: Ku'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Blade: Ku'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Ku'].Fodder = set_combine(sets.precast.WS['Blade: Ku'], {})

    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir orb +1",
        head=augmented_gear.Herculean.WSD.STR.head,
        body=augmented_gear.Herculean.WSD.DEX.body,
        hands=augmented_gear.Herculean.WSD.MAB.hands,
        legs="Mochizuki Hakama +3",
        feet=augmented_gear.Herculean.WSD.STR.feet,
        neck="Ninja Nodowa +2",
        waist="Sailfi belt +1",
        left_ear="Ishvara Earring",
        right_ear="Moonshade Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Regal Ring",
        back=capes.STR_WSD,
    })
    sets.precast.WS['Blade: Ten'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Blade: Ten'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Ten'].Fodder = set_combine(sets.precast.WS['Blade: Ten'], {})
	
    sets.precast.WS['Aeolian Edge'] = {
        head="Mochizuki Hatsuburi +3",
        body="Samnuha Coat",
        hands=augmented_gear.Herculean.WSD.MAB.hands,
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Herculean.WSD.MAB.feet,
        neck="Baetyl Pendant",
        left_ear="Friomisi Earring",
        right_ear="Moonshade Earring",
        left_ring="Shiva Ring +1",
        right_ring="Dingir Ring",
        waist="Orpheus's Sash",
        back=capes.MAB,
    }
    sets.precast.WS['Blade: Ei'] = {
        head="Mochizuki Hatsuburi +3",
        body="Samnuha Coat",
        hands=augmented_gear.Herculean.WSD.MAB.hands,
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Herculean.WSD.MAB.feet,
        neck="Baetyl Pendant",
        left_ear="Friomisi Earring",
        right_ear="Moonshade Earring",
        left_ring="Shiva Ring +1",
        right_ring="Dingir Ring",
        waist="Orpheus's Sash",
        back=capes.MAB,
    }
    sets.precast.WS['Blade: Chi'] = {
        head="Mochizuki Hatsuburi +3",
        body="Samnuha Coat",
        hands=augmented_gear.Herculean.WSD.MAB.hands,
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Herculean.WSD.MAB.feet,
        neck="Baetyl Pendant",
        left_ear="Friomisi Earring",
        right_ear="Moonshade Earring",
        left_ring="Shiva Ring +1",
        right_ring="Dingir Ring",
        waist="Orpheus's Sash",
        back=capes.MAB,
    }
    sets.precast.WS['Blade: Teki'] = {
        head="Mochizuki Hatsuburi +3",
        body="Samnuha Coat",
        hands=augmented_gear.Herculean.WSD.MAB.hands,
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Herculean.WSD.MAB.feet,
        neck="Baetyl Pendant",
        left_ear="Friomisi Earring",
        right_ear="Moonshade Earring",
        left_ring="Shiva Ring +1",
        right_ring="Dingir Ring",
        waist="Orpheus's Sash",
        back=capes.MAB,
    }
    sets.precast.WS['Blade: Yu'] = {
        head="Mochizuki Hatsuburi +3",
        body="Samnuha Coat",
        hands=augmented_gear.Herculean.WSD.MAB.hands,
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Herculean.WSD.MAB.feet,
        neck="Baetyl Pendant",
        left_ear="Friomisi Earring",
        right_ear="Moonshade Earring",
        left_ring="Shiva Ring +1",
        right_ring="Dingir Ring",
        waist="Orpheus's Sash",
        back=capes.MAB,
    }

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

    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

    sets.midcast.ElementalNinjutsu = set_combine(sets.midcast.FastRecast, {
        main="Malevolence",
        sub="Malevolence",
        ammo="Pemphredo Tathlum",
        head="Mochizuki Hatsuburi +3",
        body="Samnuha Coat",
        hands=augmented_gear.Herculean.WSD.MAB.hands,
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Herculean.WSD.MAB.feet,
        neck="Baetyl Pendant",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Dingir Ring",
        right_ring="Shiva Ring +1",
        waist="Orpheus's Sash",
        back=capes.MAB,
    })
    sets.buff.Futae = {
        hands = "Hattori Tekko +1",
    }
		
    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})
	
	sets.MagicBurst = {
        left_ring = "Locus Ring",
        right_ring = "Mujin Band",
    }
	
	sets.element.Earth = {}
    sets.element.Lightning = { ranged = "Donar Gun", ammo=empty}

    sets.midcast.NinjutsuDebuff = {hands="Mochizuki Tekko +1",}

    sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {hands="Mochizuki Tekko +1",})
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {
        feet="Hattori Kyahan",
        back=capes.DA_TP,
    })

    sets.midcast.RA = {}
		
    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = set_combine(sets.engaged.FullDT, {
        hands="Malignance gloves",
    })

    sets.idle.PDT = {}
		
    sets.idle.Sphere = set_combine(sets.idle, {})
		
    sets.idle.Weak = {}
    
    -- Defense sets
    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
	sets.defense.MEVA = {}


    sets.Kiting = {feet="Danzo sune-ate"}
	sets.DuskKiting = {feet="Hachiya kyahan +1"}
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


function user_job_aftercast(spell, spellMap, eventArgs)
    if spellMap == 'ElementalNinjutsu' and state.NukingMode.value ~= 'Never' then
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
    if spellMap == 'ElementalNinjutsu' and state.NukingMode.value ~= 'Never' and (state.NukingMode.value == 'Always' or tonumber(state.NukingMode.value) > player.tp) then
        enable('main')
        enable('sub')
        enable('ranged')
        enable('range')
        enable('ammo')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 4)
    windower.chat.input:schedule(1,'/lockstyleset 3')
end