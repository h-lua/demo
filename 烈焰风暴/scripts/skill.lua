SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "烈焰风暴") then
            local u = evtData.triggerUnit
            local i = 0
            htime.setInterval(0.5, function(curTimer)
                i = i + 1
                if (i >= 7) then
                    curTimer.destroy()
                    return
                end
                for _ = 1, 7 do
                    local x = math.random(evtData.targetX - 300, evtData.targetX + 300)
                    local y = math.random(evtData.targetY - 300, evtData.targetY + 300)
                    hjapi.EXSetEffectSpeed(heffect.xyz("war3mapImported\\RainOfFire.mdx", x, y, 0, 0), 2)
                    htime.setTimeout(0.5, function(t)
                        t.destroy()
                        local g = hgroup.createByXY(x, y, 200, function(filterUnit)
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
                    end)
                end
            end)
        end
    end)
end