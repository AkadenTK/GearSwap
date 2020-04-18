
    include('smartcure.lua')
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'TPEat')
	state.HybridMode:options('Normal','PDT')
    state.Weapons:options('None')
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_waist = "Refoccilation Stone"
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	
		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c scholar power')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace gs c scholar speed')
	send_command('bind @backspace gs c scholar aoe')
	send_command('bind ^= input /ja "Dark Arts" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')

	smart_cure_potencies = {['Cure'] = 150, ['Cure II'] = 350, ['Cure III'] = 650, ['Cure IV'] = 1000, ['Cure V'] = 1300, ['Cure VI'] = 1700, ['Curaga'] = 200, ['Curaga II'] = 400, ['Curaga III'] = 700, ['Curaga IV'] = 1300, ['Curaga V'] = 1750}
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    include('organizer-lib')
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +1"}
	sets.precast.JA['Enlightenment'] = {} --body="Peda. Gown +1"

    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo="Impatiens",
        head="Nahtirah hat", -- 10
        body="Merlinic Jubbah", -- 6
        legs="Psycloth lappas", -- 7
        feet="Amalric nails +1", -- 6
        right_ear="Malignance earring", --5
        left_ring="Kishar Ring", -- 4
        right_ring="Weatherspoon Ring", --5
        waist="Embla Sash", --5
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {left_ear="Barkaro. Earring", hands="Mallquis cuffs +1"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS['Myrkr'] = {
     	ammo="Pemphredo Tathlum",
        head="Nahtirah Hat",
        neck="Sanctity necklace",
        left_ear="Gifted Earring",
        right_ear="Halasz Earring",
        body="Amalric Doublet +1",
        hands="Telchine gloves",
        right_ring="Sangoma ring",
        back="Tempered cap +1",
        waist="Fucho-no-obi",
        legs="Amalric Slops +1",
        feet="Amalric Nails +1"
	}

    -- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {
        main="Akademos",                        -- 10
        neck="Mizu. Kubikazari",				-- 10
        hands="Amalric Gages +1",				-- II 5
        left_ring="Mujin Band",						-- II 6
        right_ring="Locus Ring",						-- 5
        legs=augmented_gear.Merlinic.Burst.legs,-- 4
        feet="Jhakri Pigaches +2"}				-- 8
	
	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Earth = {neck="Quanpur Necklace"}

    sets.midcast.FastRecast = {}
		
    sets.midcast.Cure = {
        main="Daybreak",
        sub="Genbu's Shield",
        hands='Telchine gloves',
        right_ear="Mendicant's earring",
        back="Solemnity cape",
        legs="Gyve trousers"}

    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {})
		
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {})

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

	sets.Self_Healing = {neck="Phalaina Locket",left_ring="Kunaji Ring",right_ring="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",left_ring="Kunaji Ring",right_ring="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
	
	sets.midcast.Cursna = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan",sub="Clemency Grip"})

	sets.midcast['Enhancing Magic'] = {
        head="Telchine Cap",
        body="Telchine Chasuble",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches",
        waist="Embla Sash",
    }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",sub="Genbu's Shield",head="Arbatel Bonnet +1", back="Lugh's cape"})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",right_ear="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1",waist="Emphatikos Rope"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Peda. Loafers +1"})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {left_ring="Stikini Ring +1",feet=gear.chironic_nuke_feet})

    sets.midcast['Dark Magic'] = {}

    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {
   		main="Akademos",
        sub="Niobid strap",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        neck="Saevus pendant +1",
        left_ear="Friomisi Earring",
        right_ear="Malignance Earring",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
        left_ring="Freke Ring",
        right_ring="Shiva Ring +1",
        back="",
        waist="Refoccilation Stone",
        legs="Amalric slops +1",
        feet="Amalric Nails +1",
	}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
		
    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})
		
    sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Stun = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {})

    sets.midcast.Drain = set_combine(sets.midcast['Elemental Magic'].Resistant, {
        head="Pixie Hairpin +1",
        left_ear="Halasz earring",
        left_ring="Evanescence ring",
        right_ring="Excelsis Ring",
        waist="Fucho-no-obi",
        feet="Merlinic Crackows"})
		
    sets.midcast.Drain.Resistant = set_combine(sets.midcast.Drain, {})

    sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})
	sets.midcast.Aspir.Resistant = set_combine(sets.midcast.Aspir, {})

	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif +1",right_ear="Barkaro. Earring",back=gear.nuke_jse_back,waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif +1",right_ear="Barkaro. Earring",back=gear.nuke_jse_back,waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif +1",left_ear="Barkaro. Earring",back=gear.nuke_jse_back,waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif +1",right_ear="Barkaro. Earring",back=gear.nuke_jse_back,waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {left_ring="Stikini Ring +1"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {left_ring="Stikini Ring +1"})
		
    -- Custom refinements for certain nuke tiers
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {main="Akademos",sub="Niobid Strap",ammo="Pemphredo Tathlum",left_ear="Regal Earring",right_ear="Barkaro. Earring",hands="Amalric Gages +1"})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {main=gear.grioavolr_nuke_staff,sub="Niobid Strap",ammo="Pemphredo Tathlum",left_ear="Regal Earring",right_ear="Barkaro. Earring",hands="Amalric Gages +1"})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {sub="Alber Strap",ammo="Pemphredo Tathlum",left_ear="Regal Earring",right_ear="Barkaro. Earring",hands="Amalric Gages +1"})

	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {})
	
	sets.midcast.Helix.Resistant = set_combine(sets.midcast.Helix, {})
		
	sets.midcast.Helix.Proc = set_combine(sets.midcast.Helix, {})

    sets.midcast.Kaustra = set_combine(sets.midcast.Helix, {})
		
    sets.midcast.Kaustra.Resistant = set_combine(sets.midcast.Kaustra, {})

	sets.midcast.Impact = {}


    -- Sets to return to when not performing an action.

     -- Resting sets
    sets.resting = {}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        main="Akademos",
        sub="Niobid strap",
	    ammo="Homiliary",
	    head="Befouled Crown",
	    body="Shamash Robe",
	    hands="Serpentes Cuffs",
	    legs="Assid. Pants +1",
	    feet="Serpentes Sabots",
	    neck="Loricate Torque +1",
	    waist="Fucho-no-Obi",
	    left_ear="Ethereal Earring",
	    right_ear="Eabani Earring",
	    left_ring="Defending Ring",
	    right_ring="Sheltered Ring",
	    back="Solemnity Cape",
	}

    sets.idle.PDT = {}
		
	sets.idle.Hippo = set_combine(sets.idle.PDT, {feet="Hippo. Socks +1"})

    sets.idle.Weak = {}
		
    sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}
		
    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {}
		
	sets.engaged.PDT = {}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet="Peda. Loafers +1"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +1"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}
	
	sets.HPDown = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

    sets.buff.Sublimation = {head="Academic's mortarboard +1", waist="Embla Sash", right_ear="Savant's earring"}
    sets.buff.FullSublimation = {head="Academic's mortarboard +1", right_ear="Savant's earring"}
    sets.buff.PDTSublimation = {}
	
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	set_macro_page(1, 20)

    windower.chat.input:schedule(1,'/lockstyleset 9')
end

function user_job_precast(spell, spellMap, eventArgs)
	if spell.english:lower() == "refresh" and spell.target.name == player.name then
		eventArgs.cancel = true
		windower.chat.input('/ja sublimation <me>')
		return
	end

	if state.smartcure and spell.english:lower() == 'cure' then
		state.smartcure = false
		eventArgs.cancel = true
		smartcure_target(spell.target.name)		
	end
	state.smartcure = false
end

function user_job_self_command(commandArgs, eventArgs)
    if commandArgs[1]:lower() == 'smartcure' then
		eventArgs.handled = true
		local targetType = commandArgs[2]:lower()

		if targetType == 'me' or (targetType == nil and (player.target.type == 'NONE' or player.target.type == 'SELF')) then
			-- smartcure self if: arg2 is 'me', or arg2 is nil and target = self or none
			smartcure_target(player.name)
		elseif (targetType == 't' or targetType == nil) and player.target.type ~= 'NONE' then
			-- smartcure target if: arg2 is 't' or nil and player.target isn't none
			smartcure_target(player.target.name)
		elseif targetType ~= nil then
			eventArgs.handled = true
			state.smartcure = true
			windower.chat.input('/ma "Cure" <'..targetType..'>')
		else 
			add_to_chat(123,'Abort SmartCure: target invalid.')		
		end
	end
end