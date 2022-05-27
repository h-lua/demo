-- 流：自上而下
-- 流动下options中的数据得以保留而延续
-- 当options.damage <= 0，则停止后续流动

--- 命中 + 回避
---@alias noteOnUnitAvoidData {triggerUnit:userdata, sourceUnit:userdata}
damaging.defined("avoid", function(options)
    print("回避（几率）", hattr.get(options.targetUnit, "avoid"))
    print("命中（加成）", hattr.get(options.sourceUnit, "aim"))
    local odds = hattr.get(options.targetUnit, "avoid") - hattr.get(options.sourceUnit, "aim")
    if (odds > math.random(1, 100) and options.damageSrc == CONST_DAMAGE_SRC.attack) then
        options.damage = 0 -- 置0断掉伤害流
        --- 触发回避事件
        hevent.trigger(options.targetUnit, CONST_EVENT.avoid, {
            triggerUnit = options.targetUnit,
            sourceUnit = options.sourceUnit,
        })
    end
end)