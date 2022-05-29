--- 击飞
--[[
    options = {
        sourceUnit 伤害来源
        targetUnit 目标单位
        flyModel = nil, --[可选]飞行单位origin特效
        animate = "attack", --动作
        animateScale = 1.00, --动画速度
        distance 击退距离，可选，默认0
        height 击飞高度，可选，默认100
        duration 击飞过程持续时间，可选，默认0.5秒
        onMove = [function], --每周期移动回调,return false时可强行中止循环
        onEnd = [function], --结束回调
    }
]]
---@alias abilityCrackFlyCallback fun(sourceUnit:userdata,targetUnit:userdata,x:number,y:number)
---@param options {sourceUnit:userdata,targetUnit:userdata,flyModel:string,animate:number,animateScale:number,distance:number,height:number,duration:number,onMove:abilityCrackFlyCallback,onEnd:abilityCrackFlyCallback}
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
    --不二次击飞
    if (hcache.get(targetUnit, "SKILL_CRACK_FLY", false) == true) then
        return
    end
    hcache.set(targetUnit, "SKILL_CRACK_FLY", true)
    --
    local frequency = 0.02
    local speed = frequency / duration
    local facOri
    if (sourceUnit ~= nil) then
        facOri = math.angle(hunit.x(targetUnit), hunit.y(targetUnit), hunit.x(sourceUnit), hunit.y(sourceUnit))
    else
        facOri = hunit.getFacing(targetUnit)
    end
    local targetX, targetY
    if (distance > 0) then
        targetX, targetY = math.polarProjection(hunit.x(targetUnit), hunit.y(targetUnit), distance, facOri)
    end
    local eff
    if (options.flyModel) then
        eff = heffect.attach(options.flyModel, targetUnit, "origin", -1)
    end
    if (options.animate) then
        hunit.animate(targetUnit, options.animate)
    end
    if (type(options.animateScale) == "number" and options.animateScale ~= 1) then
        hunit.setAnimateSpeed(targetUnit, options.animateScale, duration)
    end
    local d0 = hunit.getFlyHeight(targetUnit)
    local ending = function(endX, endY, isFinish)
        if (eff ~= nil) then
            heffect.destroy(eff)
        end
        if (height > 0) then
            hunit.setFlyHeight(targetUnit, d0, 9999)
            cj.SetUnitPathing(targetUnit, true)
        end
        hcache.set(targetUnit, "SKILL_CRACK_FLY", false)
        local res = isFinish
        if (res == true and type(options.onEnd) == "function") then
            res = options.onEnd(sourceUnit, targetUnit, endX, endY)
        end
    end
    local dh = d0
    local limit = 0
    local tc = 0
    local ax = hunit.x(targetUnit)
    local ay = hunit.y(targetUnit)
    if (height > 0) then
        hunit.setCanFly(targetUnit)
    end
    cj.SetUnitPathing(targetUnit, false)
    htime.setInterval(frequency, function(curTimer)
        if (hunit.isDead(targetUnit)) then
            curTimer.destroy()
            ending(ax, ay, false)
            return
        end
        if (distance > 0) then
            local fac = math.angle(targetX, targetY, ax, ay)
            local nx, ny = math.polarProjection(ax, ay, speed * distance, fac)
            if (hrect.isBorderCamera(nx, ny)) then
                nx = ax
                ny = ay
            end
            ax = nx
            ay = ny
        end
        hunit.portal(targetUnit, ax, ay)
        if (type(options.onMove) == "function") then
            local mRes = options.onMove(sourceUnit, targetUnit, ax, ay)
            if (mRes == false) then
                curTimer.destroy()
                ending(ax, ay, false)
                return
            end
        end
        if (height > 0) then
            local gravity = 7.4 * height * speed * math.abs(0.5 - (tc / duration))
            if (tc <= duration / 2) then
                dh = dh + gravity
            else
                dh = dh - gravity
            end
            hunit.setFlyHeight(targetUnit, math.max(dh, d0), 9999)
        end
        limit = limit + 1
        if (limit > 400 or hunit.isDestroyed(targetUnit)) then
            -- 超时消失
            curTimer.destroy()
            ending(ax, ay, false)
            return
        end
        tc = tc + frequency
        if (tc >= duration) then
            curTimer.destroy()
            ending(ax, ay, true)
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
            htime.setInterval(0.3, function(curTimer)
                i = i + 1
                if (i > 5) then
                    curTimer.destroy()
                    return
                end
                for n = 1, 10 do
                    local px, py = math.polarProjection(x, y, i * 200, 36 * n)
                    heffect.xyz("Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl", px, py, 0, 0)
                    local g = hgroup.createByXY(px, py, 150, function(filterUnit)
                        return hunit.isEnemy(u, filterUnit) and hunit.isAlive(filterUnit)
                    end)
                    hgroup.forEach(g, function(enumUnit, _)
                        crackFly({
                            flyModel = "Abilities\\Weapons\\DemonHunterMissile\\DemonHunterMissile.mdl",
                            sourceUnit = u, --伤害来源单位（可选）
                            targetUnit = enumUnit, --目标单位（必须有）
                            distance = math.random(0, 300), --击退距离，可选，默认0
                            height = math.random(100, 1000), --击飞高度，可选，默认100
                            duration = math.random(0.5, 3.5), --击飞过程持续时间，可选，默认0.5秒
                            onEnd = function(sourceUnit, targetUnit, nx, ny)
                                hskill.damage({
                                    sourceUnit = sourceUnit,
                                    targetUnit = targetUnit,
                                    damage = 100,
                                    damageSrc = CONST_DAMAGE_SRC.skill,
                                })
                            end,
                        })
                    end)
                end
            end)
        end
    end)
end