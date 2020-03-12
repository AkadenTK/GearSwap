function user_setup()

	-- Options: Override default values
    state.OffenseMode:options('None', 'Normal','DualWield')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'TPEat')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')

	gear.nuke_jse_back = {name="Nantosuelta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
	gear.idle_jse_back = {name="Nantosuelta's Cape",augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10'}}
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = gear.nuke_jse_back
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = gear.nuke_jse_back
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')
	
	indi_duration = 290
	
	select_default_macro_book()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
	sets.precast.JA['Life Cycle'] = {body="Geo. Tunic +1",back="Nantosuelta's cape"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",hands="Bagua Mitaines"}
	
	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}
	
	-- Fast cast sets for spells

	sets.precast.FC = {
        main="Solstice",
        head="Nahtirah hat",
        body="Anhur Robe",
        legs="Geomancy pants +1",
        waist="Channeler's stone",
        back="Lifestream cape",
        feet="Amalric nails"
	}

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna",ammo=empty})
	
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        ear2="Barkarole earring",
        hands="Bagua Mitaines"
    })

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Sors Shield"})
		
	sets.precast.FC.Curaga = set_combine(sets.precast.FC.Cure, {})
	
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = {}
	
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines +1"})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {}

	sets.midcast.Geomancy = {
        main="Solstice",
        head="Azimuth hood +1",
        neck="Incanter's Torque",
        body="Bagua Tunic +1",
        hands="Geomancy Mitaines +1",
        back="Lifestream cape"
    }


	--Extra Indi duration on any slot you can't get skill on here.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
        legs="Bagua pants +1",
        feet="Azimuth gaiters +1",
        back="Nantosuelta's Cape"})
		
    sets.midcast.Cure = {
        main="Tamaxchi",
        sub="Genbu's Shield",
        neck="Nodens gorget",
        body="Vanya robe",
        hands='Telchine gloves',
        back="Solemnity cape",
        legs="Gyve trousers"}
		
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {waist="Hachirin-no-Obi"})
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {waist="Hachirin-no-Obi"})

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",ring1="Haoma's Ring",ring2="Haoma's Ring"})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan",sub="Clemency Grip"})
	
    sets.midcast['Elemental Magic'] = {
        main="Nibiru Cudgel",
        sub="Culminus",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Phys. dmg. taken -2%','DEX+5','"Mag.Atk.Bns."+12',}},
        neck="Saevus Pendant +1",
        ear1="Barkarole earring",
        ear2="Friomisi Earring",
        body="Merlinic Jubbah",
        hands="Amalric gages",
        ring1="Acumen Ring",
        ring2="Strendu Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
        waist="Refoccilation Stone",
        legs="Merlinic Shalwar",
        feet="Merlinic crackows"}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        main="Solstice",
        neck="Sanctity Necklace",
        ear2="Dignitary's Earring",
        body="Merlinic Jubbah",
        ring1="Balrahn's Ring",
        ring2="Sangoma ring",
        feet="Merlinic crackows"
    })
		
    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
		
    sets.midcast['Dark Magic'] = {}
		
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        ring1="Evanescence ring",
        ring2="Excelsis Ring",
        waist="Fucho-no-obi",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
        feet="Merlinic Crackows"
    })
    
    sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})
		
	sets.midcast.Stun = {}
		
	sets.midcast.Stun.Resistant = {}

		
	sets.midcast.Impact = {}
		
	sets.midcast['Enfeebling Magic'] = {
        main="Solstice",
        sub="Culminus",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+26','Magic burst mdg.+4%','"Mag.Atk.Bns."+7',}},
        neck="Sanctity Necklace",
        ear1="Barkarole earring",
        ear2="Dignitary's Earring",
        body="Merlinic Jubbah",
        hands="Amalric gages",
        ring1="Balrahn's Ring",
        ring2="Sangoma ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
        waist="Refoccilation Stone",
        legs="Merlinic Shalwar",
        feet="Merlinic crackows"
    }
		
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",ear2="Barkaro. Earring",waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear2="Barkaro. Earring",waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",ear2="Barkaro. Earring",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",ear2="Barkaro. Earring",waist="Acuity Belt +1"})
	
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {range=empty,ring1="Stikini Ring"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {range=empty,ring1="Stikini Ring"})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Stikini Ring"})
		
	sets.midcast['Enhancing Magic'] = {main=gear.gada_enhancing_club,sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Perimede Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif",hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})

	-- Gear for specific elemental nukes.
	sets.element.Wind = {main="Marin Staff +1"}
	sets.element.Ice = {main="Ngqoqwanb"}
	sets.element.Earth = {neck="Quanpur Necklace"}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Idle sets

	sets.idle = set_combine(sets.midcast['Elemental Magic'], {
        main="Bolelabunga",
        sub="Genbu's shield",
        head="Befouled Crown",
        body="Shamash Robe",
        neck="Twilight torque",
        hands="Bagua mitaines",
        back="Solemnity cape",
        ear1="Ethereal earring",
        ring1="Warden's ring",
        ring2="Sheltered Ring",
        legs="Assiduity Pants +1",
        feet="Azimuth gaiters +1"
    })
		
	sets.idle.PDT = {
        hands="Geomancy mitaines +1",
        body="Merlinic Jubbah",
        legs="Gyve trousers",
        feet="Azimuth Gaiters +1"
    }
		
	sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})

	-- Resting sets
	sets.resting = set_combine(sets.idle, {main="Chatoyant Staff"})

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = set_combine(sets.idle, {
        head="Azimuth hood +1",
        main="Solstice",
        feet="Bagua sandals"
    })

	sets.idle.PDT.Pet = set_combine(sets.idle.PDT, {
        head="Azimuth hood +1",
        main="Solstice",
        feet="Bagua sandals"
    })

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {}) 
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	sets.idle.Weak = set_combine(sets.idle, {})

	-- Defense sets
	
	sets.defense.PDT = set_combine(sets.idle.PDT, {})

	sets.defense.MDT = set_combine(sets.idle.PDT, {})
		
    sets.defense.MEVA = set_combine(sets.idle.PDT, {})
		
	sets.defense.PetPDT = set_combine(sets.idle.PDT.Pet, {})
		
	sets.defense.NukeLock = set_combine(sets.midcast['Elemental Magic'], {})
	
	sets.defense.GeoLock = set_combine(sets.midcast.Geomancy.Indi, {})

	sets.Kiting = {feet="Herald's Gaiters"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	sets.HPDown = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {}
		
	sets.engaged.DualWield = {}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {head="Ea Hat",neck="Mizu. Kubikazari",body="Ea Houppelande",hands="Ea Cuffs",ring1="Mujin Band",legs="Ea Slops",feet="Jhakri Pigaches +2"}
	sets.RecoverBurst = {head="Ea Hat",neck="Mizu. Kubikazari",body="Seidr Cotehardie",hands="Ea Cuffs",ring1="Mujin Band",legs="Ea Slops",feet="Jhakri Pigaches +2"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(4, 10)
end