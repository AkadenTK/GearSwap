-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff['Hundred Fists'] = buffactive['Hundred Fists'] or false
    state.Buff['Impetus'] = buffactive['Impetus'] or false
	state.Buff['Counterstance'] = buffactive['Counterstance'] or false
	
	state.AutoBoost = M(true, 'Auto Boost Mode')
    state.CounterMode = M{['description']='Counter Mode', 'None', 'Hate', 'Always'}
	
	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Victory Smite'}
	
	autows = 'Victory Smite'
	autofood = 'Soy Ramen'
	
    state.Impetus = {current=0}
    windower.raw_register_event('action', on_action_for_impetus)
    windower.raw_register_event('action', on_action_for_counter)
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoBuffMode",},{"AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","IdleMode","Passive","RuneElement","TreasureMode","CounterMode","Impetus"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)

end

function job_precast(spell, spellMap, eventArgs)

	if spell.type == 'WeaponSkill' and state.AutoBoost.value then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if abil_recasts[16] < latency then
			eventArgs.cancel = true
			windower.chat.input('/ja "Boost" <me>')
			windower.chat.input:schedule(1,'/ws "'..spell.english..'" '..spell.target.raw..'')
			return
		end
	end

end

-- Run after the general precast() is done.
function job_post_precast(spell, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current == 'None' then
        local WSset = get_precast_set(spell, spellMap)
        if buffactive.Impetus and WSset.Impetus then
			equip(WSset.Impetus)
        end
        
		if buffactive.Footwork and WSset.Footwork then
            equip(WSset.Footwork)
        end
		
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 and moonshade_ws:contains(spell.english) then
			if check_ws_acc():contains('Acc') then
				if sets.AccMaxTP then
					equip(sets.AccMaxTP)
				end
						
			elseif sets.MaxTP then
					equip(sets.MaxTP)
			end

        end
        
    end
end

function job_aftercast(spell, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------


function look_offset(a, b)
    if not a or not b then return false end
    local h = a.facing % math.pi
    local h2 = (math.atan2(a.x-b.x,a.y-b.y) + math.pi/2) % math.pi
    return math.abs(h-h2) 
end

function check_counterable()
    local t, me = windower.ffxi.get_mob_by_target('t'), windower.ffxi.get_mob_by_target('me')
    local old_counterable = state.can_increase_counter_rate

    state.can_increase_counter_rate = not buff['Counterstance'] -- counterstance should be capping counter anyway.
                                      and look_offset(t, me) < 0.15 and look_offset(me, t) < 0.76
    if old_counterable ~= state.can_increase_counter_rate then
        windower.add_to_chat(123, "Counterable: "..tostring(state.can_increase_counter_rate))
        equip(get_melee_set())
    end
end

function job_tick()
    if state.CounterMode.Value == "Hate" and player.status == 'Engaged' and player.target and player.target.type == 'MONSTER' then
        if player.target.model_size and player.target.distance < (3.2 + player.target.model_size) then
           check_counterable()
        end
    end

    return false
end

function on_action_for_counter(action)
    if state.CounterMode.Value == "Hate" then
        if action.actor_id == player.id and action.category == 1 then
            -- we auto-attacked. Make check for counter state.
            check_counterable()
        end
        for _, t in ipairs(action.targets) do
            if t.id == player.id and action.category == 1 then
                check_counterable()
            end
        end
    end
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)
    if state.CounterMode.Value == "Always" then
        meleeSet = set_combine(meleeSet, sets.counter)
    elseif state.CounterMode.Value == "Hate" and state.can_increase_counter_rate then
        meleeSet = set_combine(meleeSet, sets.counter)
    end

    if state.ExtraMeleeMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraMeleeMode.value])
    end
	
    if buffactive.Impetus and meleeSet.Impetus then
		meleeSet = set_combine(meleeSet, meleeSet.Impetus)
    end
    
    if buffactive.Counterstance and state.DefenseMode.value == 'None' and state.OffenseMode.value ~= 'FullAcc' then
        meleeSet = set_combine(meleeSet, sets.buff.Counterstance)
    end
    
    if buffactive.Footwork and state.DefenseMode.value == 'None' and state.OffenseMode.value ~= 'FullAcc' then
        meleeSet = set_combine(meleeSet, sets.buff.Footwork)
    end
	
    return meleeSet
end

function job_customize_defense_set(defenseSet)
    if state.ExtraMeleeMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraMeleeMode.value])
    end

    return defenseSet
end

function job_customize_idle_set(idleSet)

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            state.Impetus.current = 0
                        else
                            state.Impetus.current = state.Impetus.current + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            state.Impetus.current = 0
                        else
                            state.Impetus.current = state.Impetus.current + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                state.Impetus.current = 0
                            elseif action.spike_effect_animation == 63 then
                                state.Impetus.current = state.Impetus.current + 1
                            end
                        end
                    end
                end
            end
        end
        
        state.Impetus.current = math.min(state.Impetus.current, 50)
        update_job_states()
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(state.Impetus.current))
    else
        state.Impetus.current = 0
    end
    
end

function job_self_command(commandArgs, eventArgs)

end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()

	if buffactive.footwork and not buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('Footwork')
    end
	
	if player.equipment.main and player.equipment.main == "Glanzfaust" and state.Buff['Aftermath: Lv.3'] then
		classes.CustomMeleeGroups:append('AM')
	end
	
    if state.Buff['Hundred Fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
end