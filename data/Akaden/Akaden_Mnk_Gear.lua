function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc', 'Fodder')
    state.WeaponskillMode:options('Match','Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Normal', 'PDT','PDTOnly')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Godhands','ProcStaff','ProcClub','Barehanded','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}

    update_melee_groups()
	
	-- Additional local binds
	--send_command('bind ^` input /ja "Boost" <me>')
	--send_command('bind !` input /ja "Perfect Counter" <me>')
	--send_command('bind ^backspace input /ja "Mantra" <me>')
    --send_command('bind !f11 gs c cycle ExtraMeleeMode')
	--send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

function init_gear_sets()
    include('augmented_gear.lua')
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {waist = "Chaac belt",hands=augmented_gear.Herculean.TH.hands, feet=augmented_gear.Herculean.TH.feet})
	sets.engaged = {
		ammo="Staunch tathlum",
	    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
	    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',},},
	    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+4','STR+3',}},
	    neck="Anu Torque",
	    waist="Windbuffet Belt +1",
	    left_ear="Brutal Earring",
	    right_ear="Odnowa earring +1",
	    left_ring="Epona's Ring",
	    right_ring="Defending Ring",
	    back="Moonbeam Cape",}
	sets.idle = set_combine(sets.engaged, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(5, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 20)
	elseif player.sub_job == 'THF' then
		set_macro_page(6, 20)
	elseif player.sub_job == 'RUN' then
		set_macro_page(7, 20)
	else
		set_macro_page(6, 20)
	end
end