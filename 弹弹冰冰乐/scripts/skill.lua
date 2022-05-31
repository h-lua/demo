---@private
local function _crackFlyEnding(isOK, options, point)
    if (options.effectAttach) then
        heffect.destroy(options.effectAttach)
    end
    local f0 = hcache.get(options.targetUnit, "crackFlyHeight0")
    hunit.setFlyHeight(options.targetUnit, f0, 1e4)
    cj.SetUnitPathing(options.targetUnit, true)
    local res = isOK
    if (res == true and type(options.onEnd) == "function") then
        res = options.onEnd(options.sourceUnit, options.targetUnit, point)
    end
    hcache.set(options.targetUnit, "crackFlying", false)
    if (res == true and type(options.bounce) == "table") then
        local qty = options.bounce.qty or 0
        if (qty > 0) then
            local di = options.bounce.distance or 0.8
            local he = options.bounce.height or 0.8
            local du = options.bounce.duration or 0.8
            if (options.targetUnit ~= nil and hunit.isDestroyed(options.targetUnit) == false) then
                crackFly({
                    sourceUnit = options.sourceUnit,
                    targetUnit = options.targetUnit,
                    model = options.model,
                    animate = options.animate,
                    animateScale = options.animateScale,
                    distance = options.distance * di,
                    height = options.height * he,
                    duration = options.duration * du,
                    bounce = { qty = qty - 1, distance = di, height = he, duration = du },
                    onMove = options.onMove,
                    onEnd = options.onEnd,
                })
            end
        end
    end
end

--[[
    击飞
    sourceUnit = userdata, --[可选]伤害来源
    targetUnit = userdata, --[必须]目标单位
    model = nil, --[可选]目标单位飞行origin特效
    animate = "dead", --[可选]目标单位飞行动作或序号,默认无
    animateScale = 1.00, --[可选]目标单位飞行动画速度，默认1
    distance = 0, --[可选]击退距离，默认0
    height = 100, --[可选]飞跃高度，默认100
    duration = 0.5, --[必须]击飞过程持续时间，可选，默认0.5秒
    bounce = noteAbilityCrackFlyBounceParam, --[可选]弹跳参数，noteAbilityCrackFlyBounceParam
    onMove = noteAbilityCrackFlyOnEvt, --[可选]每周期回调,当return false时可强行中止循环
    onEnd = noteAbilityCrackFlyOnEvt, --[可选]结束回调,当return true时才会执行reflex
]]
---@alias noteAbilityCrackFlyBounceParam {qty:0, distance:0.8, height:0.8, duration:0.8} qty弹跳次数，后面三个为相对前1次的相乘变化率，默认0.8
---@alias noteAbilityCrackFlyOnEvt fun(sourceUnit:userdata,targetUnit:userdata,point:number[]):boolean
---@param options {sourceUnit:userdata,targetUnit:userdata,model:string,animate:number,animateScale:number,distance:number,height:number,bounce:noteAbilityCrackFlyBounceParam,duration:number,onMove:noteAbilityCrackFlyOnEvt,onEnd:noteAbilityCrackFlyOnEvt}
function crackFly(options)
    local sourceUnit = options.sourceUnit
    local targetUnit = options.targetUnit
    if (targetUnit == nil or hunit.isDead(targetUnit)) then
        return
    end
    local distance = math.max(0, options.distance or 0)
    local height = options.height or 100
    local duration = options.duration or 0.5
    if (height <= 0 or duration < 0.1) then
        return
    end
    local ing = hcache.get(targetUnit, "crackFlying", false)
    if (ing == true) then
        return
    end
    hcache.set(targetUnit, "crackFlying", true)
    hcache.set(targetUnit, "crackFlyHeight0", hunit.getFlyHeight(targetUnit))

    local frequency = 0.02
    if (options.animate) then
        hunit.animate(targetUnit, options.animate)
    end

    if (options.model) then
        options.effectAttach = heffect.attach(options.model, targetUnit, "origin", -1)
    end

    local fac0 = 0
    if (sourceUnit) then
        fac0 = math.angle(hunit.x(sourceUnit), hunit.y(sourceUnit), hunit.x(targetUnit), hunit.y(targetUnit))
    else
        fac0 = hunit.getFacing(targetUnit) - 180
    end
    local sPoint = { hunit.x(targetUnit), hunit.y(targetUnit), hunit.h(targetUnit) }
    local tx, ty = math.polarProjection(hunit.x(targetUnit), hunit.y(targetUnit), distance, fac0)
    local tPoint = { tx, ty, hunit.h(targetUnit) }

    local dtSpd = 1 / (duration / frequency)

    local mmid = math.distance(sPoint[1], sPoint[2], tPoint[1], tPoint[2])
    local mx, my = math.polarProjection(sPoint[1], sPoint[2], mmid, fac0)
    local mPoint = { mx, my, 1.5 * height }

    cj.SetUnitPathing(targetUnit, false)
    hunit.setCanFly(targetUnit)
    local dt = 0
    local cPoint
    htime.setInterval(frequency, function(curTimer)
        if (hunit.isDead(targetUnit)) then
            curTimer.destroy()
            _crackFlyEnding(false, options, cPoint or sPoint)
            return
        end
        dt = dt + dtSpd

        local nPoint = {
            sPoint[1] + 2 * (mPoint[1] - sPoint[1]) * dt + (tPoint[1] - 2 * mPoint[1] + sPoint[1]) * dt ^ 2,
            sPoint[2] + 2 * (mPoint[2] - sPoint[2]) * dt + (tPoint[2] - 2 * mPoint[2] + sPoint[2]) * dt ^ 2,
            sPoint[3] + 2 * (mPoint[3] - sPoint[3]) * dt + (tPoint[3] - 2 * mPoint[3] + sPoint[3]) * dt ^ 2,
        }
        if (hrect.isBorderPlayable(nPoint[1], nPoint[2])) then
            curTimer.destroy()
            _crackFlyEnding(false, options, cPoint)
            return
        end
        if (type(options.onMove) == "function") then
            local mRes = options.onMove(sourceUnit, targetUnit, nPoint or sPoint)
            if (mRes == false) then
                destroy(curTimer)
                _crackFlyEnding(false, options, cPoint)
                return
            end
        end
        cPoint = nPoint
        cj.SetUnitX(targetUnit, cPoint[1])
        cj.SetUnitY(targetUnit, cPoint[2])
        hunit.setFlyHeight(targetUnit, cPoint[3], 1e4)
        if (dt >= 1) then
            curTimer.destroy()
            _crackFlyEnding(true, options, tPoint)
        end
    end)
end

SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "弹弹冰冰乐") then
            local jump
            jump = function(targetUnit, count)
                crackFly({
                    model = "Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl",
                    sourceUnit = evtData.triggerUnit,
                    targetUnit = targetUnit,
                    height = 500,
                    distance = math.random(150, 250),
                    duration = 1.0,
                    bounce = { qty = 2, distance = 0.7, height = 0.7, duration = 0.7 },
                    onEnd = function(source, target, point)
                        heffect.xyz("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", point[1], point[2], point[3], 0)
                        hskill.damage({
                            sourceUnit = source, --伤害来源(可选)
                            targetUnit = target, --目标单位
                            damage = 10,
                            damageSrc = CONST_DAMAGE_SRC.skill,
                        })
                        if (count < 2) then
                            local g = hgroup.createByXY(point[1], point[2], 128, function(filterUnit)
                                return hunit.isAlive(filterUnit) and hcache.get(filterUnit, "crackFlying", false) == false and hunit.isEnemy(source, filterUnit)
                            end)
                            if (#g > 0) then
                                for _, u in ipairs(g) do
                                    jump(u, count + 1)
                                end
                            end
                        end
                        return true
                    end
                })
            end
            jump(evtData.targetUnit, 0)
        end
    end)
end