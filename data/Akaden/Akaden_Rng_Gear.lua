-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Match','Normal', 'Acc')
	state.IdleMode:options('Normal', 'PDT')
    state.RHAutoWS = M{'','Last Stand', 'Trueflight','Wildfire'}
	
    ammostock = {}
    ammostock['Chrono Bullet'] = 99
    ammostock['Devastating Bullet'] = 30

    gear.ammo = {}
    gear.ammo.RA = "Chrono Bullet"
    gear.ammo.WS = "Chrono Bullet"
    gear.ammo.MA = "Devastating Bullet" --For MAB WS, do not put single-use bullets here.
	
	gear.tp_ranger_jse_back = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.wsd_ranger_jse_back = {name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
	
	    -- Additional local binds
    send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle RngHelper')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind ^q gs c weapons SingleWeapon;gs c update')
	
    send_command('gs rh set')
	
	select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	sets.Capacity={back="Aptitude Mantle"}
	
	
	-- Precast sets to enhance JAs
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {waist = "Chaac belt",hands=augmented_gear.Herculean.TH.hands,feet=augmented_gear.Herculean.TH.feet})
	
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands="Sylvan Glovettes +1"})
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
	sets.precast.JA['Double Shot'] = {back=gear.tp_ranger_jse_back}


	-- Fast cast sets for spells

    sets.precast.FC = {
    	head="Carmine mask",
    	body="Samnuha coat",
    	hands="Leyline gloves",
    	legs="Gyve Trouses",

	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga bead necklace"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
    	ammo=gear.ammo.RA,
		head="Taeon chapeau", -- s7
		body="Arcadian Jerkin +1", -- r12
	    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- s8 r11
	    back={ name="Belenus's cape", augments={'"Snapshot"+10'}},
	    legs=augmented_gear.Adhemar.D.legs, --s9 r10
	    feet="Meg. Jam. +2", --s10
	    waist="Impulse Belt",} -- s3
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
		head="Orion Beret +3",
		feet="Pursuer's gaiters"})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	    head="Orion Beret +3",
	    neck="Fotia Gorget",
	    left_ear="Moonshade earring",
        hands="Meghanada gloves +2",
	    waist="Fotia Belt",
	    right_ring="Illabrat ring",
	}

    sets.precast.WS.Acc = set_combine(sets.precast.WS,{})

    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {
	    right_ear="Brutal Earring",
        body=augmented_gear.Herculean.WSD.STR.body,
	    left_ring="Ifrit Ring +1",
	    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
        legs=augmented_gear.Herculean.WSD.STR.legs,
    	feet=augmented_gear.Herculean.WSD.STR.feet,
	})

    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS['Ruinator'], {

	})
		
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {   
	    ammo=gear.ammo.MA,
	    head=augmented_gear.Herculean.WSD.MAB.head,
	    body="Samnuha coat",
	    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
	    legs=augmented_gear.Herculean.WSD.MAB.legs,
	    feet=augmented_gear.Herculean.WSD.MAB.feet,
	    neck="Sanctity Necklace",
	    waist="Svelt. Gouriz +1",
	    left_ear="Friomisi Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
	    left_ring="Acumen Ring",
	    right_ring="Shiva Ring +1",
	    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
   })
		
    sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, {   
	    ammo=gear.ammo.MA,
	    head=augmented_gear.Herculean.WSD.MAB.head,
	    body="Samnuha coat",
	    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
	    legs=augmented_gear.Herculean.WSD.MAB.legs,
    	feet=augmented_gear.Herculean.WSD.MAB.feet,
	    neck="Sanctity Necklace",
	    waist="Svelt. Gouriz +1",
	    left_ear="Friomisi Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
	    left_ring="Acumen Ring",
	    right_ring="Illabrat Ring",
	    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
   })

    sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], {
        left_ear="Hermetic Earring",
        right_ear="Dignitary's Earring",
        body="Mummu Jacket +2",
        waist="Kwahu Kachina belt",
        })
		
    sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS, {   
	    ammo=gear.ammo.MA,
	    head=augmented_gear.Herculean.WSD.MAB.head,
	    body="Samnuha coat",
	    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
	    legs=augmented_gear.Herculean.WSD.MAB.legs,
	    feet=augmented_gear.Herculean.WSD.MAB.feet,
	    neck="Baetyl pendant",
	    waist="Svelt. Gouriz +1",
	    left_ear="Friomisi Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
	    left_ring="Acumen Ring",
	    right_ring="Weatherspoon Ring",
	    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
   })

    sets.precast.WS['Trueflight'].Acc = set_combine(sets.precast.WS['Trueflight'], {
        left_ear="Hermetic Earring",
        right_ear="Dignitary's Earring",
	    neck="Sanctity Necklace",
        body="Mummu Jacket +2",
        waist="Kwahu Kachina belt",
        })

    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
	    ammo=gear.ammo.WS,
	    head="Orion Beret +3",
   		body=augmented_gear.Herculean.WSD.AGI.body,
	    hands="Meg. Gloves +2",
	    legs=augmented_gear.Herculean.WSD.AGI.legs,
    	feet=augmented_gear.Herculean.WSD.AGI.feet,
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Suppanomimi",
	    right_ear="Ishvara Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Garuda Ring",
	    back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
    })

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
    	left_ear="Telos Earring",
    	body="Mummu jacket +2",
    	legs="Meghanada chausses +2",
    	feet="Meghanada jambeaux +2",
    	})
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
    sets.midcast.FastRecast = {}
		
	-- Ranged sets

    sets.midcast.RA = {
    	ammo=gear.ammo.RA,
        head="Arcadian beret +1",
        left_ear="Telos earring",
        right_ear="Cessance earring",
        neck="Marked Gorget",
        body="Mummu jacket +2",
        hands=augmented_gear.Adhemar.Rng.hands,
        left_ring="Hajduk ring",
        right_ring="Hajduk ring",
        back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
        waist="Yemaya belt",
        legs=augmented_gear.Adhemar.Rng.legs,
        feet=augmented_gear.Adhemar.D.feet,
    }
    
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        hands="Meghanada gloves +2",
        waist="Kwahu Kachina belt",
        legs="Meghanada chausses +2",
        feet="Meg. Jam. +2"})
		
	sets.buff['Double Shot'] = {
	}
	sets.buff['Double Shot'].Acc = set_combine(sets.buff['Double Shot'], {})
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
    sets.idle = set_combine(sets.midcast.RA, {})
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Weapons = {}
	sets.SingleWeapon = {}
	sets.MagicWeapons = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    -- Normal melee group
    sets.engaged = {
        head=augmented_gear.Adhemar.Atk.head,
        neck="Asperity Necklace",
        left_ear='Suppanomimi',
        right_ear="Brutal Earring",
        body=augmented_gear.Adhemar.Atk.body,
        hands=augmented_gear.Adhemar.Atk.hands,
        left_ring="Petrov ring",
        right_ring="Epona's ring",
        back="Atheling Mantle",
        waist="Windbuffet belt +1",
        legs="Samnuha tights",
        feet=augmented_gear.Herculean.TA.feet,
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        head=augmented_gear.Adhemar.Acc.head,
        neck="Subtlety Spectacles",
        left_ear="Telos earring",
        right_ear="Dignitary's earring",
        body="Mummu Jacket +2",
        hands=augmented_gear.Adhemar.Acc.hands,
        waist="kentarch belt +1",
        legs="Meghanada chausses +2",
        back="Kayapa cape",
    })

    sets.engaged.DW = set_combine(sets.engaged, {})
    
    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {})
	sets.buff.Camouflage = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 13)
end
