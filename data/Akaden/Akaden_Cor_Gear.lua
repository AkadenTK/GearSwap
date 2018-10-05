
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc','Crits')
    state.RangedMode:options('Normal', 'Acc','FullAcc','Crits')
    state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.WeaponskillMode:options('Match','Normal', 'Acc','FullAcc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
    state.RHAutoWS = M{'','Leaden Salute', 'Last Stand','Wildfire'}
    state.Weapons:options('DWLeaden','DWLastStand', 'SavageBlade', 'ShieldLeaden','ShieldLastStand','OneShot','MeleeLeaden','None')
    state.QuickDrawMode = M{'StoreTP','Damage'}
    state.QuickDrawAug = false

    state.LastRoll = 'unknown'
    ammostock = {}
    ammostock['Chrono Bullet'] = 100
    ammostock['Living Bullet'] = 30

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

	gear.tp_ranger_jse_back = {}
	gear.snapshot_jse_back = {name="Camulus's Mantle",augments={'"Snapshot"+10',}}
	gear.tp_jse_back = {name="Camulus's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.ranger_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.magic_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.str_wsd_jse_back = {name="Camulus's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    -- Additional local binds
	--send_command('bind !f11 gs c cycle ExtraMeleeMode')
	--send_command('bind ^` gs c cycle ElementalMode')
	--send_command('bind !` gs c elemental quickdraw')
	--
	--send_command('bind ^backspace input /ja "Double-up" <me>')
	--send_command('bind @backspace input /ja "Snake Eye" <me>')
	--send_command('bind !backspace input /ja "Fold" <me>')
	--send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	--
	--send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    --send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	--send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	--send_command('bind @f7 gs c toggle RngHelper')
--
	--send_command('bind !r gs c weapons SingleWeapon;gs c update')
	--send_command('bind @q gs c weapons MaccWeapons;gs c update')
	--send_command('bind ^q gs c weapons DualRangedWeapons;gs c update')
	--send_command('bind !q gs c weapons SavageWeapons;gs c update')
	--send_command('bind @pause roller roll')
--
    --send_command('gs rh set')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    include('augmented_gear.lua')


    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    sets.weapons = {}
    sets.weapons.ShieldLeaden = {main='Fettering Blade', sub="Nusku Shield", range="Death Penalty"}
    sets.weapons.DWLeaden = {main='Fettering Blade', sub="Hepatizon rapier", range="Death Penalty"}
    sets.weapons.ShieldLastStand = {main='Kustawi +1', sub="Nusku Shield", range="Fomalhaut"}
    sets.weapons.DWLastStand = {main='Fettering Blade', sub="Kustawi +1", range="Fomalhaut"}
    sets.weapons.SavageBlade = {main='Hepatizon sapara +1', sub="Blurred Knife +1", range="Anarchy +2"}
    sets.weapons.OneShot = {main='Fettering Blade', sub="Hepatizon rapier", range="Fomalhaut"}
    sets.weapons.MeleeLeaden = {main='Fettering Blade', sub="Blurred Knife +1", range="Death Penalty"}

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", waist = "Chaac belt", feet=augmented_gear.Herculean.TH.feet})
    
    -- Precast Sets

    -- Precast sets to enhance JAs
	
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun trews +1"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}
    
    sets.precast.CorsairRoll = {
        head="Lanun Tricorne +1",
        neck="Regal necklace",
        hands="Chasseur's Gants +1",
        back="Camulus's Mantle",
        Ring2="Luzaf's Ring"}
		
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    sets.PDT = {
        head="Meghanada Visor +2",
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +2",
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Loricate Torque +1",
        waist="Flume Belt",
        ear1="Ethereal Earring",
        ring1="Warden's Ring",
        ring2="Yacuruna Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},    
    }    

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head=augmented_gear.Adhemar.Atk.head,
        neck="Asperity Necklace",
        ear1='Suppanomimi',
        ear2="Brutal Earring",
        body=augmented_gear.Adhemar.Atk.body,
        hands=augmented_gear.Adhemar.Atk.hands,
        ring1="Ilabrat ring",
        ring2="Epona's ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
        waist="Windbuffet belt +1",
        legs="Samnuha tights",
        feet=augmented_gear.Herculean.TA.feet,
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        head=augmented_gear.Adhemar.Acc.head,
        neck="Ej necklace",
        ear2="Dignitary's earring",
        body=augmented_gear.Adhemar.Acc.body,
        hands=augmented_gear.Adhemar.Acc.hands,
        waist="kentarch belt +1",
    })

    sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
        head="Meghanada visor +2",
        legs="Meghanada chausses +2",
    })

    sets.engaged.Crits = set_combine(sets.engaged.FullAcc, {
        head="Mummu bonnet +1",
        body="Mummu Jacket +2",
        hands="Mummu Wrists +1",
        legs="Mummu Kecks +2",
        feet="Mummu Gamashes +1"
    })

    sets.engaged.DTLite = set_combine(sets.engaged,{
        head="Meghanada visor +2",
        neck="Loricate Torque +1",
        ring1="Defending ring",
        waist="Flume Belt",
    })

    sets.engaged.DW = set_combine(sets.engaged, {})
    
    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {})
    
    sets.engaged.DW.FullAcc = set_combine(sets.engaged.FullAcc, {})

    sets.engaged.DW.Hybrid = set_combine(sets.engaged.Hybrid, {})

    sets.engaged.DW.DTLite = set_combine(sets.engaged.DTLite, {})

    gear.CorsairShot = {}
    gear.CorsairShot.Augment = {feet="Chasseur's bottes +1",}
    sets.precast.CorsairShot = {
        head=augmented_gear.Herculean.WSD.MAB.head,
        neck="Baetyl pendant",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
        body="Lanun Frac +3",
        hands="Carmine Finger Gauntlets +1",
        ring1="Dingir Ring",
        ring2="Acumen Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
        waist="Eschan Stone",
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet="Lunan bottes +3",
    }
    sets.precast.CorsairShot.StoreTP = set_combine(sets.precast.CorsairShot,{ -- 57 STP
        neck="Ainia collar", --8
        ear1="Dedition earring", --8
        ear2="Telos Earring", -- 5
        body="Oshosi Vest", -- 7
        hands="Adhemar Wristbands +1", -- 7
        ring1="Ilabrat Ring", -- 5
        ring2="Petrov Ring", -- 5
        waist="Kentarch belt +1",  -- 1-5
        legs=augmented_gear.Adhemar.D.legs, -- 7
        feet=augmented_gear.Adhemar.D.feet, -- 6
    })
    sets.precast.CorsairShot.Proc = set_combine(sets.precast.CorsairShot, {})

    sets.precast.CorsairShot.Acc =  set_combine(sets.precast.CorsairShot['Light Shot'], {
        head="Carmine mask",
        ear1="Dignitary's earring",
        ear2="Hermetic earring",
        body="Mummu jacket +2",
        hands="Leyline gloves",
        ring1="Stikini ring",
        ring2="Sangoma ring",
        waist="Kwahu kachina belt",
        legs="Mummu Kecks +2",
        feet="Mummu gamashes +1"
        })

    sets.precast.CorsairShot['Light Shot'] = set_combine(sets.precast.CorsairShot.Acc, {})

    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot.Acc, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = { }
		
	sets.Self_Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = set_combine(sets.engaged, {
        ring2="Lebeche ring",
        head="Carmine mask",
        neck="Baetyl pendant", 
        body="Samnuha coat",
        hands="Leyline gloves",
        ring1="Kishar ring",
        ring2="Weatherspoon ring",
        legs="Carmine Cuisses +1", --interruption down
        feet="Carmine Greaves +1",
        ear1="Halasz earring", -- interruption down
    })

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga beads"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.RA = { -- s69 r56
        ammo=gear.RAbullet,
        head={ name="Taeon Chapeau", augments={'Accuracy+14 Attack+14','"Snapshot"+5','"Snapshot"+5',}}, -- s10
        body="Oshosi Vest", --s12
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- s8 r11
        back={ name="Camulus's Mantle", augments={'"Snapshot"+10',}}, -- s10
        waist="Yameya belt", -- r5
        legs=augmented_gear.Adhemar.D.legs, --s9 r10
        feet="Meghanada Jambeaux +2" -- s10
    }
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, { -- s70 r71
        body="Laksamana's frac +3", --r20
        waist="Impulse Belt",  --s3
    })
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, { --s65 r95
        head="Chasseur's tricorne +1", --r14
        feet="Pursuer's Gaiters", --r10
    })

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
		
    sets.precast.WS.Acc = {}		
		
    sets.precast.WS.Proc = {}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.engaged, {
        head=augmented_gear.Herculean.WSD.STR.head,
        neck="Caro necklace",
        ear1="Moonshade earring",
        ear2="Ishvara Earring",
        body="Laksamana's frac +3",
        hands="Meghanada gloves +2",
        ring1="Ilabrat ring",
        ring2="Ifrit ring +1",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
        waist="Prosilio belt",
        legs=augmented_gear.Herculean.WSD.STR.legs,
        feet="Lanun bottes +3",       
    })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast['Savage Blade'], {  
        ear1="Cessance earring",
        ear2="Dignitary's earring",
        body="Mummu Jacket +2",
        waist="Fotia belt",
    })

    sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'].Acc, {})
	
    sets.precast.WS['Last Stand'] = {
        ammo=gear.WSbullet,
        head="Meghanada visor +2",
        body="Laksamana's frac +3",
        hands="Meghanada gloves +2",
        legs=augmented_gear.Herculean.WSD.AGI.legs,
        feet="Lanun Bottes +3",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Ilabrat ring",
        ring2= "Dingir Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'],{
        ear2="Telos Earring",
        ring1="Cacoethic Ring +1",
        feet="Meghanada Jambeaux +2"
        })

    sets.precast.WS['Last Stand'].FullAcc = set_combine(sets.precast.WS['Last Stand'].Acc,{
        ring2="Cacoethic Ring",
        })
		
    sets.precast.WS['Detonator'] = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, {})
    sets.precast.WS['Slug Shot'] = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Slug Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, {})
    sets.precast.WS['Numbing Shot'] = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Numbing Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, {})
    sets.precast.WS['Sniper Shot'] = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Sniper Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, {})
    sets.precast.WS['Split Shot'] = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Split Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, {})
	
    sets.precast.WS['Leaden Salute'] = {        
        ammo=gear.MAbullet,
        head="Pixie Hairpin +1",
        body="Lanun frac +3",
        hands="Carmine Finger Gauntlets +1",
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet="Lanun Bottes +3",
        neck="Baetyl pendant",
        waist="Svelt. Gouriz +1",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        ring1="Archon Ring",
        ring2="Dingir ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
        --back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','"Mag.Atk.Bns."+10',}},
    }

    sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'],{
        neck="Sanctity necklace",
        ear1="Hermetic Earring",
        ear2="Dignitary's Earring",
        body="Mummu Jacket +2",
        waist="Eschan Stone",
        })

    sets.precast.WS['Leaden Salute'].FullAcc = set_combine(sets.precast.WS['Leaden Salute'], {
        waist="Kwahu Kachina belt",
        })

    sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS["Leaden Salute"], {
        head=augmented_gear.Herculean.WSD.MAB.head,
        ring1="Acumen ring",
        })

    sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], {})
		
    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS['Wildfire'], {})
    sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS['Wildfire'].Acc, {})
		
		--Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear2="Ishvara Earring"}
	sets.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
        
    -- Specific spells

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {}
    sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {}
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Meghanada visor +2",
        ear2="Telos earring",
        ear1="Dedition earring",
        neck="Iskur Gorget",
        body="Oshosi vest",
        hands=augmented_gear.Adhemar.Rng.hands,
        ring1="Ilabrat ring",
        ring2="Cacoethic ring +1",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
        waist="Yemaya belt",
        legs=augmented_gear.Adhemar.Rng.legs,
        feet=augmented_gear.Adhemar.Rng.feet,
    }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA,{
        ear1="Volley Earring",
        body="Laksamana's frac +3",
        feet="Meg. Jam. +2"
    })

    sets.midcast.RA.Crits = set_combine(sets.midcast.RA,{
      head="Mummu bonnet +2",
      body="Mummu jacket +2",
      hands="Chasseur's gants +1",  
      ring2="Begrudging ring", 
      waist="Kwahu kachina belt",
      legs="Mummu kecks +2",
      feet="Oshosi leggings",
    })

    sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA.Acc,{
        hands="Meghanada gloves +2",
        ring1="Cacoethic ring",
        waist="Kwahu Kachina belt",
        legs="Meg. Chausses +2",
    })
		
	sets.buff['Triple Shot'] = {
        head="Oshosi mask",
        hands="Lanun gants +3",
        body="Chasseur's Frac +1",
        feet="Oshosi Leggings"
    }

    sets.buff['Weakness'] = {
        back="Moonbeam cape"
    }
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = set_combine(sets.engaged, {
        head="Meghanada visor +2",
        body="Laksamana's frac +3",
        --hands=augmented_gear.Herculean.Refresh.hands,
        legs="Meg. Chausses +1",
        feet="Lanun Bottes +3",
        neck="Loricate Torque +1",
        waist="Flume Belt",
        ear1="Ethereal Earring",
        ring1="Defending ring",
    })
		
    sets.idle.Refresh = set_combine(sets.idle, {})

    sets.idle.Town = set_combine(sets.idle, {
        neck="Regal Necklace", 
        hands="Carmine Finger Gauntlets +1",
        ring1="Ilabrat ring",
        waist="Yemaya belt",
        legs="Carmine Cuisses +1"})
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, {
        head="Meghanada Visor +2",
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +2",
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Loricate Torque +1",
        waist="Flume Belt",
        ear1="Ethereal Earring",
        ear2="Brutal Earring",
        ring1="Warden's Ring",
        ring2="Epona's Ring",
        back="Moonbeam Cape",})

    sets.idle.PDT = set_combine(sets.defense.PDT, {})

    sets.defense.MDT = set_combine(sets.idle, {})
		
    sets.defense.MEVA = set_combine(sets.idle, {})

    sets.Kiting = {legs="Carmine Cuisses +1"}
	
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", waist = "Chaac belt"})
	
	sets.DWMax = {}

end

function user_job_self_command(commandArgs, eventArgs)
    if commandArgs[1]:lower() == 'corsairshotaug' then
        state.QuickDrawAug = true
        job_self_command({'elemental','quickdraw'}, eventArgs)
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 15)
    
    windower.chat.input:schedule(1,'/lockstyleset 18')
end

function user_job_pretarget(spell, spellMap, eventArgs)
    if spell.type == "CorsairRoll" and 
        buffactive[spell.english] and 
        buffactive["Double-Up Chance"] and 
        (state.LastRoll == spell.english or state.LastRoll == 'unknown') then 

        cancel_spell()
        send_command('input /ja "Double-Up" <me>')
    end 
end

function user_job_post_precast(spell, spellMap, eventArgs)

    --if spell.type == 'WeaponSkill' then
    --    -- Replace Moonshade Earring if we're at cap TP
    --    if (player.tp >= 2950 and moonshade_ws:contains(spell.english)) or
    --       (player.tp >= 2450 and moonshade_ws:contains(spell.english)) and ) then
    --        if check_ws_acc():contains('Acc') then
    --            if sets.AccMaxTP then
    --                equip(sets.AccMaxTP)
    --            end
    --        elseif sets.MaxTP then
    --                equip(sets.MaxTP)
    --        end
    --    end
    -- end   
    if spell.type == "CorsairRoll" and not buffactive[spell.english] then
        state.LastRoll = spell.english
    end
    if spell.type == 'CorsairShot' then
        if state.QuickDrawMode.value == 'StoreTP' then
            equip(sets.precast.CorsairShot.StoreTP)
        end
        if state.QuickDrawAug then
            equip(gear.CorsairShot.Augment)
            state.QuickDrawAug = false
        end
    end
end

function user_job_buff_change(buff, gain)
    check_weakness()
    if gain and buff == "Bust" and state.LastRoll ~= nil then
        lastRoll = state.LastRoll
        state.LastRoll = nil
    elseif not gain and state.LastRoll == buff then
        state.LastRoll = nil
    end
    if gain and buff == "Aurorastorm" then
        send_command('cancel 184')
        send_command('cancel 595')
        add_to_chat(123,'Auto-canceled Aurorastorm')
    end
end
function check_weakness()
    if buffactive["Weakness"] then
        equip(sets.buff["Weakness"])
        for slot, piece in pairs(sets.buff['Weakness']) do
            disable(slot)
        end
    else
        for slot, piece in pairs(sets.buff['Weakness']) do
            enable(slot)
        end
    end
end

windower.register_event('zone change', function()
    state.LastRoll = nil
    check_weakness()
end)