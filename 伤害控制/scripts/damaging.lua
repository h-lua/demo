-- 流：自上而下
-- 流动下options中的数据得以保留而延续
-- 当options.damage <= 0，则停止后续流动

--- 伤害加深(%)
damaging.defined("damageIncrease", function(options)
    local approve = (options.sourceUnit ~= nil)
    if (approve) then
        local damageIncrease = hattr.get(options.sourceUnit, "damageIncrease")
        if (damageIncrease > 0) then
            options.damage = options.damage * (1 + damageIncrease * 0.01)
        end
    end
end)

--- 受伤加深(%)
damaging.defined("hurtIncrease", function(options)
    local hurtIncrease = hattr.get(options.targetUnit, "hurtIncrease")
    if (hurtIncrease > 0) then
        options.damage = options.damage * (1 + hurtIncrease * 0.01)
    end
end)

--- 减伤(%)
---@alias onImmuneReductionData {triggerUnit:"攻击单位",sourceUnit:"来源单位"}
damaging.defined("hurtReduction", function(options)
    local hurtReduction = hattr.get(options.targetUnit, "hurtReduction")
    if (hurtReduction > 0) then
        options.damage = options.damage * (1 - hurtReduction * 0.01)
        if (options.damage < 1) then
            -- 触发减伤完全抵消事件
            options.damage = 0
            hevent.trigger(options.targetUnit, CONST_EVENT.immuneReduction, { triggerUnit = options.targetUnit, sourceUnit = options.sourceUnit })
            return
        end
    end
end)