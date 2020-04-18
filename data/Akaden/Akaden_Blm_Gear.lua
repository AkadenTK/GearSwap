
    function user_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
	state.OffenseMode:options('None', 'Normal')
	state.IdleMode:options('Normal', 'PDT', 'TPEat','DTHippo')

	gear.obi_cure_waist = "Witful Belt"
	gear.obi_low_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

		-- Additional local binds
	send_command('bind ^f8 gs c cycle ElementalMode')
	send_command('bind !\\\\ input /ja "Manawell" <me>')
	send_command('bind !f8 input /ma "Aspir III" <t>')
	send_command('bind @f8 gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f9 gs c cycle DeathMode')
	send_command('bind @^j input /ja "Parsimony" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace input /ja "Enmity Douse" <t>')
	send_command('bind @backspace input /ja "Alacrity" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind @= input /ja "Addendum: White" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
    
	select_default_macro_book()
end

function init_gear_sets()

    include('organizer-lib')

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	sets.Weapons = {main=gear.grioavolr_nuke_staff,sub="Niobid Strap"}
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {back="Taranus's Cape",feet="Wicce Sabots +1"}

    sets.precast.JA.Manafont = {} --body="Sorcerer's Coat +2"
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo="Impatiens",
        head="Nahtirah hat",
        body="Merlinic jubbah",
        legs="Psycloth lappas",
        feet="Amalric nails +1",
        left_ring="Kishar Ring",
        right_ring="Weatherspoon Ring",
        waist="Witful Belt",
    }
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        head="Goetia Petasos +2",
        ear="Barkarole earring",
        neck="Stoicheion Medal",
        hands="Mallquis cuffs +1"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = set_combine(sets.precast.FC.Cure, {})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

	--sets.precast.FC.Death = {main=gear.grioavolr_nuke_staff,sub="Niobid Strap",ammo="Impatiens",
    --    head="Nahtirah Hat",neck="Voltsurge Torque",left_ear="Enchanter Earring +1",right_ear="Loquacious Earring",
    --    body=gear.merlinic_nuke_body,hands="Helios Gloves",left_ring="Mephitas's Ring +1",right_ring="Lebeche Ring",
    --    back="Perimede Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    --sets.precast.WS = {ammo="Dosis Tathlum",
	--	head="Hagondes Hat +1",neck="Baetyl Pendant",left_ear="Friomisi Earring",right_ear="Crematio Earring",
	--	body="Jhakri Robe +2",hands="Jhakri Cuffs +2",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
	--	back="Taranus's Cape",waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    --sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
	--	head="Hagondes Hat +1",neck="Baetyl Pendant",left_ear="Friomisi Earring",right_ear="Crematio Earring",
	--	body="Zendik Robe",hands="Hagondes Cuffs +1",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
	--	back="Taranus's Cape",waist="Fotia Belt",legs="Hagondes Pants +1",feet=gear.merlinic_nuke_feet}

    sets.precast.WS['Myrkr'] =  { -- LOOOTS of MP+
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        neck="Sanctity necklace",
        left_ear="Andoaa Earring",
        right_ear="Halasz Earring",
        body="Ea Houppelande",
        hands="Telchine gloves",
        right_ring="Sangoma ring",
        back="Tempered cape +1",
        waist="Fucho-no-obi",
        legs="Amalric Slops +1",
        feet="Amalric Nails +1"
    }
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
        neck="Nodens gorget",
        body="Vanya robe",
        hands='Telchine gloves',
        right_ear="Mendicant's earring",
        back="Solemnity cape",
        legs="Gyve trousers"
    }
		
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {})
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {})

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
	
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Enhancing Magic'] = {head="Telchine Cap",body="Telchine Chasuble",hands="Telchine Gloves",legs="Telchine Braconi",feet="Telchine Pigaches"}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",waist="Siegel Sash"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.midcast['Enfeebling Magic'] = {
        main="Lathi",
        sub="Enkei Strap",
        ammo="Pemphredo Tathlum",
        head= "Cath Palug Crown",
        neck="Sanctity Necklace",
        left_ear="Dignitary's earring",
        right_ear="Malignance earring",
        body="Amalric Doublet +1",
        hands="Jhakri Cuffs +2",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring +1",
        back="Taranus's cape",
        waist="Eschan Stone",
        legs=augmented_gear.Merlinic.Accuracy.legs,
        feet="Jhakri Pigaches +2",
    }
		
    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast['Dark Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        left_ear="Halasz earring",
        left_ring="Evanescence ring",
        right_ring="Excelsis Ring",
        waist="Fucho-no-obi",
        feet="Merlinic Crackows"
    })
    
    sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})
	
	sets.midcast.Aspir.Death = set_combine(sets.midcast.Drain, {})

    sets.midcast.Stun = set_combine(sets.midcast['Enfeebling Magic'], {})
		
    sets.midcast.Stun.Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast.BardSong = set_combine(sets.midcast['Enfeebling Magic'], {})

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
        main="Lathi",
        sub="Niobid strap",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        neck="Saevus pendant +1",
        left_ear="Barkarole earring",
        right_ear="Malignance Earring",
        body="Amalric doublet +1",
        hands="Amalric gages +1",
        left_ring="Freke Ring",
        right_ring="Shiva Ring +1",
        back="Taranus's cape",
        waist="Refoccilation Stone",
        legs="Amalric Slops +1",
        feet="Amalric Nails +1",
    }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        sub="Enki Strap",
        neck="Baetyl pendant",
        right_ear="Dignitary's Earring",
        left_ring="Sangoma ring",
        right_ring="Stikini Ring +1",
    })
		
    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
	
	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast.Helix.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
		
		-- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Earth Staff",sub=empty,range=empty,ammo=empty,head=empty,neck=empty,left_ear=empty,right_ear=empty,body="Spaekona's Coat +2",hand=empty,left_ring=empty,right_ring=empty,back=empty,waist=empty,legs=empty,feet=empty,}

		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, {head=empty, body="Twilight Cloak"})
	
	sets.midcast.Death = set_combine(sets.midcast['Elemental Magic'], {
            head="Pixie Hairpin +1",
            left_ring="Sangoma ring",
            right_ring="Mephitas's ring +1",
            body="Amalric doublet +1",
            legs="Amalric Slops +1",
            right_ear="Dignitary's Earring"
    })
	
    -- Sets to return to when not performing an action.
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Staunch Tathlum +1",
        head="Befouled Crown",
        body="Shamash Robe",
        neck="Loricate Torque +1",
        hands="Serpentes cuffs",
        left_ear="Ethereal Earring",
        right_ear="Halasz earring",
        left_ring="Defending Ring",
        right_ring="Sheltered Ring",
        back="Solemnity cape",
        waist="Fucho-no-obi",
        legs="Assiduity Pants +1",
        feet="Serpentes Sabots"})

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = set_combine(sets.idle, {})
		
    sets.idle.TPEat = set_combine(sets.idle, {})
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {})

	sets.idle.Death = set_combine(sets.midcast.Death, {})

    sets.idle.Weak = set_combine(sets.idle, {})

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}
    
    -- Resting sets
    sets.resting = {
            main="Chatoyant Staff",
            ammo="Clarus Stone"
        }

	sets.Kiting = {feet="Herald's Gaiters"}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", waist = "Chaac belt"})
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {feet=gear.merlinic_refresh_feet}
	sets.NightIdle = {}
	
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	
	sets.HPDown = {}
		
	sets.HPCure = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Mana Wall'] = {back="Taranus's Cape",feet="Wicce Sabots +1"}
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Spaekona's Coat +2"}
	-- Gear for Magic Burst mode.
    sets.MagicBurst = set_combine(sets.midcast['Elemental Magic'], {
        head="Ea Hat", 
        body="Ea Houppelande",
        neck="Mizu. Kubikazari",
        hands="Amalric Gages +1",
        left_ring="Mujin Band",
        legs=augmented_gear.Merlinic.Burst.legs,
        feet="Jhakri Pigaches +2"})
	sets.RecoverBurst = set_combine(sets.MagicBurst, {
        body="Spaekona's Coat +2",})
	
	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Dark = {head="Pixie Hairpin +1",right_ring="Archon Ring"}
	sets.element.Earth = {neck="Quanpur Necklace"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",left_ring="Kunaji Ring",right_ring="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",left_ring="Kunaji Ring",right_ring="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 3)
    windower.chat.input:schedule(1,'/lockstyleset 2')
end

function user_job_precast(spell, spellMap, eventArgs)
	if spell.english == "Impact" then
		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[35] == 0 and not buffactive['amnesia'] then
			cancel_spell()
			send_command('@input /ja "Manawell" <me>;wait 1;input /ma Impact '..spell.target.raw..'')
			return
		end
	end
end