-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('AeneasTPBonus', 'AeneasTernion','LowBuff')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}

	
	gear.stp_jse_back = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.wsd_jse_back = {name="Senuna's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	
    -- Additional local binds
    send_command('bind @` gs c step')
	send_command('bind ^!@` gs c toggle usealtstep')
	send_command('bind ^@` gs c cycle mainstep')
	send_command('bind !@` gs c cycle altstep')
    send_command('bind ^` input /ja "Saber Dance" <me>')
    send_command('bind !` input /ja "Fan Dance" <me>')
	send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
	send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
	send_command('bind !backspace input /ja "Reverse Flourish" <me>')
	send_command('bind ^backspace input /ja "No Foot Rise" <me>')
	send_command('bind %~` gs c cycle SkillchainMode')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	
    -- Extra Melee sets.  Apply these on top of melee sets.
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket +1",hands="Floral Gauntlets",waist="Shetal Stone"}
	
	-- Weapons sets
    sets.weapons.AeneasTPBonus = {main="Aeneas",sub="Fusetto +2"}
	sets.weapons.AeneasTernion = {main="Aeneas",sub="Ternion Dagger +1"}
    sets.weapons.LowBuff = {main="Aeneas",sub="Blurred Knife +1"}
	sets.weapons.trial = {main="Fusetto",sub="Ternion dagger +1"}

    augmented_gear.capes = {}
    augmented_gear.capes.da = 'Sacro Mantle'
    augmented_gear.capes.dex_wsd = 'Sacro Mantle'
    
	
    -- Precast Sets
    
    -- Precast sets to enhance JAs

    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +1"} --body="Horos Casaque +1"

    sets.precast.JA['Trance'] = {head="Horos Tiara +1"} --head="Horos Tiara +1"
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Horos Tiara +1",
        body="Maxixi Casaque +1",
        legs="Dashing Subligar",
        feet="Maxixi Toe Shoes +1"
    }
		
	sets.Self_Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Samba = {head="Maxixi tiara +1", back=gear.stp_jse_back} --head="Maxixi Tiara"

    sets.precast.Jig = {legs="Horos Tights +3", feet="Maxixi Toe Shoes +1"} --legs="Horos Tights", feet="Maxixi Toe Shoes"

    sets.precast.Step = {}
		
    sets.Enmity = {}
		
    sets.precast.JA.Provoke = sets.Enmity

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {}
		
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
		
    sets.precast.Flourish1['Desperate Flourish'] = {}

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Maculele Bangles +1", back="Toetapper Mantle"} --hands="Charis Bangles +2"

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {} --body="Charis Casaque +2"
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb +1",
        head=augmented_gear.Lustratio.DEX.head,
        body=augmented_gear.Herculean.WSD.DEX.body,
        hands="Meghanada Gloves +2",
        legs="Horos Tights +3",
        feet=augmented_gear.Lustratio.DEX.feet,
        neck="Caro Necklace",
        left_ear="Moonshade Earring",
        right_ear="Ishvara Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Regal Ring",
        waist="Sailfi belt +1",
        back=augmented_gear.capes.dex_wsd,
    })
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS["Rudra's Storm"].SomeAcc, {})
	
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb +1",
        head=augmented_gear.Lustratio.DEX.head,
        body=augmented_gear.Herculean.WSD.DEX.body,
        hands="Meghanada Gloves +2",
        legs="Horos Tights +3",
        feet=augmented_gear.Lustratio.DEX.feet,
        neck="Caro Necklace",
        left_ear="Moonshade Earring",
        right_ear="Ishvara Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Regal Ring",
        waist="Sailfi belt +1",
        back=augmented_gear.capes.dex_wsd,
    })
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS["Shark Bite"], {})
    sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS["Shark Bite"].SomeAcc, {})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb +1",
        head=augmented_gear.Adhemar.Atk.head,
        body="Meghanada Cuirie +2",
        hands="Mummu Wrists +2",
        legs=augmented_gear.Lustratio.DEX.legs,
        feet="Mummu gamashes +2",
        neck="Fotia Gorget",
        left_ear="Sherida Earring",
        right_ear="Odr Earring",
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        waist="Fotia belt",
        back=augmented_gear.capes.da,
    })
    sets.precast.WS["Evisceration"].Acc = set_combine(sets.precast.WS["Evisceration"], {})
    sets.precast.WS["Evisceration"].FullAcc = set_combine(sets.precast.WS["Evisceration"].SomeAcc, {})
	
    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb +1",
        head=augmented_gear.Lustratio.DEX.head,
        body=augmented_gear.Adhemar.Atk.body,
        hands=augmented_gear.Adhemar.Atk.hands,
        legs="Samnuha Tights",
        feet=augmented_gear.Lustratio.DEX.feet,
        neck="Fotia Gorget",
        left_ear="Mache Earring +1",
        right_ear="Ishvara Earring",
        left_ring="Epona's Ring",
        right_ring="Regal Ring",
        waist="Fotia Belt",
        back=augmented_gear.capes.da,
    })
    sets.precast.WS["Pyrrhic Kleos"].Acc = set_combine(sets.precast.WS["Pyrrhic Kleos"], {})
    sets.precast.WS["Pyrrhic Kleos"].FullAcc = set_combine(sets.precast.WS["Pyrrhic Kleos"].SomeAcc, {})

    sets.precast.WS['Aeolian Edge'] = {
        hands="Meghanada Gloves +2",
        waist="Orpheus's Sash",
    }

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	
    sets.Skillchain = {} --hands="Charis Bangles +2"
    
    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {}
        
    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    sets.ExtraRegen = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head=augmented_gear.Adhemar.Atk.head,
        body="Malignance Tabard",
        hands=augmented_gear.Adhemar.Atk.hands,
        legs="Samnuha Tights",
        feet="Horos Toe Shoes +1",
        neck="Anu Torque",
        left_ear="Sherida Earring",
        right_ear="Brutal Earring",
        left_ring="Epona's Ring",
        right_ring="Gere Ring",
        waist="Windbuffet Belt +1",
        back=augmented_gear.capes.da,
    }
		    
	sets.engaged.Acc = set_combine(sets.engaged, {})
    sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {})

    sets.engaged.DTLite = set_combine(sets.engaged, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
    })
    sets.engaged.PDT = set_combine(sets.engaged.DTLite, {})
        
    sets.engaged.Acc.DTLite = set_combine(sets.engaged.DTLite, {})
    sets.engaged.FullAcc.DTLite = set_combine(sets.engaged.DTLite, {})
        
    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {})
    sets.engaged.FullAcc.PDT = set_combine(sets.engaged.PDT, {})
    

    -- Idle sets

    sets.idle = set_combine(sets.engaged, {
        ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        left_ring="Defending Ring",
    })
        
    sets.idle.Sphere = set_combine(sets.idle, {})
    
    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}
        
    sets.defense.MEVA = {}

    sets.Kiting = {feet="Skd. Jambeaux +1"} 

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {} --legs="Horos Tights"
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +1",ammo="Charis Feather"} --head="Charis Tiara +2"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 9)
    elseif player.sub_job == 'SAM' then
        set_macro_page(5, 9)
    else
        set_macro_page(1, 9)
    end

    windower.chat.input:schedule(1,'/lockstyleset 21')
end