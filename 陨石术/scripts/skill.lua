--[[
    虚拟箭矢
    model = nil, --[必须]虚拟箭矢的特效
    animateScale = 1.00, --虚拟箭矢的动画速度
    scale = 1.00, --虚拟箭矢的模型缩放
    hover = 0.00, --虚拟箭矢的初始离基点高度
    speed = 500, --每秒冲击的距离（可选的，默认1秒500px)
    acceleration = 0, --冲击加速度（可选的，每个周期[0.02秒]都会增加一次)
    height = 0, --飞跃高度（可选的，默认0)
    shake = 0, --摇摆振幅程度度[0.00~1.00|rand]（可选的，默认0)
    sourceUnit, --[必须]伤害来源
    targetUnit, --[可选]目标单位（有单位目标，那么冲击跟踪到单位就结束）
    targetX, --[可选]冲击的目标x坐标（对点冲击）比targetUnit优先级高
    targetY, --[可选]冲击的目标y坐标
    startX = [sourceUnit.x], --强制设定初始创建的x坐标（可选的，同时设定 startY 时才有效）
    startY = [sourceUnit.y], --强制设定初始创建的y坐标（可选的，同时设定 startX 时才有效）
    onMove = [function], --每周期移动回调,return false时可强行中止循环
    onEnd = [function], --结束回调
]]
---@alias noteAbilityMissileOnEvt fun(source:userdata,target:userdata,endX:number,endY:number):nil|boolean
---@alias noteAbilityMissileOptions {model:string,animateScale:number,scale:number,hover:number,speed:number,acceleration:number,height:number,shake:number,sourceUnit:userdata,targetUnit:userdata,targetX:number,targetY:number,startX:number,startY:number,onMove:noteAbilityMissileOnEvt,onEnd:noteAbilityMissileOnEvt}
---@param options noteAbilityMissileOptions
function missile(options)
    if (options.model == nil) then
        return err("model")
    end
    local sourceUnit = options.sourceUnit
    local targetUnit = options.targetUnit
    if (sourceUnit == nil) then
        return err("sourceUnit")
    end
    if (options.targetX == nil or options.targetY == nil) then
        if (targetUnit == nil) then
            return err("targetUnit")
        end
    end
    local frequency = 0.02
    local speed = math.min(10000, math.max(50, options.speed or 500))
    local acceleration = options.acceleration or 0
    local height = options.height or 0
    local hover = options.hover or 0
    options.animateScale = options.animateScale or 1.00
    options.scale = options.scale or 1.00
    local fac0 = 0
    local dct0 = 0
    local sourceH = hover
    local targetH = 0
    if (options.startX == nil or options.startY == nil) then
        options.startX, options.startY = math.polarProjection(hunit.x(sourceUnit), hunit.y(sourceUnit), 30, fac0)
        sourceH = sourceH + hunit.h(sourceUnit)
    end
    if (options.targetX ~= nil and options.targetY ~= nil) then
        targetH = hover + hjapi.Z(options.targetX, options.targetY)
        fac0 = math.angle(hunit.x(sourceUnit), hunit.y(sourceUnit), options.targetX, options.targetY)
        dct0 = math.distance(hunit.x(sourceUnit), hunit.y(sourceUnit), options.targetX, options.targetY)
    else
        targetH = hover + hunit.h(targetUnit)
        fac0 = math.angle(hunit.x(sourceUnit), hunit.y(sourceUnit), hunit.x(targetUnit), hunit.y(targetUnit))
        dct0 = math.distance(hunit.x(sourceUnit), hunit.y(sourceUnit), hunit.x(targetUnit), hunit.y(targetUnit))
    end
    if (dct0 < 300) then
        height = dct0 / 2
    end
    local arrowToken = cj.AddSpecialEffect(options.model, options.startX, options.startY)
    hjapi.EXEffectMatRotateZ(arrowToken, fac0)
    hjapi.EXSetEffectSpeed(arrowToken, options.animateScale)
    hjapi.EXSetEffectSize(arrowToken, options.scale)
    local gsep = (dct0 / 2) / speed / frequency
    local topH
    local rotateY1 = 0
    local rotateY2 = 0
    local rotateY1i = 0
    local rotateY2i = 0
    local gravity1 = 0
    local gravity2 = 0
    local sd = (dct0 / speed / frequency / 2)
    local hd = (sourceH - targetH) / 2
    if (sourceH >= targetH) then
        topH = sourceH + height
        rotateY1 = math_rad2deg * math.atan(height, dct0 / 2)
        rotateY1i = rotateY1 / sd
        rotateY2 = math_rad2deg * math.atan(topH, dct0 / 2)
        rotateY2i = rotateY2 / sd
        gravity1 = (height + hd) / gsep
        gravity2 = (topH - hd) / gsep
    else
        topH = targetH + height
        rotateY1 = math_rad2deg * math.atan(topH, dct0 / 2)
        rotateY1i = rotateY1 / sd
        rotateY2 = math_rad2deg * math.atan(height, dct0 / 2)
        rotateY2i = rotateY2 / sd
        gravity1 = (topH + hd) / gsep
        gravity2 = (height + hd) / gsep
    end

    local rotateY = -rotateY1
    if (fac0 > 90 and fac0 < 270) then
        rotateY = -rotateY
    end
    speed = frequency * speed
    hjapi.EXEffectMatRotateY(arrowToken, rotateY)
    hjapi.EXSetEffectZ(arrowToken, sourceH)
    local ending = function(endX, endY, isFinish)
        if (arrowToken ~= nil) then
            cj.DestroyEffect(arrowToken)
            arrowToken = nil
        end
        local res = isFinish
        if (res == true and type(options.onEnd) == "function") then
            res = options.onEnd(sourceUnit, targetUnit, endX, endY)
        end
    end
    local curH = sourceH
    local limit = 0
    local faraway = 0
    local prevDist
    local ax = hjapi.EXGetEffectX(arrowToken)
    local ay = hjapi.EXGetEffectY(arrowToken)
    local shake = options.shake
    local shakeDirect = 1
    if (shake == "rand") then
        shake = 0.01 * math.random(-100, 100)
    elseif (type(shake) == "number") then
        shake = math.min(1, math.max(0, shake))
    else
        shake = 0
    end
    if (math.random(1, 2) == 1) then
        shakeDirect = -1
    end
    htime.setInterval(frequency, function(curTimer)
        if (arrowToken == nil or hunit.isDestroyed(sourceUnit) or (targetUnit ~= nil and hunit.isDestroyed(targetUnit))) then
            curTimer.destroy()
            ending(ax, ay, false)
            return
        end
        local tx = 0
        local ty = 0
        local dct = 0
        if (options.targetX ~= nil and options.targetY ~= nil) then
            tx = options.targetX
            ty = options.targetY
            dct = dct0
        else
            tx = hunit.x(targetUnit)
            ty = hunit.y(targetUnit)
            dct = math.distance(options.startX, options.startY, hunit.x(targetUnit), hunit.y(targetUnit))
        end
        local fac
        if (shake ~= nil and shake ~= 0) then
            fac = math.angle(ax, ay, tx, ty) + shake * 75 * shakeDirect * math.distance(ax, ay, tx, ty) / dct
        else
            fac = math.angle(ax, ay, tx, ty)
        end
        local nx, ny = math.polarProjection(ax, ay, speed, fac)
        if (acceleration ~= 0) then
            speed = speed + acceleration
        end
        if (hrect.isBorderCamera(nx, ny)) then
            curTimer.destroy()
            ending(ax, ay, false)
            return
        end
        if (type(options.onMove) == "function") then
            local mRes = options.onMove(sourceUnit, targetUnit, nx, ny)
            if (mRes == false) then
                curTimer.destroy()
                ending(ax, ay, false)
                return
            end
        end
        hjapi.EXSetEffectXY(arrowToken, nx, ny)
        hjapi.EXEffectMatRotateZ(arrowToken, fac - fac0)
        ax = nx
        ay = ny
        fac0 = fac
        local curD = math.distance(ax, ay, tx, ty)
        if (curD < dct) then
            local halfD = dct / 2
            local rot = 0
            local di = 2 * (math.disparity(curD, halfD) / halfD)
            local dg = di * (dct0 / dct)
            if (curD >= halfD) then
                curH = curH + gravity1 * dg
                rot = rotateY1i * (2 - di)
            else
                curH = curH - gravity2 * dg
                rot = rotateY2i * (2 - di)
            end
            if (fac0 > 90 and fac0 < 270) then
                rot = -rot
            end
            hjapi.EXSetEffectZ(arrowToken, curH)
        end
        limit = limit + 1
        if (limit > 400 or sourceUnit == nil) then
            -- 超时消失
            curTimer.destroy()
            ending(nx, ny, false)
            return
        else
            -- 逃离消失
            if (prevDist ~= nil) then
                if (prevDist < curD) then
                    faraway = faraway + 1
                    if (faraway > 50 or (curD - prevDist > speed * 10)) then
                        curTimer.destroy()
                        ending(nx, ny, false)
                        return
                    end
                else
                    faraway = 0
                end
            end
            prevDist = curD
        end
        if (curD <= speed or speed <= 0) then
            curTimer.destroy()
            ending(nx, ny, true)
        end
    end)
end

SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "陨石术") then
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local ang = hunit.getFacing(u)
            hjapi.EXEffectMatRotateZ(heffect.xyz("war3mapImported\\MeteoriteFalling.mdx", evtData.targetX, evtData.targetY, 0, 1.5), ang)
            --延迟1.5秒伤害并滚动
            htime.setTimeout(1.5, function(curTimer)
                curTimer.destroy()
                local g = hgroup.createByXY(x, y, 600, function(filterUnit)
                    return hunit.isEnemy(u, filterUnit) and hunit.isAlive(filterUnit)
                end)
                hgroup.forEach(g, function(enumUnit, _)
                    hskill.damage({
                        sourceUnit = u, --伤害来源(可选)
                        targetUnit = enumUnit, --目标单位
                        damage = hattr.get(u, "str") * 10, --实际伤害
                        damageSrc = CONST_DAMAGE_SRC.skill,
                    })
                end)
                --滚动
                local px, py = math.polarProjection(evtData.targetX, evtData.targetY, 1000, ang)
                local onlyOne = {}
                missile({
                    model = "war3mapImported\\MeteoriteRolling.mdx",
                    scale = 1,
                    hover = 0,
                    speed = 500,
                    sourceUnit = u,
                    targetX = px,
                    targetY = py,
                    startX = evtData.targetX, --强制设定初始创建的x坐标（可选的，同时设定 startY 时才有效）
                    startY = evtData.targetY, --强制设定初始创建的y坐标（可选的，同时设定 startX 时才有效）
                    onMove = function(unit, _, mx, my)
                        local mg = hgroup.createByXY(mx, my, 300, function(filterUnit)
                            return hunit.isEnemy(unit, filterUnit) and hunit.isAlive(filterUnit)
                        end)
                        hgroup.forEach(mg, function(enumUnit, _)
                            --不重复伤害
                            if (onlyOne[enumUnit] == nil) then
                                onlyOne[enumUnit] = 1
                                hskill.damage({
                                    sourceUnit = unit, --伤害来源(可选)
                                    targetUnit = enumUnit, --目标单位
                                    damage = hattr.get(unit, "str") * 10, --实际伤害
                                    damageSrc = CONST_DAMAGE_SRC.skill,
                                })
                            end
                        end)
                        mg = nil
                        return true
                    end
                })
            end)
        end
    end)
end