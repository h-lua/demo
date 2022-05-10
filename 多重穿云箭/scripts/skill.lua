SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "穿云箭") then
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local px, py = math.polarProjection(x, y, 2000, math.getDegBetweenXY(x, y, evtData.targetX, evtData.targetY))
            local onlyOne = {}
            missile({
                model = "Abilities\\Weapons\\HarpyMissile\\HarpyMissile.mdl",
                scale = 1, --虚拟箭矢的模型缩放
                hover = 0.00, --虚拟箭矢的初始离地高度
                speed = 2000,
                sourceUnit = u,
                targetX = px,
                targetY = py,
                onMove = function(unit, _, mx, my)
                    local g = hgroup.createByXY(mx, my, 100, function(filterUnit)
                        return his.enemy(unit, filterUnit) and his.alive(filterUnit)
                    end)
                    hgroup.forEach(g, function(enumUnit, _)
                        --不重复伤害
                        if (onlyOne[enumUnit] == nil) then
                            onlyOne[enumUnit] = 1
                            hskill.damage({
                                sourceUnit = unit, --伤害来源(可选)
                                targetUnit = enumUnit, --目标单位
                                damage = 100, --实际伤害
                                damageSrc = CONST_DAMAGE_SRC.skill,
                            })
                        end
                    end)
                    g = nil
                    return true
                end
            })
        elseif (name == "多重穿云箭") then
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local facing = math.getDegBetweenXY(x, y, evtData.targetX, evtData.targetY)
            local firstDeg = facing + (15 * (3 - 1) * 0.5)

            for i = 1, 3 do
                local angle = firstDeg - 15 * (i - 1)
                local px, py = math.polarProjection(x, y, 2000, angle)
                local onlyOne = {}
                missile({
                    model = "Abilities\\Weapons\\HarpyMissile\\HarpyMissile.mdl", --[必须]虚拟箭矢的特效
                    animateSpeed = 1.00, --虚拟箭矢的动画速度
                    scale = 1, --虚拟箭矢的模型缩放
                    hover = 0.00, --虚拟箭矢的初始离地高度
                    speed = 2000, --每秒冲击的距离（可选的，默认1秒500px)
                    acceleration = 0, --冲击加速度（可选的，每个周期[0.02秒]都会增加一次)
                    height = 0, --飞跃高度（可选的，默认0)
                    shake = 0, --摇摆振幅程度度[0.00~1.00|random]（可选的，默认0)
                    sourceUnit = u, --[必须]伤害来源
                    targetX = px, --冲击的目标x坐标（可选的，对点冲击）比targetUnit优先级高
                    targetY = py, --冲击的目标y坐标
                    onMove = function(unit, _, mx, my)
                        local g = hgroup.createByXY(mx, my, 100, function(filterUnit)
                            return his.enemy(unit, filterUnit) and his.alive(filterUnit)
                        end)
                        hgroup.forEach(g, function(enumUnit, _)
                            --不重复伤害
                            if (onlyOne[enumUnit] == nil) then
                                onlyOne[enumUnit] = 1
                                hskill.damage({
                                    sourceUnit = unit, --伤害来源(可选)
                                    targetUnit = enumUnit, --目标单位
                                    damage = 100, --实际伤害
                                    damageSrc = CONST_DAMAGE_SRC.skill,
                                })
                            end
                        end)
                        g = nil
                        return true
                    end
                })
            end
        end
    end)
end