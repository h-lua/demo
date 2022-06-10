SKILLS["威远大炮"] = function(evtData)
    local mv = 0
    local lv = 1
    missile({
        model = "Abilities\\Weapons\\Mortar\\MortarMissile.mdl",
        scale = 1.75,
        height = 200,
        speed = 150,
        acceleration = 0,
        sourceUnit = evtData.triggerUnit,
        targetUnit = evtData.targetUnit,
        onMove = function(options, point)
            mv = mv + 1
            if (mv > 50) then
                mv = 0
                lv = lv + 1
                options.scale = options.scale + 1.25
                options.acceleration = options.acceleration + 3
                local e = heffect.xyz("Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl", point[1], point[2], point[3], 0.25)
                hjapi.EXSetEffectSize(e, options.scale / 4)
                hjapi.EXSetEffectSize(options.arrowToken, options.scale)
            end
            cj.PanCameraToTimed(point[1], point[2], 0)
        end,
        onEnd = function(options, _)
            hskill.damage({
                sourceUnit = options.sourceUnit, --伤害来源(可选)
                targetUnit = options.targetUnit, --目标单位
                damage = 1000 * lv,
                damageSrc = CONST_DAMAGE_SRC.skill,
            })
            return true
        end
    })
end
