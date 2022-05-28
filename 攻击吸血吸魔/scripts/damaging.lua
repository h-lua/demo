-- 流：自上而下
-- 流动下options中的数据得以保留而延续
-- 当options.damage <= 0，则停止后续流动

--- 攻击吸血
---@alias noteOnUnitHPSuckAttackData {triggerUnit:userdata, targetUnit:userdata}
damaging.defined("hpSuckAttack", function(options)
    local approve = (options.sourceUnit ~= nil and options.damageSrc == CONST_DAMAGE_SRC.attack)
    if (approve) then
        local percent = hattr.get(options.sourceUnit, "hpSuckAttack") or 0
        local val = options.damage * percent * 0.01
        if (percent > 0 and val > 0) then
            print("吸血参数：(百分比|实际)", percent, val)
            hunit.addCurLife(options.sourceUnit, val)
            --- 触发吸血事件
            hevent.trigger(options.sourceUnit, CONST_EVENT.hpSuckAttack, {
                triggerUnit = options.sourceUnit,
                targetUnit = options.targetUnit,
            })
        end
    end
end)

--- 攻击吸魔;吸魔会根据伤害，扣减目标的魔法值，再据百分比增加自己的魔法值;目标魔法值不足 1 从而吸收时，则无法吸取
---@alias noteOnUnitMPSuckAttackData {triggerUnit:userdata, targetUnit:userdata}
damaging.defined("mpSuckAttack", function(options)
    local approve = (options.sourceUnit ~= nil and options.damageSrc == CONST_DAMAGE_SRC.attack and hunit.getMaxMana(options.sourceUnit) > 0 and hunit.getCurMana(options.targetUnit) > 0)
    if (approve) then
        local percent = hattr.get(options.sourceUnit, "mpSuckAttack") or 0
        if (percent > 0) then
            local mana = math.min(hunit.getMaxMana(options.targetUnit), options.damage)
            local val = mana * percent * 0.01
            print("吸魔参数：(百分比|实际)", percent, val)
            if (val > 1) then
                hunit.subCurMana(options.targetUnit, val)
                hunit.addCurMana(options.sourceUnit, val)
                --- 触发吸魔事件
                hevent.trigger(options.sourceUnit, CONST_EVENT.mpSuckAttack, {
                    triggerUnit = options.sourceUnit,
                    targetUnit = options.targetUnit,
                })
            end
        end
    end
end)

