SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "火球护体") then
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local tb = {}
            local j = 0
            for i = 1, 3 do
                tb[i] = cj.AddSpecialEffect("Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl", x, y)
                hjapi.EXSetEffectZ(tb[i], 100)
            end
            htime.setInterval(0.03, function(curTimer)
                j = j + 3
                if (#tb == 0) then
                    curTimer.destroy()
                    return
                end
                for k, v in ipairs(tb) do
                    local px, py = math.polarProjection(hunit.x(u), hunit.y(u), 200, 120 * k + j)
                    hjapi.EXSetEffectXY(v, px, py)

                    local g = hgroup.createByXY(px, py, 600, function(filterUnit)
                        return his.enemy(u, filterUnit) and his.alive(filterUnit) and hunit.getUserData(filterUnit) ~= 1
                    end)
                    if (#g > 0) then
                        table.remove(tb, k)
                        k = k - 1
                        cj.DestroyEffect(v)
                        local unit = table.random(g)
                        hunit.setUserData(unit, 1, 1)
                        missile({
                            model = "Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl",
                            scale = 1,
                            hover = 150,
                            speed = 1000,
                            sourceUnit = u,
                            targetUnit = unit,
                            startX = px,
                            startY = py,
                            onEnd = function(source, _, ex, ey)
                                local eg = hgroup.createByXY(ex, ey, 300, function(filterUnit)
                                    return his.enemy(source, filterUnit) and his.alive(filterUnit)
                                end)
                                hgroup.forEach(eg, function(enumUnit, _)
                                    hskill.damage({
                                        sourceUnit = source, --伤害来源(可选)
                                        targetUnit = enumUnit, --目标单位
                                        damage = hattr.get(source, "str") * 10, --实际伤害
                                        damageSrc = CONST_DAMAGE_SRC.skill,
                                    })
                                end)
                            end
                        })
                    end
                end
            end)
        end
    end)
end