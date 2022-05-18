SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "乱拳打死老师傅") then
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local ang = hunit.getFacing(u)
            local px, py = math.polarProjection(x, y, -300, ang)
            local i = 0
            htime.setInterval(0.3, function(curTimer)
                i = i + 1
                if (i > 20 or his.alive(evtData.targetUnit) == false) then
                    curTimer.destroy()
                    return
                end
                missile({
                    model = "war3mapImported\\GiantFireFist.mdx",
                    scale = 1,
                    height = math.random(0, 100),
                    speed = 1000,
                    shake = "rand",
                    sourceUnit = u,
                    targetUnit = evtData.targetUnit,
                    startX = px,
                    startY = math.random(py - 300, py + 300),
                    onEnd = function(source, target, _, _)
                        hskill.damage({
                            sourceUnit = source, --伤害来源(可选)
                            targetUnit = target, --目标单位
                            damage = hattr.get(source, "str") * 10, --实际伤害
                            damageSrc = CONST_DAMAGE_SRC.skill,
                        })
                    end
                })
            end)
        end
    end)
end