--[[
    剃(前冲型直线攻击)
    options = {
        arrowUnit = nil, -- 前冲的单位（有就是自身冲击，没有就是马甲特效冲击）
        sourceUnit, --伤害来源（必须有！不管有没有伤害）
        targetUnit, --冲击的目标单位（可选的，有单位目标，那么冲击到单位就结束）
        x, --冲击的x坐标（可选的，对点冲击，与某目标无关）
        y, --冲击的y坐标（可选的，对点冲击，与某目标无关）
        speed = 10, --冲击的速度（可选的，默认10，0.02秒的移动距离,大概1秒500px)
        acceleration = 0, --冲击加速度（可选的，每个周期都会增加0.02秒一次)
        height = 0, --飞跃高度（可选的，默认0)
        shake = 0, --摇摆振幅角度[-90~+90|random]（可选的，默认0)
        filter = [function], --必须有
        tokenX, --强制设定token初始创建的x坐标（可选的，同时设定tokenY时才有效）
        tokenY, --强制设定token初始创建的y坐标（可选的，同时设定tokenX时才有效）
        tokenArrow = nil, --前冲的特效（arrowUnit=nil时认为必须！自身冲击就是bind，否则为马甲本身，如冲击波的波）
        tokenArrowScale = 1.00, --前冲的特效作为马甲冲击时的模型缩放
        tokenArrowOpacity = 1.00, --前冲的特效作为马甲冲击时的模型透明度[0-1]
        tokenArrowHeight = 0.00, --前冲的特效作为马甲冲击时的初始离地高度
        effectMovement = nil, --移动过程，每个间距的特效（可选的，采用的0秒删除法，请使用explode类型的特效）
        effectEnd = nil, --到达最后位置时的特效（可选的，采用的0秒删除法，请使用explode类型的特效）
        damageMovement = 0, --移动过程中的伤害（可选的，默认为0）
        damageMovementRadius = 0, --移动过程中的伤害（可选的，默认为0，易知0范围是无效的所以有伤害也无法体现）
        damageMovementRepeat = false, --移动过程中伤害是否可以重复造成（可选的，默认为不能）
        damageMovementDrag = false, --移动过程是否拖拽敌人（可选的，默认为不能）
        damageEnd = 0, --移动结束时对目标的伤害（可选的，默认为0）
        damageEndRadius = 0, --移动结束时对目标的伤害范围（可选的，默认为0，此处0范围是有效的，会只对targetUnit生效，除非unit不存在）
        damageSrc = CONST_DAMAGE_SRC, --伤害的种类（可选）
        damageEffect = nil, --伤害特效（可选）
        oneHitOnly = false, --是否打击一次就立刻失效（类似格挡，这个一次和只攻击一个单位不是一回事）
        onEnding = [function], --结束时触发的动作
        extraInfluence = [function] --对选中的敌人的额外影响，会回调该敌人单位，可以对其做出自定义行为
    }
]]
---@param options pilotLeap
leap = function(options)
    if (options.sourceUnit == nil) then
        err("leap: -sourceUnit")
        return
    end
    if (type(options.filter) ~= "function") then
        err("leap: -filter")
        return
    end
    if (options.arrowUnit == nil and options.tokenArrow == nil) then
        err("leap: -not arrow")
    end
    if (options.targetUnit == nil and options.x == nil and options.y == nil) then
        err("leap: -target")
        return
    end
    if (options.targetUnit ~= nil and his.unitDestroyed(options.targetUnit)) then
        return
    end
    local frequency = 0.02
    local acceleration = options.acceleration or 0
    local height = options.height or 0
    local shake = options.shake or 0
    if (type(shake) == 'number') then
        if (shake > 90) then
            shake = 90 -- 最大偏振角度
        elseif (shake < -90) then
            shake = -90 -- 最小偏振角度
        end
    end
    local speed = options.speed or 10
    if (speed > 150) then
        speed = 150 -- 最大速度
    elseif (speed <= 1) then
        speed = 1 -- 最小速度
    end
    local filter = options.filter
    local sourceUnit = options.sourceUnit
    local prevUnit = options.prevUnit or sourceUnit
    local damageMovement = options.damageMovement or 0
    local damageMovementRadius = options.damageMovementRadius or 0
    local damageMovementRepeat = options.damageMovementRepeat or false
    local damageMovementDrag = options.damageMovementDrag or false
    local damageEnd = options.damageEnd or 0
    local damageEndRadius = options.damageEndRadius or 0
    local extraInfluence = options.extraInfluence
    local arrowUnit = options.arrowUnit
    local tokenArrow = options.tokenArrow
    local tokenArrowScale = options.tokenArrowScale or 1.00
    local tokenArrowOpacity = options.tokenArrowOpacity or 1.00
    local tokenArrowHeight = options.tokenArrowHeight or 0
    local oneHitOnly = options.oneHitOnly or false
    local colorBuff
    local distanceOrigin
    --这里要注意：targetUnit比xy优先
    local leapType
    local initFacing = 0
    if (options.arrowUnit ~= nil) then
        leapType = "unit"
    else
        leapType = "point"
    end
    if (options.targetUnit ~= nil) then
        initFacing = math.angle(hunit.x(prevUnit), hunit.y(prevUnit), hunit.x(options.targetUnit), hunit.y(options.targetUnit))
        distanceOrigin = math.distance(hunit.x(prevUnit), hunit.y(prevUnit), hunit.x(options.targetUnit), hunit.y(options.targetUnit))
    elseif (options.x ~= nil and options.y ~= nil) then
        initFacing = math.angle(hunit.x(prevUnit), hunit.y(prevUnit), options.x, options.y)
        distanceOrigin = math.distance(hunit.x(prevUnit), hunit.y(prevUnit), options.x, options.y)
    else
        err("leapType: -unknow")
        return
    end
    local repeatGroup
    if (damageMovement > 0 and damageMovementRepeat ~= true) then
        repeatGroup = {}
    end
    if (arrowUnit == nil) then
        local cx, cy
        if (options.tokenX and options.tokenY) then
            cx, cy = options.tokenX, options.tokenY
        else
            cx, cy = math.polarProjection(hunit.x(prevUnit), hunit.y(prevUnit), 100, initFacing)
        end
        arrowUnit = hunit.create({
            register = false,
            whichPlayer = hunit.getOwner(sourceUnit),
            id = HL_ID.unit_token_leap,
            x = cx,
            y = cy,
            facing = initFacing,
            modelScale = tokenArrowScale,
            opacity = tokenArrowOpacity,
            qty = 1
        })
        if (tokenArrowHeight > 0) then
            hunit.setFlyHeight(arrowUnit, tokenArrowHeight, 9999)
        end
    end
    local heightOrigin = hunit.getFlyHeight(arrowUnit)
    cj.SetUnitFacing(arrowUnit, initFacing)
    --绑定一个无限的effect
    local tempEffectArrow
    if (tokenArrow ~= nil) then
        tempEffectArrow = heffect.attach(tokenArrow, arrowUnit, "origin", -1)
    end
    -- 无敌加无路径
    cj.SetUnitPathing(arrowUnit, false)
    if (leapType == "unit") then
        hunit.setInvulnerable(arrowUnit, true)
        colorBuff = hunit.setRGBA(arrowUnit, nil, nil, nil, tokenArrowOpacity)
    end
    -- 结束！
    local ending = function(endX, endY)
        if (tempEffectArrow ~= nil) then
            heffect.destroy(tempEffectArrow)
        end
        if (repeatGroup ~= nil) then
            repeatGroup = nil
        end
        if (tokenArrowHeight > 0) then
            hunit.setFlyHeight(arrowUnit, tokenArrowHeight, 9999)
        else
            hunit.setFlyHeight(arrowUnit, heightOrigin, 9999)
        end
        if (his.alive(arrowUnit)) then
            if (options.effectEnd ~= nil) then
                heffect.xyz(options.effectEnd, endX, endY, nil, 0)
            end
            if (damageEndRadius == 0 and options.targetUnit ~= nil) then
                if (damageEnd > 0) then
                    hskill.damage({
                        sourceUnit = options.sourceUnit,
                        targetUnit = options.targetUnit,
                        damage = damageEnd,
                        damageSrc = options.damageSrc,
                        effect = options.damageEffect
                    })
                end
                if (type(extraInfluence) == "function") then
                    extraInfluence(options.targetUnit)
                end
            elseif (damageEndRadius > 0) then
                local g = hgroup.createByUnit(arrowUnit, damageEndRadius, filter)
                hgroup.forEach(g, function(eu)
                    if (damageEnd > 0) then
                        hskill.damage({
                            sourceUnit = options.sourceUnit,
                            targetUnit = eu,
                            damage = damageEnd,
                            damageSrc = options.damageSrc,
                            effect = options.damageEffect
                        })
                    end
                    if (type(extraInfluence) == "function") then
                        extraInfluence(eu)
                    end
                end)
                g = nil
            end
        end
        if (leapType == "unit") then
            hunit.setInvulnerable(arrowUnit, false)
            cj.SetUnitPathing(arrowUnit, true)
            if (colorBuff) then
                hunit.delRGBA(arrowUnit, colorBuff)
            end
            if (his.alive(arrowUnit)) then
                hunit.portal(arrowUnit, endX, endY)
            end
        else
            hunit.kill(arrowUnit, 0)
        end
        if (type(options.onEnding) == "function") then
            options.onEnding(endX, endY)
        end
    end
    --开始冲鸭
    htime.setInterval(frequency, function(t)
        local ax = hunit.x(arrowUnit)
        local ay = hunit.y(arrowUnit)
        if (his.dead(sourceUnit)) then
            t.destroy()
            ending(ax, ay)
            return
        end
        local tx = 0
        local ty = 0
        if (options.targetUnit ~= nil) then
            tx = hunit.x(options.targetUnit)
            ty = hunit.y(options.targetUnit)
        else
            tx = options.x
            ty = options.y
        end
        local sh = 0
        if (shake ~= 0) then
            if (shake == 'random') then
                shake = math.random(-90, 90)
            end
            local d = math.distance(hunit.x(arrowUnit), hunit.y(arrowUnit), tx, ty)
            sh = shake * d / distanceOrigin
        end
        local fac = math.angle(ax, ay, tx, ty) + sh
        local px, py = math.polarProjection(ax, ay, speed, fac)
        if (acceleration ~= 0) then
            speed = speed + acceleration
        end
        if (his.borderMap(px, py) == false) then
            hunit.portal(arrowUnit, px, py)
        else
            speed = 0
        end
        cj.SetUnitFacing(arrowUnit, fac)
        if (options.effectMovement ~= nil) then
            heffect.xyz(options.effectMovement, px, py, nil, 0)
        end
        if (damageMovementRadius > 0) then
            local g = hgroup.createByUnit(
                arrowUnit,
                damageMovementRadius,
                function(filterUnit)
                    local flag = filter(filterUnit)
                    if (damageMovementRepeat ~= true and hgroup.includes(repeatGroup, filterUnit)) then
                        flag = false
                    end
                    return flag
                end
            )
            if (hgroup.count(g) > 0) then
                if (oneHitOnly == true and leapType ~= "unit") then
                    hunit.kill(arrowUnit, 0)
                end
                hgroup.forEach(g, function(eu)
                    if (damageMovementRepeat ~= true and repeatGroup ~= nil) then
                        hgroup.addUnit(repeatGroup, eu)
                    end
                    if (damageMovement > 0) then
                        hskill.damage({
                            sourceUnit = sourceUnit,
                            targetUnit = eu,
                            damage = damageMovement,
                            damageSrc = options.damageSrc,
                            effect = options.damageEffect
                        })
                    end
                    if (damageMovementDrag == true) then
                        hunit.portal(eu, px, py)
                    end
                    if (type(extraInfluence) == "function") then
                        extraInfluence(eu)
                    end
                end)
                g = nil
            end
        end
        local distance = math.distance(hunit.x(arrowUnit), hunit.y(arrowUnit), tx, ty)
        if (height > 0 and distance < distanceOrigin) then
            local ddh = 0.5 - distance / distanceOrigin
            ddh = (heightOrigin + height) * (1 - math.abs(ddh) * 2)
            hunit.setFlyHeight(arrowUnit, ddh, 9999)
        end
        if (distance <= speed or speed <= 0 or his.dead(arrowUnit) == true) then
            t.destroy()
            ending(px, py)
        end
    end)
end

SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "半成品无敌斩") then
            WUDIZHAN({
                sourceUnit = evtData.triggerUnit, --伤害来源（必须有！不管有没有伤害）
                targetUnit = evtData.targetUnit, --冲击的目标单位（必须有）
                qty = 10, --（跳跃次数，默认1）
                radius = 1000, --（选目标半径范围，默认500）
                speed = 60, --冲击的速度（可选的，默认10，0.02秒的移动距离,大概1秒500px)
                filter = function(enum)
                    return his.enemy(evtData.triggerUnit, enum) and his.alive(enum)
                end,
                effectMovement = "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl", --移动过程，每个间距的特效（可选的，采用的0秒删除法，请使用explode类型的特效）
                damageEnd = 100, --移动结束时对目标的伤害（可选的，默认为0）
            })
        end
    end)
end