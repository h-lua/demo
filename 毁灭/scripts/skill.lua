--[[
    击飞
    options = {
        damage = 0, --伤害（必须有，但是这里可以等于0）
        targetUnit = [unit], --目标单位（必须有）
        sourceUnit = [unit], --伤害来源单位（可选）
        odds = 100, --几率（可选,默认100）
        distance = 0, --击退距离，可选，默认0
        height = 100, --击飞高度，可选，默认100
        during = 0.5, --击飞过程持续时间，可选，默认0.5秒
        effect = nil, --特效（可选）
        damageSrc = CONST_DAMAGE_SRC, --伤害的种类（可选）
    }
]]
---@param options pilotCrackFly
crackFly = function(options)
    if (options.damage == nil or options.damage < 0) then
        return
    end
    if (options.targetUnit == nil or his.deleted(options.targetUnit)) then
        return
    end
    local odds = options.odds or 100
    local damage = options.damage or 0
    --计算抵抗
    local oppose = hattribute.get(options.targetUnit, "crack_fly_oppose")
    odds = odds - oppose --(%)
    if (odds <= 0) then
        return
    else
        if (math.random(1, 1000) > odds * 10) then
            return
        end
        if (damage > 0) then
            damage = damage * (1 - oppose * 0.01)
        end
    end
    local distance = options.distance or 0
    local height = options.height or 100
    local during = options.during or 0.5
    if (during < 0.5) then
        during = 0.5
    end
    --不二次击飞
    if (hcache.get(options.targetUnit, CONST_CACHE.SKILL_CRACK_FLY, false) == true) then
        return
    end
    hcache.set(options.targetUnit, CONST_CACHE.SKILL_CRACK_FLY, true)
    local tempObj = {
        odds = 99999,
        targetUnit = options.targetUnit,
        during = during
    }
    unarm(tempObj)
    silent(tempObj)
    hattribute.set(options.targetUnit, during, { move = "-9999" })
    if (type(options.effect) == "string" and string.len(options.effect) > 0) then
        heffect.attach(options.effect, options.targetUnit, "origin", during)
    end
    hunit.setCanFly(options.targetUnit)
    cj.SetUnitPathing(options.targetUnit, false)
    local originHigh = hunit.getFlyHeight(options.targetUnit)
    local originFacing = hunit.getFacing(options.targetUnit)
    local originDeg
    if (options.sourceUnit ~= nil) then
        originDeg = math.getDegBetweenUnit(options.sourceUnit, options.targetUnit)
    else
        originDeg = math.random(0, 360)
    end
    local cost = 0
    htime.setInterval(0.05, function(t)
        local dist = 0
        local z = 0
        local timerSetTime = t.period()
        if (cost > during) then
            if (damage > 0) then
                hskill.damage({
                    sourceUnit = options.sourceUnit,
                    targetUnit = options.targetUnit,
                    effect = options.effect,
                    damage = damage,
                    damageSrc = options.damageSrc,
                    damageString = "击飞",
                    damageRGB = { 128, 128, 0 },
                })
            end
            cj.SetUnitFlyHeight(options.targetUnit, originHigh, 10000)
            cj.SetUnitPathing(options.targetUnit, true)
            hcache.set(options.targetUnit, CONST_CACHE.SKILL_CRACK_FLY, false)
            -- 默认是地面，创建沙尘
            local tempEff = "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl"
            if (hterrain.isWater(hunit.x(options.targetUnit), hunit.y(options.targetUnit))) then
                -- 如果是水面，创建水花
                tempEff = "Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl"
            end
            heffect.xyz(tempEff, hunit.x(options.targetUnit), hunit.y(options.targetUnit), hunit.z(options.targetUnit), 0)
            t.destroy()
            return
        end
        cost = cost + timerSetTime
        if (cost < during * 0.35) then
            dist = distance / (during * 0.5 / timerSetTime)
            z = height / (during * 0.35 / timerSetTime)
            if (dist > 0) then
                local px, py = math.polarProjection(hunit.x(options.targetUnit), hunit.y(options.targetUnit), dist, originDeg)
                cj.SetUnitFacing(options.targetUnit, originFacing)
                if (his.borderMap(px, py) == false) then
                    hunit.portal(options.targetUnit, px, py)
                end
            end
            if (z > 0) then
                cj.SetUnitFlyHeight(options.targetUnit, hunit.getFlyHeight(options.targetUnit) + z, z / timerSetTime)
            end
        else
            dist = distance / (during * 0.5 / timerSetTime)
            z = height / (during * 0.65 / timerSetTime)
            if (dist > 0) then
                local px, py = math.polarProjection(hunit.x(options.targetUnit), hunit.y(options.targetUnit), dist, originDeg)
                cj.SetUnitFacing(options.targetUnit, originFacing)
                if (his.borderMap(px, py) == false) then
                    hunit.portal(options.targetUnit, px, py)
                end
            end
            if (z > 0) then
                cj.SetUnitFlyHeight(options.targetUnit, hunit.getFlyHeight(options.targetUnit) - z, z / timerSetTime)
            end
        end
    end)
end

--[[
    沉默
    options = {
        targetUnit = unit, --目标单位，必须
        during = 0, --持续时间，必须
        odds = 100, --几率，可选
        damage = 0, --伤害，可选
        sourceUnit = nil, --来源单位，可选
        effect = nil, --特效，可选
        damageSrc = CONST_DAMAGE_SRC, --伤害的种类（可选）
    }
]]
---@param options pilotSilent
silent = function(options)
    if (options.during == nil or options.during <= 0) then
        return
    end
    if (options.targetUnit == nil or his.deleted(options.targetUnit)) then
        return
    end
    local u = options.targetUnit
    local during = options.during
    local odds = options.odds or 100
    local damage = options.damage or 0
    local sourceUnit = options.sourceUnit
    --计算抵抗
    local oppose = hattribute.get(u, "silent_oppose")
    odds = odds - oppose --(%)
    if (odds <= 0) then
        return
    else
        if (math.random(1, 1000) > odds * 10) then
            return
        end
        during = during * (1 - oppose * 0.01)
        damage = damage * (1 - oppose * 0.01)
    end
    local level = hcache.get(u, CONST_CACHE.SKILL_SILENT_LEVEL, 0) + 1
    if (type(options.effect) == "string" and string.len(options.effect) > 0) then
        heffect.attach(options.effect, u, "origin", during)
    end
    hcache.set(u, CONST_CACHE.SKILL_SILENT_LEVEL, level)
    if (true == hcache.get(u, CONST_CACHE.SKILL_SILENT, false)) then
        local eff = heffect.attach("Abilities\\Spells\\Other\\Silence\\SilenceTarget.mdl", u, "head", -1)
        hcache.set(u, CONST_CACHE.SKILL_SILENT_EFFECT, eff)
    end
    hcache.set(u, CONST_CACHE.SKILL_SILENT, true)
    if (damage > 0) then
        hskill.damage(
            {
                sourceUnit = sourceUnit,
                targetUnit = u,
                damage = damage,
                damageString = "沉默",
                damageSrc = options.damageSrc,
            }
        )
    end
    htime.setTimeout(during, function(t)
        t.destroy()
        hcache.set(u, CONST_CACHE.SKILL_SILENT_LEVEL, hcache.get(u, CONST_CACHE.SKILL_SILENT_LEVEL, 0) - 1)
        if (hcache.get(u, CONST_CACHE.SKILL_SILENT_LEVEL, 0) <= 0) then
            heffect.destroy(hcache.get(u, CONST_CACHE.SKILL_SILENT_EFFECT))
            hcache.set(u, CONST_CACHE.SKILL_SILENT, false)
        end
    end)
end

--[[
    缴械
    options = {
        targetUnit = unit, --目标单位，必须
        during = 0, --持续时间，必须
        odds = 100, --几率，可选
        damage = 0, --伤害，可选
        sourceUnit = nil, --来源单位，可选
        effect = nil, --特效，可选
        damageSrc = CONST_DAMAGE_SRC, --伤害的种类（可选）
    }
]]
---@param options pilotUnArm
unarm = function(options)
    if (options.during == nil or options.during <= 0) then
        return
    end
    if (options.targetUnit == nil or his.deleted(options.targetUnit)) then
        return
    end
    local u = options.targetUnit
    local during = options.during
    local odds = options.odds or 100
    local damage = options.damage or 0
    local sourceUnit = options.sourceUnit
    --计算抵抗
    local oppose = hattribute.get(u, "unarm_oppose")
    odds = odds - oppose --(%)
    if (odds <= 0) then
        return
    else
        if (math.random(1, 1000) > odds * 10) then
            return
        end
        during = during * (1 - oppose * 0.01)
        damage = damage * (1 - oppose * 0.01)
    end
    local level = hcache.get(u, CONST_CACHE.SKILL_UN_ARM_LEVEL, 0) + 1
    if (type(options.effect) == "string" and string.len(options.effect) > 0) then
        heffect.attach(options.effect, u, "origin", during)
    end
    hcache.set(u, CONST_CACHE.SKILL_UN_ARM_LEVEL, level)
    if (true == hcache.get(u, CONST_CACHE.SKILL_UN_ARM, false)) then
        local eff = heffect.attach("Abilities\\Spells\\Other\\Silence\\SilenceTarget.mdl", u, "weapon", -1)
        hcache.set(u, CONST_CACHE.SKILL_UN_ARM_EFFECT, eff)
    end
    hcache.set(u, CONST_CACHE.SKILL_UN_ARM, true)
    if (damage > 0) then
        hskill.damage({
            sourceUnit = sourceUnit,
            targetUnit = u,
            damage = damage,
            damageString = "缴械",
            damageSrc = options.damageSrc,
        })
    end
    htime.setTimeout(during, function(t)
        t.destroy()
        hcache.set(u, CONST_CACHE.SKILL_UN_ARM_LEVEL, hcache.get(u, CONST_CACHE.SKILL_UN_ARM_LEVEL, 0) - 1)
        if (hcache.get(u, CONST_CACHE.SKILL_UN_ARM_LEVEL, 0) <= 0) then
            heffect.destroy(hcache.get(u, CONST_CACHE.SKILL_UN_ARM_EFFECT))
            hcache.set(u, CONST_CACHE.SKILL_UN_ARM, false)
        end
    end)
end

SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "毁灭") then
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local i = 0
            htime.setInterval(0.5, function(curTimer)
                i = i + 1
                if (i > 5) then
                    curTimer.destroy()
                    return
                end
                for n = 1, 10 do
                    local px, py = math.polarProjection(x, y, i * 200, 36 * n)
                    heffect.xyz("Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl", px, py, 0, 0)
                    local g = hgroup.createByXY(px, py, 150, function(filterUnit)
                        return his.enemy(u, filterUnit) and his.alive(filterUnit)
                    end)
                    hgroup.forEach(g, function(enumUnit, _)
                        crackFly({
                            damage = 100, --伤害（必须有，但是这里可以等于0）
                            targetUnit = enumUnit, --目标单位（必须有）
                            sourceUnit = u, --伤害来源单位（可选）
                            odds = 100, --几率（可选,默认100）
                            distance = 0, --击退距离，可选，默认0
                            height = 200, --击飞高度，可选，默认100
                            during = 0.5, --击飞过程持续时间，可选，默认0.5秒
                        })
                    end)
                end
            end)
        end
    end)
end