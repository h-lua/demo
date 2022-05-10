SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "八门金锁阵除以2") then
            local trigUnit = evtData.triggerUnit
            local g = hgroup.createByXY(hunit.x(trigUnit), hunit.y(trigUnit), 800, function(filterUnit)
                return his.alive(filterUnit) and his.enemy(filterUnit, trigUnit)
            end)
            if (#g > 0) then
                local u = table.random(g)
                local x, y = hunit.x(u), hunit.y(u)
                local num = {
                    { 500, 100 },
                    { 100, 500 },
                    { 500, 100 },
                    { 100, 500 }
                }
                for i = 1, 4 do
                    local px, py = math.polarProjection(x, y, 310, 90 * i)
                    local eff = heffect.xyz("war3mapImported\\ForceGate_Ashenvale.mdx", px, py, 0, 5)
                    hjapi.EXEffectMatRotateZ(eff, 90 * i)
                    local r = hrect.create(px, py, num[i][1], num[i][2], "666")
                    local j = 0
                    htime.setInterval(0.5, function(curTimer)
                        j = j + 1
                        if (j >= 10) then
                            hrect.del(r)
                            curTimer.destroy()
                        end
                        local g1 = hgroup.createByRect(r, function(filterUnit)
                            return his.alive(filterUnit) and his.enemy(filterUnit, trigUnit)
                        end)
                        if (#g1 > 0) then
                            hgroup.forEach(g1, function(enumUnit, _)
                                hskill.damage({
                                    sourceUnit = trigUnit, --伤害来源(可选)
                                    targetUnit = enumUnit, --目标单位
                                    damage = 100, --实际伤害
                                    damageSrc = CONST_DAMAGE_SRC.skill,
                                })
                            end)
                        end
                        g1 = nil
                    end)
                end
            end
        end
    end)
end