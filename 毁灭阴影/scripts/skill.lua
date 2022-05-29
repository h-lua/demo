SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "毁灭阴影") then
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local ang = hunit.getFacing(u)
            local i = 1
            hunit.pause(u)
            htime.setInterval(0.5, function(curTimer)
                i = i + 1
                if (i > 4) then
                    curTimer.destroy()
                    hunit.resume(u)
                    return
                end
                local px, py = math.polarProjection(x, y, 170 * i, ang)
                hunit.animate(u, "attack")
                hjapi.EXEffectMatScale(
                    heffect.xyz("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl", px, py, 0, 0),
                    2, 2, 2
                )
                local g = hgroup.createByXY(px, py, 300, function(filterUnit)
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