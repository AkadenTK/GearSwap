
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

    include('augmented_gear.lua')
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
        body="Anhur Robe",
        ring1="Kishar Ring",
        ring2="Weatherspoon Ring",
        waist="Witful Belt",
        legs="Psycloth lappas",
        feet="Amalric nails"
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
    --    head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchanter Earring +1",ear2="Loquacious Earring",
    --    body=gear.merlinic_nuke_body,hands="Helios Gloves",ring1="Mephitas's Ring +1",ring2="Lebeche Ring",
    --    back="Perimede Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    --sets.precast.WS = {ammo="Dosis Tathlum",
	--	head="Hagondes Hat +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
	--	body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
	--	back="Taranus's Cape",waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    --sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
	--	head="Hagondes Hat +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
	--	body="Zendik Robe",hands="Hagondes Cuffs +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
	--	back="Taranus's Cape",waist="Fotia Belt",legs="Hagondes Pants +1",feet=gear.merlinic_nuke_feet}

    sets.precast.WS['Myrkr'] =  { -- LOOOTS of MP+
        ammo="Pemphredo Tathlum",
        head="Nahtirah Hat",
        neck="Sanctity necklace",
        ear1="Gifted Earring",
        ear2="Halasz Earring",
        body="Amalric Doublet",
        hands="Telchine gloves",
        ring2="Sangoma ring",
        back="Tempered cape +1",
        waist="Fucho-no-obi",
        legs="Amalric Slops",
        feet="Amalric Nails"
    }
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
        neck="Nodens gorget",
        body="Vanya robe",
        hands='Telchine gloves',
        ear2="Mendicant's earring",
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
        head= augmented_gear.Merlinic.Accuracy.head,
        neck="Sanctity Necklace",
        ear1="Barkarole earring",
        ear2="Dignitary's earring",
        body=augmented_gear.Merlinic.Accuracy.body,
        hands="Amalric gages",
        ring1="Sangoma Ring",
        ring2="Stikini ring",
        back="Taranus's cape",
        waist="Refoccilation Stone",
        legs=augmented_gear.Merlinic.Accuracy.legs,
        feet=augmented_gear.Merlinic.Accuracy.feet
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
        ear1="Halasz earring",
        ring1="Evanescence ring",
        ring2="Excelsis Ring",
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
        head=augmented_gear.Merlinic.Damage.head,
        neck="Saevus pendant +1",
        ear1="Barkarole earring",
        ear2="Friomisi Earring",
        body=augmented_gear.Merlinic.Damage.body,
        hands="Jhakri Cuffs +2",
        ring1="Acumen Ring",
        ring2="Strendu Ring",
        back="Taranus's cape",
        waist="Refoccilation Stone",
        legs=augmented_gear.Merlinic.Damage.legs,
        feet="Jhakri Pigaches +2",
    }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        sub="Enki Strap",
        head=augmented_gear.Merlinic.Accuracy.head,
        neck="Baetyl pendant",
        ear2="Dignitary's Earring",
        body=augmented_gear.Merlinic.Accuracy.body,
        ring1="Sangoma ring",
        ring2="Stikini ring",
        legs=augmented_gear.Merlinic.Accuracy.legs,
    })
		
    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
	
	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast.Helix.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
		
		-- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Earth Staff",sub=empty,ranged=empty,ammo=empty,head=empty,neck=empty,ear1=empty,ear2=empty,body="Spaekona's Coat +2",hand=empty,ring1=empty,ring2=empty,back=empty,waist=empty,legs=empty,feet=empty,}

		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, {head=empty, body="Twilight Cloak"})
	
	sets.midcast.Death = set_combine(sets.midcast['Elemental Magic'], {
            head="Pixie Hairpin +1",
            ring1="Sangoma ring",
            ring2="Mephitas's ring +1",
            body="Amalric doublet",
            legs="Amalric slops",
            ear2="Dignitary's Earring"
    })
	
    -- Sets to return to when not performing an action.
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Staunch Tathlum",
        head="Befouled Crown",
        body="Shamash Robe",
        neck="Loricate Torque +1",
        hands="Serpentes cuffs",
        ear1="Ethereal Earring",
        ear2="Halasz earring",
        ring1="Defending Ring",
        ring2="Paguroidea Ring",
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
    sets.MagicBurst = {
        head=augmented_gear.Merlinic.Burst.head, 
        neck="Mizu. Kubikazari",
        hands="Amalric Gages",
        ring1="Mujin Band",
        legs=augmented_gear.Merlinic.Burst.legs,
        feet="Jhakri Pigaches +2"}
	sets.RecoverBurst = {
        head=augmented_gear.Merlinic.Burst.head,
        neck="Mizu. Kubikazari",
        body="Spaekona's Coat +2",
        hands="Amalric Gages",
        ring1="Mujin Band",
        legs=augmented_gear.Merlinic.Burst.legs, 
        feet=augmented_gear.Merlinic.Burst.feet}
	
	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Earth = {neck="Quanpur Necklace"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
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