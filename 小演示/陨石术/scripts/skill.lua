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
                    return his.enemy(u, filterUnit) and his.alive(filterUnit)
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
                            return his.enemy(unit, filterUnit) and his.alive(filterUnit)
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