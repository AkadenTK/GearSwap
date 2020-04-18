-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','FullAcc')
    state.HybridMode:options('Normal', 'DTLite','PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal','Acc','FullAcc')
	state.IdleMode:options('Normal', 'Refresh')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('Default','TreasureHunter','SavageBlade','None')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.da_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.wsd_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
    send_command('bind !- gs c cycle targetmode')
	send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace gs c weapons Throwing;gs c update')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    include('organizer-lib')
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------
    augmented_gear.capes = {}
    augmented_gear.capes.STP = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {waist="Chaac belt", hands="Plunderer's Armlets +1",legs="Volte Hose",feet="Skulk. Poulaines"})
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Fajin Boots"}
    sets.Capacity={back="Aptitude Mantle"}

    sets.weapons = {}
    sets.weapons.Default = {main="Tauret", sub="Sandung"}
    sets.weapons.TreasureHunter = {main="Taming sari", sub="Sandung"}
    sets.weapons.SavageBlade = {main="Naegling", sub="Sandung"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	
    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}
		
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {left_ear="Suppanomimi", right_ear="Sherida Earring"}
	sets.Weapons = {}
	sets.MagicWeapons = {}
	sets.Throwing = {}
	sets.DWEarrings = {}
	sets.DWMax = {}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	
    -- Actions we want to use to tag TH.
    sets.precast.Step = set_combine(sets.engaged.Acc, {})
		
    sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.TreasureHunter, {})
	sets.precast.JA.Provoke = set_combine(sets.TreasureHunter, {})

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {} --head="Skulker's Bonnet"
    sets.precast.JA['Accomplice'] = {} --head="Skulker's Bonnet"
    sets.precast.JA['Flee'] = {} --feet="Pillager's Poulaines +1"
    sets.precast.JA['Hide'] = {} --body="Pillager's Vest +1"
    sets.precast.JA['Conspirator'] = {} --body="Skulker's Vest"
    sets.precast.JA['Steal'] = {hands="Pill. Armlets +1"}
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {legs="Skulker's Culottes",feet="Skulk. Poulaines"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = set_combine(sets.buff['Sneak Attack'], {})
    sets.precast.JA['Trick Attack'] = set_combine(sets.buff['Trick Attack'], {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
		
	sets.Self_Waltz = {}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Impatiens",
        head="Herculean Helm",
        body=augmented_gear.Adhemar.D.body,
        hands="Leyline Gloves",
        legs=augmented_gear.Herculean.FC.legs,
        feet=augmented_gear.Herculean.FC.feet,
        neck="Baetyl Pendant",
        waist="Windbuffet Belt +1",
        left_ear="Hearty Earring",
        right_ear="Eabani Earring",
        left_ring="Lebeche Ring",
        right_ring="Weather. Ring",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    -- Ranged snapshot gear
    sets.precast.RA = {}


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
        ammo="Ginsen",
        head=augmented_gear.Adhemar.Atk.head,
        body=augmented_gear.Adhemar.Atk.body,
        hands=augmented_gear.Adhemar.Atk.hands,
        legs="Samnuha tights",
        feet=augmented_gear.Herculean.TA.feet,
        neck="Anu Torque",
        left_ear='Suppanomimi',
        right_ear="Sherida Earring",
        left_ring="Gere ring",
        right_ring="Epona's ring",
        waist="Windbuffet belt +1",
        back=augmented_gear.capes.STP,
    }
    
    sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Falcon Eye",
        head=augmented_gear.Adhemar.Acc.head,
        body=augmented_gear.Adhemar.Acc.body,
        hands=augmented_gear.Adhemar.Acc.hands,
        right_ear="Telos earring",
        waist="Kentarch belt +1",
    })
        
    sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
        left_ear="Dignitary's earring",
        neck='Subtlety Spectacles',
    })

    sets.engaged.DTLite = set_combine(sets.engaged, {
        head="Malignance Chapeau",
        hands="Malignance Gloves",  
        legs="Malignance Tights",
        neck="Loricate Torque +1",
        right_ring="Defending Ring",
        ammo="Staunch Tathlum +1",
    })

    --sets.engaged.PDT = {}

    --sets.engaged.SomeAcc.PDT = {}

    --sets.engaged.Acc.PDT = {}

    --sets.engaged.FullAcc.PDT = {}
    --    
    --sets.engaged.Fodder.PDT = {}

    --------------------------------------
    -- Weaponskill sets
    --------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})

    sets.sata = {
        head=augmented_gear.Adhemar.Atk.head,
        body="Abnoba Kaftan",
        legs=augmented_gear.Herculean.CritDMG.DEX.legs,
    }
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
        ammo="Jukukik Feather",
        head=augmented_gear.Lustratio.DEX.head,
        body=augmented_gear.Adhemar.Atk.body,
        hands="Meg. Gloves +2",
        legs=augmented_gear.Lustratio.DEX.legs,
        feet=augmented_gear.Lustratio.DEX.feet,
        waist="Chaac Belt",
        neck="Caro Necklace",
        left_ear="Odr Earring",
        right_ear="Moonshade Earring",
        left_ring="Regal Ring",
        right_ring="Epaminondas's Ring",
        back="Sacro Mantle",
    })
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS["Rudra's Storm"].Acc, {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], sets.sata)
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], sets.sata)
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], sets.sata)
	
    sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS["Mandalic Stab"], {})
	sets.precast.WS["Mandalic Stab"].FullAcc = set_combine(sets.precast.WS["Mandalic Stab"].Acc, {})
    sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, sets.sata)
    sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, sets.sata)
    sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, sets.sata)

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS["Shark Bite"], {})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS["Shark Bite"].Acc, {})
    sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {})
    sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {})
    sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo="Jukukik Feather",
        head=augmented_gear.Adhemar.Atk.head,
        body="Abnoba Kaftan",
        hands="Meg. Gloves +2",
        legs=augmented_gear.Herculean.CritDMG.DEX.legs,
        feet="Mummu Gamash. +1",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Odr Earring",
        right_ear="Sherida Earring",
        left_ring="Regal Ring",
        right_ring="Mummu Ring",
        back="Sacro Mantle",
    })
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS['Evisceration'].Acc, {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})

    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        head=augmented_gear.Herculean.WSD.MAB.head,
        body={ name="Samnuha Coat", augments={'Mag. Acc.+11','"Mag.Atk.Bns."+10','"Fast Cast"+3',}},
        hands="Meg. Gloves +2",
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Herculean.WSD.MAB.feet,
        neck="Sanctity Necklace",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Ilabrat Ring",
        right_ring="Karieyh Ring",
        back="Toro Cape",})

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)
    
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ammo="Floestone",
        head=augmented_gear.Lustratio.STR.head,
        body=augmented_gear.Lustratio.STR.body,
        hands="Meg. Gloves +2",
        legs=augmented_gear.Herculean.WSD.STR.legs,
        feet=augmented_gear.Herculean.WSD.STR.feet,
        neck="Caro Necklace",
        left_ear="Ishvara Earring",
        right_ear="Moonshade Earring",
        left_ring="Gere ring",
        right_ring="Regal ring",
        waist="Prosilio Belt +1",
        back="Sacro Mantle",
    })
    sets.precast.WS["Savage Blade"].SA = set_combine(sets.precast.WS["Savage Blade"].Fodder, sets.sata)
    sets.precast.WS["Savage Blade"].TA = set_combine(sets.precast.WS["Savage Blade"].Fodder, sets.sata)
    sets.precast.WS["Savage Blade"].SATA = set_combine(sets.precast.WS["Savage Blade"].Fodder, sets.sata)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear

    sets.midcast.RA = {}

    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = set_combine(sets.engaged, {
        ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance tights",
        feet="Malignance boots",
        neck="Loricate Torque +1",
        left_ear="Hearty Earring",
        right_ear="Eabani Earring",
        left_ring="Defending Ring",
        right_ring="Sheltered Ring",
    })
		
    sets.idle.Refresh = set_combine(sets.idle, {
        legs=augmented_gear.Herculean.Refresh.legs,
        right_ring="Stikini Ring +1",
    })

    sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Defense sets

    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance tights",
        feet="Malignance boots",
        waist="Flume Belt",
        neck="Loricate Torque +1",
        left_ear="Hearty Earring",
        right_ear="Eabani Earring",
        left_ring="Defending Ring",
        right_ring="Sheltered Ring",
    }

    sets.defense.MDT = {}
		
	sets.defense.MEVA = {}

		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 10)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 10)
    else
        set_macro_page(1, 10)
    end
end

--Dynamis Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[936] == 0 and not have_trust("Karaha-Baruha") then
					windower.send_command('input /ma "Karaha-Baruha" <me>')
					return true
				elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					return true
				elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					return true
				elseif spell_recasts[989] == 0 and not have_trust("KingofHearts") then
					windower.send_command('input /ma "King of Hearts" <me>')
					return true
				elseif spell_recasts[968] == 0 and not have_trust("Adelheid") then
					windower.send_command('input /ma "Adelheid" <me>')
					return true
				else
					return false
				end
			end
		end
	end
	return false
end