function user_setup()

	state.OffenseMode:options('Normal','SomeAcc','Acc','HighAcc','FullAcc')
	state.HybridMode:options('Normal','DTLite','Tank')
	state.WeaponskillMode:options('Match','Normal','Acc','FullAcc')
	state.CastingMode:options('Normal','SIRD','Resistant')
	state.PhysicalDefenseMode:options('PDT', 'PDT_HP')
	state.MagicalDefenseMode:options('MDT','MDT_HP','BDT','BDT_HP')
	state.ResistDefenseMode:options('MEVA','MEVA_HP','Death','Charm','DTCharm')
	state.IdleMode:options('Normal','Tank','KiteTank','Sphere')
	state.Weapons:options('Aettir','Lionheart')
	state.BuffMode = M{['description']='Buff Mode', 'Tank', 'Hybrid', 'DD'}
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	gear.enmity_jse_back = {name="Ogma's cape",augments={'INT+20','Eva.+20 /Mag. Eva.+20','Enmity+10',}}
	gear.stp_jse_back = {name="Ogma's cape",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.da_jse_back = {name="Ogma's cape",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind ^\\\\ input /ma "Protect IV" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Crusade" <me>')
	send_command('bind ^backspace input /ja "Lunge" <t>')
	send_command('bind @backspace input /ja "Gambit" <t>')
	send_command('bind !backspace input /ja "Rayke" <t>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Lionheart;gs c update')
	
	select_default_macro_book()
end

function init_gear_sets()

    include('augmented_gear.lua')
    augmented_gear.capes={
    	STP_PDT={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
    	Tank={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}

    sets.Enmity = {
	    head="Rabid Visor",
	    neck="Invidia Torque",
	    body="Dux Scale Mail",
	    waist="Kasiri Belt",
	    legs="Erilaz Leg Guards",
	    feet="Rager Ledel. +1",
	    left_ear="Friomisi Earring",
	    right_ear="Brutal Earring",
	    left_ring="Petrov Ring",
	    right_ring="Begrudging Ring",
	    back=augmented_gear.capes.Tank
	}
		 
    sets.Enmity.SIRD = {ammo="Staunch Tathlum",
		head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Genmei Earring",ear2="Trux Earring",
		body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Moonbeam Ring",
		back=gear.enmity_jse_back,waist="Rumination Sash",legs="Carmine Cuisses +1",feet="Erilaz Greaves +1"}

    sets.Enmity.DT = {ammo="Staunch Tathlum",
        head="Fu. Bandeau +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Runeist's Coat +2",hands=gear.herculean_dt_hands,ring1="Moonbeam Ring",ring2="Moonbeam Ring",
        back="Moonlight Cape",waist="Flume Belt",legs="Eri. Leg Guards +1",feet="Erilaz Greaves +1"}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{body="Runeist's Coat +2",legs="Futhark Trousers"})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{feet="Runeist's Boots +1"})
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{head="Futhark Bandeau"})
    sets.precast.JA['Liement'] = set_combine(sets.Enmity,{body="Futhark Coat"})
    sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{hands="Runeist's Mitons +1"})
    sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{feet="Futhark Boots"})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{body="Futhark Coat"})
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity,{hands="Futhark Mitons"})
    sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{})
    sets.precast.JA['One For All'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    sets.precast.JA['Vallation'].DT = set_combine(sets.Enmity.DT,{body="Runeist's Coat +2", legs="Futhark Trousers"})
    sets.precast.JA['Valiance'].DT = sets.precast.JA['Vallation'].DT
    sets.precast.JA['Pflug'].DT = set_combine(sets.Enmity.DT,{feet="Runeist's Boots +1"})
    sets.precast.JA['Battuta'].DT = set_combine(sets.Enmity.DT,{head="Futhark Bandeau"})
    sets.precast.JA['Liement'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat"})
    sets.precast.JA['Gambit'].DT = set_combine(sets.Enmity.DT,{hands="Runeist's Mitons +1"})
    sets.precast.JA['Rayke'].DT = set_combine(sets.Enmity.DT,{feet="Futhark Boots"})
    sets.precast.JA['Elemental Sforzo'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat"})
    sets.precast.JA['Swordplay'].DT = set_combine(sets.Enmity.DT,{hands="Futhark Mitons"})
    sets.precast.JA['Embolden'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['One For All'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Last Resort'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Animated Flourish'].DT = set_combine(sets.Enmity.DT, {})

    sets.precast.JA['Lunge'] = {
		ammo="Seething Bomblet",
		head=augmented_gear.Herculean.WSD.MAB.head,
        neck="Baetyl pendant",
        body="Samnuha coat",
        ear1="Friomisi earring",
        ear2="Hecate's earring",
        hands="Carmine Finger Gauntlets +1",
        ring1="Acumen ring",
        ring2="Shiva Ring +1",
        waist="Eschan Stone",
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Herculean.WSD.MAB.feet,
    }

	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	sets.element.Earth = {neck="Quanpur Necklace"}

	-- Pulse sets, different stats for different rune modes, stat aligned.
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +1",neck="Incanter's Torque",ring1="Stikini Ring",ring2="Stikini Ring",legs="Rune. Trousers +3"}
    sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
        head="Carmine Mask +1",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonlight Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
    sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	-- Fast cast sets for spells
    sets.precast.FC = {
	    ammo="Impatiens",
	    head="Rune. Bandeau +2",
	    body="Samnuha Coat",
	    hands="Leyline Gloves",
	    legs="Aya. Cosciales +2",
	    neck="Baetyl Pendant",
	    waist="Ioskeha Belt",
	    left_ring="Kishar Ring",
	    right_ring="Weather. Ring",
	}
			
	sets.precast.FC.DT = {}
			
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers"})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck='Magoraga beads', back="Mujin Mantle"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {
	    ammo="Knobkierrie",
    	head=augmented_gear.Herculean.WSD.STR.head,
	    neck="Fotia Gorget",
	    left_ear="Cessance Earring",
	    right_ear="Brutal Earring",
	    body="Ayanmo Corazza +2",
	    hands="Meg. Gloves +2",
	    left_ring="Ifrit Ring +1",
	    right_ring="Ayanmo Ring",
	    waist="Fotia Belt",
        legs=augmented_gear.Herculean.WSD.STR.legs,
    	feet=augmented_gear.Herculean.WSD.STR.feet,
    	back="Atheling Mantle",
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS,{})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS,{})

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,{})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'],{})
	sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS['Resolution'].Acc,{})

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
    	left_ear="Sherida earring",
    	right_ear="Moonshade Earring",
    	left_ring="Ilabrat ring",
    	right_ring="Apate Ring",
    	back="Kayapa cape",
    })
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'],{head="Lilitu Headpiece",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet})
	sets.precast.WS['Dimidiation'].FullAcc = set_combine(sets.precast.WS['Dimidiation'].Acc,{})
	
    sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS,{})
    sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc,{})
	sets.precast.WS['Ground Strike'].FullAcc = set_combine(sets.precast.WS.FullAcc,{})
		
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast['Lunge'], {})

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
			
	sets.midcast.FastRecast.DT = {}

    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,{head="Erilaz Galea +1",neck="Incanter's Torque",ear1="Andoaa Earring",hands="Runeist's Mitons +3",back="Merciful Cape",waist="Olympus Sash",legs="Futhark Trousers +1"})
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],{head="Futhark Bandeau +1",legs="Carmine Cuisses +1",feet=gear.herculean_nuke_feet})
    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'],{head="Rune. Bandeau +2"}) 
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'],{head="Erilaz Galea +1"}) 
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear2="Earthcry Earring",waist="Siegel Sash"})
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Foil = set_combine(sets.Enmity, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {}
		
	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})
		
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}

    sets.idle = {
	    ammo="Falcon Eye",
	    head="Meghanada Visor +2",
	    body="Runeist Coat +1",
	    hands="Meg. Gloves +2",
	    legs="Meg. chausses +1",
	    feet="Aya. Gambieras +2",
	    neck="Sanctity Necklace",
	    waist="Flume Belt",
	    left_ear="Ethereal Earring",
	    right_ear="Brutal Earring",
	    left_ring="Defending Ring",
	    right_ring="Paguroidea Ring",
	    back="Moonbeam Cape",}
		
    sets.idle.Sphere = set_combine(sets.idle,{body="Mekosu. Harness"})
			
	sets.idle.Tank = {
	    head="Aya. Zucchetto +2",
	    body="Ayanmo Corazza +2",
	    legs="Erilaz Leg Guards",
	    feet="Erilaz Greaves",
	    neck="Loricate Torque",
	    waist="Flume Belt",
	    ring1="Defending ring",
	    ring2="Ayanmo Ring",
	    ear1="Ethereal Earring",
	    ear2="Cassie Earring",
    	back=augmented_gear.capes.Tank,}
		
	sets.idle.KiteTank = {
	    head="Aya. Zucchetto +2",
	    body="Ayanmo Corazza +2",
	    legs="Carmine Cuisses +1",
	    feet="Erilaz Greaves",
	    neck="Loricate Torque",
	    waist="Flume Belt",
	    ring1="Defending ring",
	    ring2="Ayanmo Ring",
	    ear1="Ethereal Earring",
	    ear2="Cassie Earring",
    	back=augmented_gear.capes.Tank,}

	sets.idle.Weak = set_combine(sets.idle.Tank)

	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {ear2="Ethereal Earring",waist="Flume Belt"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", waist = "Chaac belt",hands=augmented_gear.Herculean.TH.hands})
	
	-- Weapons sets
	sets.weapons.Aettir = {main="Aettir"}
	sets.weapons.Lionheart = {main="Lionheart",sub="Utu Grip"}
	
	-- Defense Sets
	
	sets.defense.PDT = {
	    head="Aya. Zucchetto +2",
	    body="Ayanmo Corazza +2",
	    legs="Erilaz Leg Guards",
	    feet="Erilaz Greaves",
	    neck="Loricate Torque",
	    waist="Flume Belt",
	    ring1="Defending ring",
	    ring2="Ayanmo Ring",
	    ear1="Ethereal Earring",
	    ear2="Cassie Earring",
	    back="Moonbeam cape",}
	sets.defense.PDT_HP = {}
		
	sets.defense.MDT = {}
	sets.defense.MDT_HP = {}
	
	sets.defense.BDT = {}
	sets.defense.BDT_HP = {}
	
	sets.defense.MEVA = {
	    head="Adhemar Bonnet +1",
	    body="Runeist Coat +1",
	    hands="Leyline Gloves",
	    legs="Rune. Trousers +1",
	    feet="Erilaz Greaves",}
	sets.defense.MEVA_HP = {}
		
	sets.defense.Death = {}

	sets.defense.DTCharm = {}
		
	sets.defense.Charm = {}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring"}
	sets.AccMaxTP = {ear1="Telos Earring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {
    	sub="Utu Grip",
	    ammo="Ginsen",
        head=augmented_gear.Adhemar.Atk.head,
	    neck="Anu Torque",
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
        body=augmented_gear.Adhemar.Atk.body,
    	hands=augmented_gear.Adhemar.Atk.hands,
	    left_ring="Ilabrat Ring",
	    right_ring="Epona's Ring",
	    legs="Samnuha Tights",
    	feet=augmented_gear.Herculean.TA.feet,
	    waist="Windbuffet Belt +1",
	    back=augmented_gear.capes.STP_PDT,
	}
	sets.engaged.Acc = set_combine(sets.engaged, {
	    head="Aya. Zucchetto +2",
		ear2="Telos earring",
	})
	sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
		ammo="Falcon eye",
		neck="Lissome Necklace",
		ear1="Dignitary's earring",
	    body="Ayanmo Corazza +2",
    	ring2="Ayanmo ring",
    	waist="Eschan stone",
    	legs="Ayanmo cosciales +2",
	})
    sets.engaged.DTLite = set_combine(sets.engaged, {
    	head="Ayanmo Zucchetto +2",
    	neck="Loricate Torque",
    	body="Ayanmo Corazza +2",
    	ring2="Defending ring",
    	back="Moonbeam cape",
    	})
	sets.engaged.Acc.DTLite = set_combine(sets.engaged.Acc, {})
	sets.engaged.FullAcc.DTLite =set_combine(sets.engaged.FullAcc,  {})
	
    sets.engaged.Tank = set_combine(sets.engaged,{
	    head="Aya. Zucchetto +2",
	    body="Runeist's Coat +2",
	    hands="Rune. Mitons +1",
	    legs="Erilaz Leg Guards",
	    feet="Erilaz Greaves",
	    neck="Loricate Torque",
	    waist="Flume Belt",
	    ring1="Defending ring",
	    ring2="Ayanmo Ring",
	    ear1="Ethereal Earring",
	    ear2="Cassie Earring",
    	back="Moonbeam Cape",
	})
	sets.engaged.Acc.Tank = set_combine(sets.engaged.Tank,{
		ammo="Falcon Eye",
		ear2="Telos earring",
    	hands=augmented_gear.Adhemar.Acc.hands,
    	legs="Ayanmo cosciales +2",
    	feet="Ayanmo Gambieras +2"
	})
	sets.engaged.FullAcc.Tank = set_combine(sets.engaged.Acc.Tank, {
		ear1="Dignitary's earring",
	})
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Battuta = {}
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 11)
end

function user_job_tick()
    if state.AutoBuffMode.value then
			--Tank
		if state.BuffMode.value == 'Tank' then
			local spell_recasts = windower.ffxi.get_spell_recasts()

			if not buffactive.Phalanx and spell_recasts[106] == 0 then
				windower.chat.input('/ma "Phalanx" <me>')
				tickdelay = 200
				return true
			elseif not buffactive['Defense Boost'] and not buffactive['Defense Down'] and spell_recasts [547] == 0 and player.sub_job == 'BLU' then
				windower.chat.input('/ma "Cocoon" <me>')
				tickdelay = 200
				return true
			elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
				windower.chat.input('/ma "Crusade" <me>')
				tickdelay = 200
				return true
			elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
				windower.chat.input('/ma "Aquaveil" <me>')
				tickdelay = 200
				return true
			elseif not buffactive.Refresh and spell_recasts [109] == 0 then
				windower.chat.input('/ma "Refresh" <me>')
				tickdelay = 200
				return true
			end

		elseif state.BuffMode.value == 'Hybrid' then
				local spell_recasts = windower.ffxi.get_spell_recasts()

			if not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
					windower.chat.input('/ma "Crusade" <me>')
					tickdelay = 200
					  return true
			elseif not buffactive.Phalanx and spell_recasts[106] == 0 then
				   windower.chat.input('/ma "Phalanx" <me>')
				   tickdelay = 200
				   return true
			--elseif not buffactive['Multi Strikes'] and spell_recasts[493] == 0 then
			--				windower.chat.input('/ma "Temper" <me>')
			--				tickdelay = 200
			--				return true
			elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
							windower.chat.input('/ma "Aquaveil" <me>')
							tickdelay = 200
							return true
			end

		elseif state.BuffMode.value == 'DD' then
	        local spell_recasts = windower.ffxi.get_spell_recasts()
			--if not buffactive['Multi Strikes'] and spell_recasts[493] == 0 then
			--		windower.chat.input('/ma "Temper" <me>')
			--		tickdelay = 200
			--		return true
			--end
		end
	end

    return false
end

function user_job_self_command(commandArgs, eventArgs)
	if commandArgs[1] == 'Buff' then

		local spell_recasts = windower.ffxi.get_spell_recasts()
		local ability_recasts = windower.ffxi.get_ability_recasts()
		if player.sub_job == 'BLU' then


            if not buffactive.Phalanx and spell_recasts[106] == 0 then
				send_command('input /ma "Phalanx" <me>')
			elseif not buffactive['Defense Boost'] and not buffactive['Defense Down'] and spell_recasts [547] == 0 then
				send_command('input /ma "Cocoon" <me>')
			elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
				send_command('input /ma "Crusade" <me>')
			elseif not buffactive.Haste and spell_recasts [530] == 0 then
				send_command('input /ma "Refueling" <me>')
			elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
				send_command('input /ma "Aquaveil" <me>')
			elseif not buffactive.Regen and spell_recasts [477] == 0 then
				send_command('input /ma "Regen IV" <me>')
			elseif not buffactive.Refresh and spell_recasts [109] == 0 then
				send_command('input /ma "Refresh" <me>')
			elseif not buffactive['Shock Spikes'] and spell_recasts [251] == 0 then
				send_command('input /ma "Shock Spikes" <me>')
			else add_to_chat(123,'All buffs are applied.')
			end

		elseif player.sub_job == 'DRK' then

            if not buffactive.Phalanx and spell_recasts[106] == 0 then
				send_command('input /ma "Phalanx" <me>')
			elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
				send_command('input /ma "Aquaveil" <me>')
			elseif not buffactive.Regen and spell_recasts [477] == 0 then
				send_command('input /ma "Regen IV" <me>')
			elseif not buffactive.Refresh and spell_recasts [109] == 0 then
				send_command('input /ma "Refresh" <me>')
			elseif not buffactive['Shock Spikes'] and spell_recasts [251] == 0 then
				send_command('input /ma "Shock Spikes" <me>')
			else add_to_chat(123,'All buffs are applied.')
			end

		else

            if not buffactive.Phalanx and spell_recasts[106] == 0 then
				send_command('input /ma "Phalanx" <me>')
			elseif not buffactive['Enmity Boost'] and not buffactive['Enmity Down'] and spell_recasts [476] == 0 then
				send_command('input /ma "Crusade" <me>')
			elseif not buffactive.Aquaveil and spell_recasts [55] == 0 then
				send_command('input /ma "Aquaveil" <me>')
			elseif not buffactive.Regen and spell_recasts [477] == 0 then
				send_command('input /ma "Regen IV" <me>')
			elseif not buffactive.Refresh and spell_recasts [109] == 0 then
				send_command('input /ma "Refresh" <me>')
			elseif not buffactive['Shock Spikes'] and spell_recasts [251] == 0 then
				send_command('input /ma "Shock Spikes" <me>')
			else add_to_chat(123,'All buffs are applied.')
			end
		end

	elseif commandArgs[1] == 'Provoke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local ability_recasts = windower.ffxi.get_ability_recasts()
		if player.target.type ~= "MONSTER" then
			add_to_chat(123,'Abort: You are not targeting a monster.')
			return
		elseif spell_recasts[112] == 0 then
			send_command('input /ma "Flash" <t>')
		elseif spell_recasts[575] == 0 and player.sub_job == "BLU" then
			send_command('input /ma "Jettatura" <t>')
		elseif spell_recasts[592] == 0 and player.sub_job == "BLU" then
			send_command('input /ma "Blank Gaze" <t>')
		elseif spell_recasts[252] == 0 and player.sub_job == "DRK" then
			send_command('input /ma "Stun" <t>')
		elseif ability_recasts[5] == 0 and player.sub_job == "WAR" then
			send_command('input /ja "Provoke" <t>')
		elseif not check_auto_tank_ws() then
			if not state.AutoTankMode.value then add_to_chat(123,'All Enmity spells on cooldown.') end
		end

	elseif commandArgs[1] == 'AoEnmity' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if spell_recasts[225] == 0 and player.sub_job == "DRK" then
			send_command('input /ma "Poisonga" <t>')
		elseif player.sub_job == "BLU" then
			if spell_recasts[584] == 0 then
				send_command('input /ma "Sheep Song" <t>')
			elseif  spell_recasts[605] == 0 then
				send_command('input /ma "Geist Wall" <t>')
			elseif  spell_recasts[598] == 0 then
				send_command('input /ma "Soporific" <t>')
			elseif  spell_recasts[537] == 0 then
				send_command('input /ma "Stinking Gas" <t>')
			else
				add_to_chat(123,'All Enmity spells on cooldown.')
			end
		else
			add_to_chat(123,'All Enmity spells on cooldown.')
		end

	elseif commandArgs[1] == 'Foil' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		if spell_recasts[840] == 0 then
			send_command('input /ma "Foil" <me>')
		elseif player.sub_job == "BLU" then
			if spell_recasts[584] == 0 then
				send_command('input /ma "Sheep Song" <t>')
			elseif  spell_recasts[605] == 0 then
				send_command('input /ma "Geist Wall" <t>')
			elseif  spell_recasts[598] == 0 then
				send_command('input /ma "Soporific" <t>')
			elseif  spell_recasts[537] == 0 then
				send_command('input /ma "Stinking Gas" <t>')
			end
		else
			add_to_chat(123,'All Enmity spells on cooldown.')
		end
    end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] == 0 and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = (framerate * 3)
					return true
				elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = (framerate * 3)
					return true
				else
					return false
				end
			end
		end
	end
	return false
end