smart_cure_potencies = {['Cure'] = 100, ['Cure II'] = 250, ['Cure III'] = 450, ['Cure IV'] = 800, ['Cure V'] = 1200, ['Cure VI'] = 1500, ['Curaga'] = 150, ['Curaga II'] = 350, ['Curaga III'] = 650, ['Curaga IV'] = 1300, ['Curaga V'] = 1750}
smart_overcure_allowance = 0.95
smart_cure_ids = {['Cure'] = 1, ['Cure II'] = 2, ['Cure III'] = 3, ['Cure IV'] = 4, ['Cure V'] = 5, ['Cure VI'] = 6, ['Curaga'] = 7, ['Curaga II'] = 8, ['Curaga III'] = 9, ['Curaga IV'] = 10, ['Curaga V'] = 11}

function smartcure_target(target)
	local curaga_info = get_best_curaga_info(target)
	if curaga_info and curaga_info.member_count > 1 and curaga_info['avg_missing_hp'] >= 300 then
		-- do curaga

		local curaga_spell = get_curaga_by_info(curaga_info)
		if curaga_spell then
			local downgraded_curaga = downgrade_curaga_by_recast_and_cost(curaga_spell)
			if downgraded_curaga then
				if downgraded_curaga ~= curaga_spell then
					add_to_chat(123,'Alert: Curaga changed due to recast times or MP.')
				end
				send_command('@input /ma "'..downgraded_curaga..'" '..target)
				return
			else
				add_to_chat(123,'Alert: Appropriate Curagas are on cooldown or MP not sufficient.')
			end
		end
	end
	-- do single-target
	local missingHP
	local missingHPP
	if target == player.name then
		missingHP = player.max_hp - player.hp
		missingHPP = 100 - player.hpp
	else
		local ally_member = find_player_in_alliance(target)
		if ally_member == nil then
			local mob = windower.ffxi.get_mob_by_name(target)
			if mob ~= nil then
				missingHPP = 100 - mob.hpp
			end
		else
			missingHP = (ally_member.hp / (ally_member.hpp/100)) - ally_member.hp
			missingHPP = 100 - ally_member.hpp
		end
	end

	add_to_chat(8,'SmartCure: Trying to cure '..target..' for '..tostring(math.floor(missingHP))..' ('..tostring(missingHPP)..'%)')

	local cure_spell = get_cure_by_hp(missingHP, missingHPP)
	if cure_spell then
		add_to_chat(123,'Cure chosen: '..cure_spell)
		local downgraded_cure = downgrade_cure_by_recast_and_cost(cure_spell)
		if downgraded_cure then
			if downgraded_cure ~= cure_spell then
				add_to_chat(8,'Alert: Cure changed due to recast times or MP.')
			end
			send_command('@input /ma "'..downgraded_cure..'" '..target)
		else
			add_to_chat(123,'Abort: Appropriate cures are on cooldown or MP not sufficient.')
		end
	else
		add_to_chat(123,'Abort: SmartCure not necessary.')
	end
end

function get_cure_by_hp(missingHP,missingHPP)
	if missingHP then
		local mod = get_cure_mod()

		-- don't bother casting if missing hpp is too low, unless it's an inordinate amount or total HP is really low
		if missingHPP >= 15 or (missingHP > 400 * mod) or (missingHP / (missingHPP/100) < 1300) then
			if spell_available("Cure VI") and missingHP > smart_cure_potencies['Cure VI'] * mod * smart_overcure_allowance then
				return "Cure VI"
			elseif spell_available("Cure V") and missingHP > smart_cure_potencies['Cure V'] * mod * smart_overcure_allowance then
				return "Cure V"
			elseif spell_available("Cure IV") and missingHP > smart_cure_potencies['Cure IV'] * mod * smart_overcure_allowance then
				return "Cure IV"
			elseif spell_available("Cure III") then
				return "Cure III"
			else
				return nil
			end
		end
		return nil
	else
		if missingHPP > 75 then
			return "Cure V"
		elseif missingHPP > 45 then
			return "Cure IV"
		else 
			return	"Cure III"
		end
	end
end

function downgrade_cure_by_recast_and_cost(cure)
	local spell_recasts = windower.ffxi.get_spell_recasts()

	if cure == "Cure VI" and (spell_recasts[6] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		cure = "Cure V"
	end
	if cure == "Cure V" and (spell_recasts[5] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		cure = "Cure IV"
	end
	if cure == "Cure IV" and (spell_recasts[4] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		-- maybe try upgrade?
		cure = "Cure V"
	end
	if cure == "Cure V" and (spell_recasts[5] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		-- nope, fuck.
		cure = "Cure III"
	end
	if cure == "Cure III" and (spell_recasts[3] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		-- maybe try upgrade?
		cure = "Cure IV"
	end
	if cure == "Cure IV" and (spell_recasts[4] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		-- nope, fuck.
		cure = "Cure II"
	end
	if cure == "Cure II" and (spell_recasts[2] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		-- nothing's ready and no MP. Fuck it.
		cure = nil
	end

	return cure
end

function get_curaga_by_info(curaga_info)
	local missingHP = curaga_info['avg_missing_hp']
	if curaga_info['danger_count'] > 2 then
		missingHP = curaga_info['max_missing_hp']
	end
	local mod = get_cure_mod()

	if spell_available("Curaga V") and missingHP > smart_cure_potencies['Curaga V'] * mod * smart_overcure_allowance then
		return "Curaga V"
	elseif spell_available("Curaga IV") and missingHP > smart_cure_potencies['Curaga IV'] * mod * smart_overcure_allowance then
		return "Curaga IV"
	elseif spell_available("Curaga III") and missingHP > smart_cure_potencies['Curaga III'] * mod * smart_overcure_allowance then
		return "Curaga III"
	elseif spell_available("Curaga II") then
		return "Curaga II"
	else
		return nil
	end
end

function get_cure_mod()
	local mod = 1
	if world.day_element == 'Light' then
		mod = mod + 0.1
	elseif world.day_element == 'Dark' then
		mod = mod - 0.1
	end
	if world.weather_element == 'Light' then 
		mod = mod + 0.15
	elseif world.weather_element == 'Dark' then 
		mod = mod - 0.15
	end
	add_to_chat(8,'SmartCure: Cure Mod: '..mod)
	return mod
end

function downgrade_curaga_by_recast_and_cost(cure)
	local spell_recasts = windower.ffxi.get_spell_recasts()

	if cure == "Curaga V" and (spell_recasts[11] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		cure = "Curaga IV"
	end
	if cure == "Curaga IV" and (spell_recasts[10] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		cure = "Curaga III"
	end
	if cure == "Curaga III" and (spell_recasts[9] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		-- maybe try upgrade?
		cure = "Curaga IV"
	end
	if cure == "Curaga IV" and (spell_recasts[10] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		-- nope, fuck.
		cure = "Curaga II"
	end
	if cure == "Curaga II" and (spell_recasts[8] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		-- maybe try upgrade?
		cure = "Curaga III"
	end
	if cure == "Curaga III" and (spell_recasts[9] > 0 or actual_cost(get_spell_table_by_name(cure)) > player.mp) or not spell_available(cure) then
		-- nope, fuck. Give up
		cure = nil
	end

	return cure
end

function get_best_curaga_info(target)
	local target_info = find_player_in_alliance(target)
	local best_curaga_info
	for i = 1,6 do
		if party[i] then
			local dist = get_dist(target_info.mob, party[i].mob)
			-- ignore any curaga target that doesn't include the specified one
		    if dist <= 10 then 
		    	local curaga_info = get_curaga_info(party[i])
		    	if best_curaga_info == nil or compare_curaga(best_curaga_info, curaga_info) > 0 then
		    		best_curaga_info = curaga_info
		    	end
		    end
		end
	end

	return best_curaga_info
end

function get_dist(mob1, mob2)
	if mob1 == nil or mob2 == nil then
		return 50
	end
	local dx = mob1.x - mob2.x
	local dy = mob1.y - mob2.y
	return math.sqrt((dx^2)+(dy^2))
end

function get_curaga_info(target_info)
	local info = {members = {}, member_count = 0, total_heal = 0, danger_count = 0, avg_missing_hp = 0, max_missing_hp = 0}
	for i = 1,6 do
		local member = party[i]
		if member and get_dist(target_info.mob, member.mob) <= 10 and member.hpp < 90 then
			local member_missing_hp = (member.hp / (member.hpp/100)) - member.hp
			info['total_heal'] = info['total_heal'] + member_missing_hp
			if member.hpp < 65 then 
				info['danger_count'] = info['danger_count'] + 1 
			end
			info['avg_missing_hp'] = (info['avg_missing_hp'] * info['member_count'] + member_missing_hp) / (info['member_count'] + 1)
			info['members'][info['member_count']] = member
			info['member_count'] = info['member_count'] + 1
			if member_missing_hp > info['max_missing_hp'] then 
				info['max_missing_hp'] = member_missing_hp 
			end
		end
	end
	return info
end

function compare_curaga(info1, info2)
	local r = info2['danger_count'] - info1['danger_count']

	if r==0 then
		r = info2['total_heal'] - info1['total_heal']
	end

	return r
end

function spell_available(spell)
	local spell_jobs = copy_entry(res.spells[smart_cure_ids[spell]].levels)
	return spell_jobs[player.main_job_id] and 
				(spell_jobs[player.main_job_id] <= player.main_job_level or 
					(spell_jobs[player.main_job_id] >= 100 and number_of_jps(player.job_points[__raw.lower(res.jobs[player.main_job_id].ens)]) >= spell_jobs[player.main_job_id]) ) 
end