SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "伪旋转飞斧") then
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local tempEffectArrow = cj.AddSpecialEffect("Abilities\\Weapons\\GlaiveMissile\\GlaiveMissile.mdl", x, y)
            local i = 0
            htime.setInterval(0.06, function(curTimer)
                i = i + 1
                if (i > 100) then
                    curTimer.destroy()
                    heffect.destroy(tempEffectArrow)
                    return
                end
                --更新位置
                x = hunit.x(u)
                y = hunit.y(u)
                local px, py = math.polarProjection(x, y, 400, 10 * i)
                if (hrect.isBorderPlayable(px, py) == false) then
                    hjapi.EXSetEffectXY(tempEffectArrow, px, py)
                    local g = hgroup.createByXY(px, py, 200, function(filterUnit)
                        return hunit.isAlive(filterUnit) and hunit.isEnemy(u, filterUnit)
                    end)
                    hgroup.forEach(g, function(enumUnit, _)
                        hskill.damage({
                            sourceUnit = u, --伤害来源(可选)
                            targetUnit = enumUnit, --目标单位
                            damage = 100, --实际伤害
                        })
                    end)
                end
            end)
        end
    end)
end