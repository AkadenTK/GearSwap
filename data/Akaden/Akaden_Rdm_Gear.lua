
    include('smartcure.lua')
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal', 'DTLite', 'FullDT')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'TPEat','DTHippo')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Sequence', 'Savage', 'None') -- , 'Crocea'
    state.EnhancingMode = M('Always', 'Never', '300', '1000')
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = "Toro Cape"
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = "Toro Cape"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

    enhancing_spells = T{'Aquaveil', 'Stoneskin', 'Protect', 'Shell', 'Temper', 'Temper II', 
                         'Enthunder', 'Enstone', 'Enaero', 'Enblizzard', 'Enfire', 'Enwater', 'Enthunder II', 'Enstone II', 'Enaero II', 'Enblizzard II', 'Enfire II', 'Enwater II',}
		-- Additional local binds
	--send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	--send_command('bind ^@!` input /ja "Accession" <me>')
	--send_command('bind ^backspace input /ja "Saboteur" <me>')
	--send_command('bind !backspace input /ja "Spontaneity" <t>')
	--send_command('bind @backspace input /ja "Composure" <me>')
	--send_command('bind @f8 gs c toggle AutoNukeMode')
	--send_command('bind != input /ja "Penury" <me>')
	--send_command('bind @= input /ja "Parsimony" <me>')
	--send_command('bind ^delete input /ja "Dark Arts" <me>')
	--send_command('bind !delete input /ja "Addendum: Black" <me>')
	--send_command('bind @delete input /ja "Manifestation" <me>')
	--send_command('bind ^\\\\ input /ma "Protect V" <t>')
	--send_command('bind @\\\\ input /ma "Shell V" <t>')
	--send_command('bind !\\\\ input /ma "Reraise" <me>')
	--send_command('bind @f10 gs c cycle RecoverMode')
	
	select_default_macro_book()
end

function init_gear_sets()

    augmented_gear.capes = {}
    augmented_gear.capes.dex_crit = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
    augmented_gear.capes.str_wsd = { name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    augmented_gear.capes.stp = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    augmented_gear.capes.mnd_macc = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20',}}
    augmented_gear.capes.int_mab = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    augmented_gear.capes.int_macc = augmented_gear.capes.int_mab

	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +1"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {
        ammo="Impatiens",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body="Vitiation tabard +1",
        hands="Leyline Gloves",
        legs="Psyloth Lappas",
        feet="Carmine Greaves +1",
        neck="Asperity Necklace",
        waist="Witful Belt",
        left_ring="Weatherspoon Ring",
        right_ring="Kishar Ring",
    }
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        ammo="Regal Gem",
        head='Vitiation Chapeau +1',
        body="Shamash Robe",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear="Regal Earring",
        left_ring="Ilabrat Ring",
        right_ring="Stikini Ring",
        back=augmented_gear.capes.mnd_macc,
    })
	
	sets.precast.WS['Chant Du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Jukukik Feather",
        head=augmented_gear.Taeon.TP.head,
        body="Ayanmo Corazza +2",
        hands="Malignance Gloves",
        legs=augmented_gear.Taeon.TP.legs,
        feet="Thereoid Greaves",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear="Mache Earring +1",
        left_ring="Ilabrat Ring",
        right_ring="Begrudging Ring",
        back=augmented_gear.capes.dex_crit,
    })

	sets.precast.WS['Savage Blade'] = {
        ammo="Floestone",
        head="Jhakri Coronal +2",
        body="Ayanmo Corazza +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Brutal Earring",
        right_ear="Ishvara Earring",
        left_ring="Ayanmo Ring",
        right_ring="Ifrit Ring +1",
        back=augmented_gear.capes.str_wsd,
    }
        
    sets.precast.WS['Sanguine Blade'] = {
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body=augmented_gear.Merlinic.Damage.body,
        hands="Jhakri Cuffs +2",
        legs=augmented_gear.Merlinic.Damage.legs,
        feet=augmented_gear.Merlinic.Damage.feet,
        neck="Baetyl Pendant",
        waist="Refoccilation Stone",
        left_ear="Regal Earring",
        right_ear="Malignance earring",
        left_ring="Shiva Ring +1",
        right_ring="Acumen Ring",
        back=augmented_gear.capes.int_mab,
    }

        
    sets.precast.WS['Seraph Blade'] = {
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        --neck="Fotia Gorget",
        --waist="Fotia Belt",
        neck="Baetyl Pendant",
        waist="Refoccilation Stone",
        left_ear="Regal Earring",
        right_ear="Malignance earring",
        left_ring="Shiva Ring +1",
        right_ring="Weatherspoon Ring",
        back=augmented_gear.capes.int_mab,
    }

	
	-- Midcast Sets

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1",waist="Chaac Belt",legs="Volte Hose",feet="Volte Boots"})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {
        head="Ea Hat",
        neck="Mizu. Kubikazari",
        hands="Amalric Gages",
        ring1="Mujin Band",
        legs=augmented_gear.Merlinic.Burst.legs,
        feet="Jhakri Pigaches +2"
    }
	sets.RecoverBurst = {}
	
	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Earth = {neck="Quanpur Necklace"}

	sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
        ammo="Regal Gem",
        head="Viti. Chapeau +1",
        body="Shamash Robe",
        hands="Telchine Gloves",
        legs="Atrophy Tights +1",
        feet="Medium's Sabots",
        neck="Nodens Gorget",
        waist="Emphatikos Rope",-- sp. intr. rate.
        left_ear="Mendi. Earring",
        right_ear="Regal Earring",
        left_ring="Stikini Ring",
        right_ring="Weather. Ring",
        back="Solemnity Cape",
    }
		
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {})
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	sets.midcast['Enhancing Magic'] = {
        head=augmented_gear.Telchine.Enhancing.head,
        body="Viti. Tabard +1",
        hands="Atrophy Gloves +1",
        legs="Carmine Cuisses +1",
        feet="Leth. Houseaux +1",
        neck="Dls. Torque +1",
        waist="Olympus Sash",
        left_ear="Halasz Earring",
        right_ear="Andoaa Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Ghostfyre Cape",
    }

    sets.enhancing_weapons = {
        main="Pukulatmuj +1",
        sub="Pukulatmuj",
    }

    sets.enhancing_skill = set_combine(sets.midcast['Enhancing Magic'], {
        head="Befouled Crown",
        hands="Vitiation Gloves +1",
        legs="Carmine Cuisses +1",
        neck="Melic Torque",
    })

    sets.midcast.Phalanx = set_combine(sets.enhancing_skill, {
        head=augmented_gear.Taeon.Phalanx.head,
        body=augmented_gear.Taeon.Phalanx.body,
        hands=augmented_gear.Taeon.Phalanx.hands,
        feet=augmented_gear.Taeon.Phalanx.feet,
    })

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.		
	sets.buff.ComposureOther = set_combine(sets.midcast['Enhancing Magic'], {head="Telchine Cap",body="Lethargy Sayon +1",hands="Atrophy Gloves +1",legs="Lethargy Fuseau +1",feet="Leth. Houseaux +1",})
		
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash",legs="Leth. Fuseau +1"})
	sets.midcast.Aquaveil = set_combine(sets.enhancing_skill, {waist="Emphatikos Rope"})
	sets.midcast.BarElement = set_combine(sets.enhancing_skill, {})
	sets.midcast.Stoneskin = set_combine(sets.enhancing_skill, {neck="Nodens Gorget",waist="Siegel Sash"})
	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}
    sets.midcast.Temper = set_combine(sets.enhancing_skill, {})
    sets.midcast["Temper II"] = sets.midcast.Temper
	
	sets.midcast['Enfeebling Magic'] = {
        ammo="Regal Gem",
        head=augmented_gear.Merlinic.Accuracy.head,
        body="Lethargy Sayon +1",
        hands="Leth. Gantherots +1",
        legs=augmented_gear.Merlinic.Accuracy.legs,
        feet="Jhakri Pigaches +2",
        neck="Duelist's torque +1",
        waist="Eschan Stone",
        left_ear="Digni. Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring",
        right_ring="Kishar Ring",
        back=augmented_gear.capes.mnd_macc,
    }
		
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast['Distract III'] = set_combine(sets.midcast.MndEnfeebles, {hands="Leth. Gantherots +1",ring1="Stikini Ring"})
	sets.midcast['Distract III'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {})
	sets.midcast['Frazzle III'] = set_combine(sets.midcast.MndEnfeebles, {hands="Leth. Gantherots +1",ring1="Stikini Ring"})
	sets.midcast['Frazzle III'].Resistant = set_combine(sets.midcast.MndEnfeebles.Resistant, {})
	
	sets.midcast.Silence = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.Silence.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})	
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1"})
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1"})

	sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1"})
	sets.midcast['Slow II'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Viti. Chapeau +1"})
	
    sets.midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum",
        head=augmented_gear.Merlinic.Damage.head,
        body=augmented_gear.Merlinic.Damage.body,
        hands="Jhakri Cuffs +2",
        legs=augmented_gear.Merlinic.Damage.legs,
        feet=augmented_gear.Merlinic.Damage.feet,
        neck="Baetyl Pendant",
        waist="Refoccilation Stone",
        left_ear="Regal Earring",
        right_ear="Malignance Earring",
        left_ring="Acumen Ring",
        right_ring="Shiva Ring +1",
        back=augmented_gear.capes.mnd_macc,
    }
		
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        feet="Jhakri Pigaches +2",
        left_ear="Heretic Earring",
        left_ring="Stikini ring",
    })
		
    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Elemental Magic'].Proc = {}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
		
	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {head=empty,body="Twilight Cloak",back=augmented_gear.capes.int_macc,})

	sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = set_combine(sets.midcast['Elemental Magic'], {
        head="Pixie Hairpin +1",
        left_ring="Archon Ring",
        right_ring="Evanescence Ring",
    })

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = set_combine(sets.midcast['Enfeebling Magic'], {})
		
	sets.midcast.Stun.Resistant = {}

	-- Sets for special buff conditions on spells.
		
	sets.buff.Saboteur = {hands="Leth. Gantherots +1"}
	
	sets.HPDown = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.

	-- Engaged sets

	sets.engaged = {
        ammo="Ginsen",
        head=augmented_gear.Taeon.TP.head,
        body="Ayanmo Corazza +2",
        hands="Malignance Gloves",
        legs=augmented_gear.Taeon.TP.legs,
        feet=augmented_gear.Taeon.TP.feet,
        neck="Anu Torque",
        waist="Windbuffet Belt +1",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        left_ring="Petrov Ring",
        right_ring="Hetairoi Ring",
        back=augmented_gear.capes.stp,
    }

	sets.engaged.DW = {
        ammo="Ginsen",
        head=augmented_gear.Taeon.TP.head,
        body="Ayanmo Corazza +2",
        hands="Malignance Gloves",
        legs=augmented_gear.Taeon.TP.legs,
        feet=augmented_gear.Taeon.TP.feet,
        neck="Anu Torque",
        waist="Windbuffet Belt +1",
        left_ear="Sherida Earring",
        right_ear="Suppanomimi",
        left_ring="Petrov Ring",
        right_ring="Hetairoi Ring",
        back=augmented_gear.capes.stp,
    }
        
    sets.engaged.DTLite = set_combine(sets.engaged, {
        head="Ayanmo Zucchetto +2",
        hands="Malignance Gloves",
        neck="Loricate Torque +1",
        right_ring="Defending Ring",
    })
        
    sets.engaged.DTLite.DW = set_combine(sets.engaged.DW, {
        head="Ayanmo Zucchetto +2",
        hands="Malignance Gloves",
        neck="Loricate Torque +1",
        right_ring="Defending Ring",
    })
        
    sets.engaged.FullDT = set_combine(sets.engaged.DTLite, {
        ammo="Staunch Tathlum +1",
        legs="Ayanmo Cosciales +2",
        feet="Carmine Greaves +1",
    })
        
    sets.engaged.FullDT.DW = set_combine(sets.engaged.DTLite.DW, {
        ammo="Staunch Tathlum +1",
        legs="Ayanmo Cosciales +2",
        feet="Carmine Greaves +1",
    })


    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = set_combine(sets.engaged.DW, {
        ammo="Homiliary",
        head="Vitiation Chapeau +1",
        body="Shamash Robe",
        hands="Malignance Gloves",
        neck="Loricate Torque +1",
        waist="Flume belt",
        legs="Ayanmo Cosciales +2",
        feet="Carmine Greaves +1",
        left_ear="Ethereal earring",
        right_ear="Hearty earring",
        left_ring="Warden's ring",
        right_ring="Defending Ring",
    })
        
    sets.idle.PDT = set_combine(sets.idle, {})
        
    sets.idle.MDT = set_combine(sets.idle, {})
        
    sets.idle.Weak = set_combine(sets.idle, {})
    
    sets.idle.DTHippo = set_combine(sets.idle.PDT, {})
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.NukeLock = sets.midcast['Elemental Magic']
        
    sets.defense.MDT = {}
        
    sets.defense.MEVA = {}
        
    sets.idle.TPEat = set_combine(sets.idle, {})

    sets.Kiting = {legs="Carmine Cuisses +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    sets.DayIdle = {}
    sets.NightIdle = {}
    
    -- Weapons sets
    sets.weapons.Sequence = {main="Sequence", sub="Kaja Knife"}
    sets.weapons.Savage = {main="Naegling", sub="Kaja Knife"}
    sets.weapons.Crocea = {main="Crocea Mors", sub="Kaja Knife"}

end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	set_macro_page(1, 19)

    if player.sub_job == 'NIN' then
        windower.chat.input:schedule(1,'/lockstyleset 84')
    else
        windower.chat.input:schedule(1,'/lockstyleset 84')
    end
end

function user_job_precast(spell, spellMap, eventArgs)
    if state.smartcure and spell.english:lower() == 'cure' then
        state.smartcure = false
        eventArgs.cancel = true
        smartcure_target(spell.target.name)     
    end
    state.smartcure = false
end

function user_job_aftercast(spell, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and enhancing_spells:contains(spell.english) and not spell.interrupted then
        if state.EnhancingMode.value ~= 'Never' then
            for slot,piece in pairs(sets.enhancing_weapons) do
                enable(slot)
                local s = {}
                s[slot] = sets.weapons[state.Weapons.Value][slot]
                equip(s)
                disable(slot)
            end
        end
    end
end

function user_job_post_precast(spell, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and enhancing_spells:contains(spell.english) then
        if state.EnhancingMode.value ~= 'Never' and (state.EnhancingMode.value == 'Always' or tonumber(state.EnhancingMode.value) > player.tp) then
            for slot,piece in pairs(sets.enhancing_weapons) do
                enable(slot)
                local s = {}
                s[slot] = piece
                equip(s)
            end
        end
    end
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