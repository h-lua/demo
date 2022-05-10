SKILL = function()
    ---@param evtData onSkillEffectData
    hevent.reaction(CONST_EVENT.skillEffect, "skills", function(evtData)
        local name = hslk.i2v(evtData.triggerSkill, "slk", "Name")
        if (name == "半成品无敌斩") then
            WUDIZHAN({
                sourceUnit = evtData.triggerUnit, --伤害来源（必须有！不管有没有伤害）
                targetUnit = evtData.targetUnit, --冲击的目标单位（必须有）
                qty = 10, --（跳跃次数，默认1）
                radius = 1000, --（选目标半径范围，默认500）
                speed = 60, --冲击的速度（可选的，默认10，0.02秒的移动距离,大概1秒500px)
                filter = function(enum)
                    return his.enemy(evtData.triggerUnit, enum) and his.alive(enum)
                end,
                effectMovement = "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile_mini.mdl", --移动过程，每个间距的特效（可选的，采用的0秒删除法，请使用explode类型的特效）
                damageEnd = 100, --移动结束时对目标的伤害（可选的，默认为0）
            })
        end
    end)
end