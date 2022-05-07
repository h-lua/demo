SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "毁灭") then
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local i = 0
            htime.setInterval(0.5, function(curTimer)
                i = i + 1
                if (i > 5) then
                    curTimer.destroy()
                    return
                end
                for n = 1, 10 do
                    local px, py = math.polarProjection(x, y, i * 200, 36 * n)
                    heffect.xyz("Abilities\\Spells\\Undead\\Impale\\ImpaleHitTarget.mdl", px, py, 0, 0)
                    local g = hgroup.createByXY(px, py, 150, function(filterUnit)
                        return his.enemy(u, filterUnit) and his.alive(filterUnit)
                    end)
                    hgroup.forEach(g, function(enumUnit, _)
                        hskill.crackFly({
                            damage = 100, --伤害（必须有，但是这里可以等于0）
                            targetUnit = enumUnit, --目标单位（必须有）
                            sourceUnit = u, --伤害来源单位（可选）
                            odds = 100, --几率（可选,默认100）
                            distance = 0, --击退距离，可选，默认0
                            height = 200, --击飞高度，可选，默认100
                            during = 0.5, --击飞过程持续时间，可选，默认0.5秒
                        })
                    end)
                end
            end)
        end
    end)
end