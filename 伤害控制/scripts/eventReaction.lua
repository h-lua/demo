-- 事件反应
hmodelTag.char("0", "hLua\\ttg\\n_0.mdl", 1.9)
hmodelTag.char("1", "hLua\\ttg\\n_1.mdl", 1.8)
hmodelTag.char("2", "hLua\\ttg\\n_2.mdl", 1.8)
hmodelTag.char("3", "hLua\\ttg\\n_3.mdl", 1.8)
hmodelTag.char("4", "hLua\\ttg\\n_4.mdl", 1.8)
hmodelTag.char("5", "hLua\\ttg\\n_5.mdl", 1.8)
hmodelTag.char("6", "hLua\\ttg\\n_6.mdl", 1.8)
hmodelTag.char("7", "hLua\\ttg\\n_7.mdl", 1.8)
hmodelTag.char("8", "hLua\\ttg\\n_8.mdl", 1.8)
hmodelTag.char("9", "hLua\\ttg\\n_9.mdl", 1.8)
hmodelTag.char("+", "hLua\\ttg\\s_jia.mdl", 1.7)
hmodelTag.char("-", "hLua\\ttg\\s_jian.mdl", 1.7)

local function _z(u, offset)
    return hunit.h(u) + 130 + offset
end

---@param evtData onBeDamageData
hevent.reaction(CONST_EVENT.beDamage, function(evtData)
    hmodelTag.word({
        str = math.floor(evtData.damage),
        width = 10,
        size = 0.3,
        x = hunit.x(evtData.triggerUnit),
        y = hunit.y(evtData.triggerUnit),
        z = _z(evtData.triggerUnit, 0),
        height = 350,
        duration = 0.3,
        scale = { 1.2, 0.5 },
    })
end)