
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'MegaAcc','Crits')
    state.RangedMode:options('Normal', 'Acc','FullAcc')
    state.WeaponskillMode:options('Match','Normal', 'Acc','Proc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
    state.RHAutoWS = M{'','Leaden Salute', 'Last Stand'}
    state.Weapons:options('ShieldLeaden','ShieldLastStand','DWLeaden','DWLastStand', 'SavageBlade', 'None')

    state.LastRoll = 'unknown'
    ammostock = 99

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Orichalcum Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

	gear.tp_ranger_jse_back = {}
	gear.snapshot_jse_back = {name="Camulus's Mantle",augments={'"Snapshot"+10',}}
	gear.tp_jse_back = {name="Camulus's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.ranger_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.magic_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.str_wsd_jse_back = {name="Camulus's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    -- Additional local binds
	send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')
	
	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	
	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')

	send_command('bind !r gs c weapons SingleWeapon;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons DualRangedWeapons;gs c update')
	send_command('bind !q gs c weapons SavageWeapons;gs c update')
	send_command('bind @pause roller roll')

    send_command('gs rh set')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    include('augmented_gear.lua')


    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    sets.weapons = {}
    sets.weapons.ShieldLeaden = {main='Fettering Blade', sub="Nusku Shield", range="Fomalhaut"}
    sets.weapons.DWLeaden = {main='Fettering Blade', sub="Atoyac", range="Fomalhaut"}
    sets.weapons.ShieldLastStand = {main='Kustawi +1', sub="Nusku Shield", range="Fomalhaut"}
    sets.weapons.DWLastStand = {main='Fettering Blade', sub="Kustawi +1", range="Fomalhaut"}
    sets.weapons.SavageBlade = {main='Hepatizon sapara +1', sub="Atoyac", range="Anarchy +2"}

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

    sets.engaged.MegaAcc = set_combine(sets.engaged.Acc, {
        head="Meghanada visor +2",
        legs="Meghanada chausses +2",
    })

    sets.engaged.Crits = set_combine(sets.engaged.MegaAcc, {
        head="Mummu bonnet +1",
        body="Mummu Jacket +2",
        hands="Mummu Wrists +1",
        legs="Mummu kecks +1",
        feet="Mummu Gamashes +1"
    })

    sets.engaged.DW = set_combine(sets.engaged, {})
    
    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {})
    
    sets.engaged.DW.MegaAcc = set_combine(sets.engaged.MegaAcc, {})


    sets.precast.CorsairShot = {
        head=augmented_gear.Herculean.WSD.MAB.head,
        neck="Sanctity necklace",
        body="Samnuha Coat",
        hands="Carmine Finger Gauntlets +1",
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Adhemar.D.feet,
        neck="Sanctity Necklace",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Strendu Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
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
        legs="Mummu kecks +1",
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
    
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.RA = {
        ammo=gear.RAbullet,
        head={ name="Taeon Chapeau", augments={'Accuracy+14 Attack+14','"Snapshot"+5','"Snapshot"+5',}}, -- s10
        body="Oshosi Vest", --s12
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- s8 r11
        back="Navarch's Mantle", -- s7
        waist="Impulse belt", -- s3
        legs=augmented_gear.Adhemar.D.legs, --s9 r10
        feet="Meghanada Jambeaux +2" -- s10
    }
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {body="Laksamana's frac +3", waist="Yemaya belt"})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, {head="Chasseur's tricorne +1", waist="Impulse Belt", feet="Pursuer's Gaiters"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
		
    sets.precast.WS.Acc = {}		
		
    sets.precast.WS.Proc = {}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.engaged, {
        head=augmented_gear.Herculean.WSD.STR.head,
        neck="Fotia Gorget",
        ear1="Moonshade earring",
        ear2="Ishvara Earring",
        body="Laksamana's frac +3",
        hands="Meghanada gloves +2",
        ring1="Ifrit ring +1",
        ring2="Ilabrat ring",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
        waist="Prosilio belt",
        legs=augmented_gear.Herculean.WSD.STR.legs,
        feet=augmented_gear.Herculean.WSD.STR.feet,       
    })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast['Savage Blade'], {  
        ear1="Cessance earring",
        ear2="Dignitary's earring",
        body="Mummu Jacket +2",
        waist="Fotia belt",
    })
	
    sets.precast.WS['Last Stand'] = {
        ammo=gear.WSbullet,
        head="Meghanada visor +2",
        body="Laksamana's frac +3",
        hands="Meghanada gloves +2",
        legs=augmented_gear.Herculean.WSD.AGI.legs,
        feet="Lanun Bottes +3",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Moonshade Earring",
        right_ear="Ishvara Earring",
        left_ring="Apate Ring",
        right_ring="Garuda ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'],{
        right_ear="Telos Earring",
        left_ring="Hajduk Ring",
        feet="Meghanada Jambeaux +2"
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
        left_ear="Friomisi Earring",
        right_ear="Moonshade Earring",
        ring2="Acumen ring",
        ring1="Archon Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
        --back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','"Mag.Atk.Bns."+10',}},
    }

    sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS["Leaden Salute"],{
        neck="Sanctity necklace",
        left_ear="Hermetic Earring",
        right_ear="Dignitary's Earring",
        body="Mummu Jacket +2",
        waist="Kwahu Kachina belt",
        })

    sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS["Leaden Salute"], {})

    sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], {})
		
    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS['Wildfire'], {})
    sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS['Wildfire'].Acc, {})
		
		--Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Meghanada visor +2",
        ear2="Telos earring",
        ear1="Dedition earring",
        neck="Marked Gorget",
        body="Oshosi vest",
        hands=augmented_gear.Adhemar.Rng.hands,
        ring1="Ilabrat ring",
        ring2="Hajduk ring +1",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}},
        waist="Yemaya belt",
        legs=augmented_gear.Adhemar.Rng.legs,
        feet=augmented_gear.Adhemar.Rng.feet,
    }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA,{
        ear1="Volley Earring",
        body="Laksamana's frac +3",
        feet="Meg. Jam. +2"
    })

    sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA.Acc,{
        hands="Meghanada gloves +2",
        ring1="Hajduk ring",
        waist="Kwahu Kachina belt",
        legs="Meg. Chausses +2",
    })
		
	sets.buff['Triple Shot'] = set_combine(sets.midcast.RA, {
        head="Oshosi mask",
        hands="Lanun gants +3",
        body="Chasseur's Frac +1",
        feet="Oshosi Leggings"
    })

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
        neck="Wiglen Gorget",
        waist="Flume Belt",
        left_ear="Ethereal Earring",
        left_ring="Warden's Ring",
        back="moonbeam cape",
    })
		
    sets.idle.Refresh = set_combine(sets.idle, {})

    sets.idle.Town = set_combine(sets.idle, {
        neck="Regal Necklace", 
        hands="Carmine Finger Gauntlets +1",
        ring1="Ilabrat ring",
        waist="Yemaya belt",
        legs="Carmine Cuisses +1"})
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, {})

    sets.defense.MDT = set_combine(sets.idle, {})
		
    sets.defense.MEVA = set_combine(sets.idle, {})

    sets.Kiting = {legs="Carmine Cuisses +1"}
	
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", waist = "Chaac belt"})
	
	sets.DWMax = {}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
        set_macro_page(1, 15)
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
    if spell.type == "CorsairRoll" and not buffactive[spell.english] then
        state.LastRoll = spell.english
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