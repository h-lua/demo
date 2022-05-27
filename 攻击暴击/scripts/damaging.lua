-- 流：自上而下
-- 流动下options中的数据得以保留而延续
-- 当options.damage <= 0，则停止后续流动

--- 攻击暴击
---@alias noteOnUnitCritData {triggerUnit:userdata, targetUnit:userdata}
damaging.defined("crit", function(options)
    local approve = (options.sourceUnit ~= nil and (options.damageSrc == CONST_DAMAGE_SRC.attack))
    if (approve) then
        local crit = hattr.get(options.sourceUnit, "crit") or 0
        if (crit > 0) then
            local odds = hattr.get(options.sourceUnit, "critOdds") or 0
            print("暴击参数（加成，几率）", crit, odds)
            if (odds > math.random(1, 100)) then
                options.damage = options.damage * (1 + crit * 0.01)
                --- 触发暴击事件
                hevent.trigger(options.sourceUnit, CONST_EVENT.crit, {
                    triggerUnit = options.sourceUnit,
                    targetUnit = options.targetUnit,
                })
            end
        end
    end
end)