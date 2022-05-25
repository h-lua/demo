---@private
local function _missileEnding(isok, arrowToken, options, point)
    if (arrowToken ~= nil) then
        cj.DestroyEffect(arrowToken)
        arrowToken = nil
    end
    local res = isok
    if (res == true and type(options.onEnd) == "function") then
        res = options.onEnd(options.sourceUnit, options.targetUnit, point[1], point[2], point[3])
    end
    if (res == true and options.reflex > 0) then
        if (options.targetUnit ~= nil) then
            local g = hgroup.createByXY(point[1], point[2], 600, function(enumUnit)
                return false == his.unit(options.targetUnit, enumUnit) and his.enemy(options.sourceUnit, enumUnit) and his.alive(enumUnit)
            end)
            local nextUnit = table.random(g, 1)
            if (nextUnit) then
                missile({
                    model = options.model,
                    scale = options.scale,
                    sourceUnit = options.sourceUnit,
                    speed = options.speed,
                    height = options.height * 0.9,
                    acceleration = options.acceleration,
                    shake = options.shake,
                    shakeOffset = options.shakeOffset,
                    reflex = options.reflex - 1,
                    onEnd = options.onEnd,
                    sourcePoint = point,
                    targetUnit = nextUnit,
                })
            end
        end
    end
end

--[[
    虚拟箭矢
    model = nil, --[必须]虚拟箭矢的特效
    animateScale = 1.00, --[可选]虚拟箭矢的动画速度，默认1
    scale = 1.00, --[可选]虚拟箭矢的模型缩放，默认1
    speed = 500, --[可选]每秒冲击的距离，默认1秒500px
    acceleration = 0, --[可选]冲击加速度，每个周期[0.02秒]都会增加一次
    height = 0, --[可选]飞跃高度，默认0
    shake = 0, --[可选]摇摆角度[number|'rand']默认0
    sourceUnit, --[必须]伤害来源
    targetUnit, --[可选]目标单位（有单位目标，那么冲击跟踪到单位就结束）
    sourcePoint = number[3][可选]强制设定初始坐标
    targetPoint = number[3][可选]强制设定目标坐标
    onMove = noteAbilityMissileOnEvt, --[可选]每周期回调,当return false时可强行中止循环
    onEnd = noteAbilityMissileOnEvt, --[可选]结束回调
]]
---@alias noteAbilityMissileOnEvt fun(source:userdata,target:userdata,x:number,y:number,z:number):nil|boolean
---@alias noteAbilityMissileOptions {model:string,animateScale:number,scale:number,speed:number,acceleration:number,height:number,shake:number,sourceUnit:userdata,targetUnit:userdata,sourcePoint:number[],targetPoint:number[],onMove:noteAbilityMissileOnEvt,onEnd:noteAbilityMissileOnEvt}
---@param options noteAbilityMissileOptions
function missile(options)
    local sourceUnit = options.sourceUnit
    local targetUnit = options.targetUnit
    local frequency = 0.02
    options.animateScale = options.animateScale or 1
    options.scale = options.scale or 1
    local speed = math.min(5000, math.max(100, options.speed or 500))
    local acceleration = options.acceleration or 0

    ---@type number[]
    local sPoint = options.sourcePoint
    ---@type number[]
    local tPoint
    if (type(options.targetPoint) == "table") then
        tPoint = { options.targetPoint[1], options.targetPoint[2], options.targetPoint[3] }
    else
        tPoint = { hunit.x(targetUnit), hunit.y(targetUnit), hunit.h(targetUnit) }
    end
    local fac0 = math.angle(hunit.x(sourceUnit), hunit.y(sourceUnit), tPoint[1], tPoint[2])
    if (sPoint == nil) then
        local sx, sy = math.polarProjection(hunit.x(sourceUnit), hunit.y(sourceUnit), 30, fac0)
        sPoint = { sx, sy, hunit.h(sourceUnit) }
    end

    local distance0 = math.distance(sPoint[1], sPoint[2], tPoint[1], tPoint[2])
    local dtStep = distance0 / speed / frequency
    local dtSpd = 1 / dtStep
    local dtAcl = 0
    if ((options.acceleration or 0) > 0) then
        dtAcl = 1 / (distance0 / acceleration / frequency)
    end

    local rotateY0 = 0
    local height
    if (sPoint[3] >= tPoint[3]) then
        height = sPoint[3] + options.height
        rotateY0 = -math_rad2deg * math.atan(height, distance0 / 2)
    else
        height = tPoint[3] + options.height / 2
        rotateY0 = -math_rad2deg * math.atan(height, distance0 / 2)
    end
    if (fac0 > 90 and fac0 < 270) then
        rotateY0 = -rotateY0
    end
    local dtRot = 2.2 * rotateY0 / dtStep

    local hh = height * 0.6
    if (distance0 < hh) then
        height = height * (distance0 / hh)
    end
    height = height + math.random(-15, 15)

    local shake = options.shake
    local mh
    if (shake == "rand") then
        shake = math.random(0, 359)
    elseif (type(shake) == "number") then
        shake = math.ceil(shake) % 360
    else
        shake = 0
    end
    if (shake < 180) then
        mh = distance0 / 2
    else
        mh = distance0 / 1.5
    end

    local mx, my = math.polarProjection(sPoint[1], sPoint[2], mh, fac0 + shake)
    local mPoint = { mx, my, 1.5 * height }

    local arrowToken = cj.AddSpecialEffect(options.model, sPoint[1], sPoint[2])
    hjapi.EXSetEffectZ(arrowToken, sPoint[3])
    hjapi.EXSetEffectSpeed(arrowToken, options.animateScale)
    hjapi.EXSetEffectSize(arrowToken, options.scale)
    hjapi.EXEffectMatRotateZ(arrowToken, fac0)
    hjapi.EXEffectMatRotateY(arrowToken, rotateY0)
    local dt = 0
    local distanceCur = distance0
    local distancePrev
    local collision = 50
    local faraway = frequency * speed * 30
    local cPoint = { sPoint[1], sPoint[2], sPoint[3] }
    local fac = fac0
    htime.setInterval(frequency, function(curTimer)
        if (arrowToken == nil or his.unitDestroyed(sourceUnit) or (targetUnit ~= nil and his.unitDestroyed(targetUnit))) then
            curTimer.destroy()
            _missileEnding(false, arrowToken, options, cPoint)
            return
        end
        local di = 1
        if (type(options.targetPoint) ~= "table") then
            tPoint = { hunit.x(targetUnit), hunit.y(targetUnit), hunit.h(targetUnit) }
            di = distance0 / distanceCur
        end
        di = math.min(1, di)
        dt = dt + dtSpd * di
        if (dtAcl ~= 0) then
            dtSpd = dtSpd + dtAcl
        end

        local nPoint = {
            sPoint[1] + 2 * (mPoint[1] - sPoint[1]) * dt + (tPoint[1] - 2 * mPoint[1] + sPoint[1]) * dt ^ 2,
            sPoint[2] + 2 * (mPoint[2] - sPoint[2]) * dt + (tPoint[2] - 2 * mPoint[2] + sPoint[2]) * dt ^ 2,
            sPoint[3] + 2 * (mPoint[3] - sPoint[3]) * dt + (tPoint[3] - 2 * mPoint[3] + sPoint[3]) * dt ^ 2,
        }
        if (his.borderCamera(nPoint[1], nPoint[2])) then
            curTimer.destroy()
            _missileEnding(false, arrowToken, options, cPoint)
            return
        end
        cPoint = nPoint
        if (type(options.onMove) == "function") then
            local mRes = options.onMove(sourceUnit, targetUnit, cPoint[1], cPoint[2], cPoint[3])
            if (mRes == false) then
                curTimer.destroy()
                _missileEnding(false, arrowToken, options, cPoint)
                return
            end
        end
        fac = math.angle(cPoint[1], cPoint[2], tPoint[1], tPoint[2])
        distanceCur = math.distance(cPoint[1], cPoint[2], tPoint[1], tPoint[2])
        hjapi.EXSetEffectXY(arrowToken, cPoint[1], cPoint[2])
        hjapi.EXSetEffectZ(arrowToken, cPoint[3])
        hjapi.EXEffectMatRotateZ(arrowToken, fac - fac0)
        fac0 = fac
        hjapi.EXEffectMatRotateY(arrowToken, -dtRot * di)
        if (distanceCur > collision and distancePrev ~= nil) then
            if ((distanceCur - distancePrev) > faraway) then
                curTimer.destroy()
                _missileEnding(false, arrowToken, options, cPoint)
                return
            end
        end
        distancePrev = distanceCur
        if (dt >= 1 or distanceCur <= collision) then
            curTimer.destroy()
            _missileEnding(true, arrowToken, options, tPoint)
        end
    end)
end

SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "精灵球星爆") then
            local u = evtData.triggerUnit
            local x = hunit.x(evtData.targetUnit)
            local y = hunit.y(evtData.targetUnit)
            for i = 1, 50 do
                local px, py = math.polarProjection(x, y, 300, i * 360 / 5)
                missile({
                    model = "Abilities\\Weapons\\FaerieDragonMissile\\FaerieDragonMissile.mdl",
                    scale = 1,
                    height = math.random(1000, 1500),
                    speed = 666,
                    shake = "rand",
                    reflex = 3,
                    sourceUnit = u,
                    targetUnit = evtData.targetUnit,
                    sourcePoint = { px, py, hjapi.Z(px, py) },
                    onEnd = function(source, target, _, _)
                        hskill.damage({
                            sourceUnit = source, --伤害来源(可选)
                            targetUnit = target, --目标单位
                            damage = hattr.get(source, "str") * 10, --实际伤害
                            damageSrc = CONST_DAMAGE_SRC.skill,
                        })
                        return true
                    end
                })
            end
        end
    end)
end