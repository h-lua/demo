SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "伪魂之挽歌") then
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            for i = 1, 10 do
                local ang = 36 * i
                local px, py = math.polarProjection(x, y, 2000, ang)
                local onlyOne = {}
                missile({
                    model = "Abilities\\Weapons\\AvengerMissile\\AvengerMissile.mdl",
                    scale = 2,
                    hover = 50,
                    speed = 1000,
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
                                    damage = hattr.get(unit, "str") * 10, --实际伤害
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