





MAIN_ATTRIBUTE = {
    "life", -- 生命
    "mana", -- 魔法
    "move", -- 移速
    "defend", -- 防御
    "attack_speed", -- 攻速
    "attack", --攻击力
    "life_back", -- 生命回复
    "avoid", -- 回避
    "aim", -- 命中
    "hemophagia", -- 吸血
    "hemophagia_skill", -- 技能吸血
    "damage_extent", -- 增伤
    "knocking_odds", -- 暴击几率
    "knocking_extent", -- 暴击增伤
    "e_physical", --物理强化
    "e_magic", --魔法强化
    "e_fire",
    "e_ice",
    "e_electric",
    "e_poison",
    "coolDown", -- 冷却
    "consume", -- 降耗
    "gold_ratio", -- 黄金率
    "exp_ratio", -- 经验率
    "e_physical_oppose", --物理抵抗
    "e_magic_oppose", -- 魔法抵抗
    "e_fire_oppose",
    "e_ice_oppose",
    "e_electric_oppose",
    "e_poison_oppose",
    "swim_oppose", -- 晕眩抵抗
    "broken_oppose", -- 打断抵抗
    "silent_oppose", -- 沉默抵抗
    "unarm_oppose", -- 缴械抵抗
    "fetter_oppose", -- 定身抵抗
    "damage_decrease", -- 减伤
    "cure", --治疗加成
}
NUMERICAL_VALUE = {
    life = { { 200, 400 }, { 400, 600 }, { 600, 800 }, { 800, 1000 },{ 1000, 1000 } },
    mana = { { 1, 5 }, { 5, 8 }, { 8, 12 }, { 12, 15 },{ 15, 15 } },
    move = { { 20, 40 }, { 40, 80 }, { 80, 120 }, { 120, 200 },{ 200, 200 } },
    defend = { { 2, 5 }, { 10, 20 }, { 20, 40 }, { 40, 60 },{ 60, 60 } },
    attack = { { 50, 100 }, { 200, 500 }, { 800, 1300 }, { 1600, 1900 },{1900,1900} },
    attack_speed = { { 5, 20 }, { 20, 30 }, { 30, 40 }, { 40, 60 },{ 60, 60 } },
    damage_extent = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 },{ 10, 10 } },
    knocking_odds = { { 4, 6 }, { 4, 6 }, { 4, 6 }, { 4, 6 },{ 6, 6 } },
    coolDown = { { 5, 8 }, {  5, 8 }, {  5, 8 }, {  5, 8 },{  8, 8 } },
    consume = { { 5, 8 }, {  5, 8 }, {  5, 8 }, {  5, 8 },{  8, 8 } },
    knocking_extent = { { 25, 50 }, { 25, 50 }, { 25, 50 }, { 25, 50 },{ 50, 50 } },
    str = { { 50, 100 }, { 200, 500 }, { 500, 800 }, { 800, 1000 },{ 1000, 1000 } },
    agi = { { 50, 100 }, { 200, 500 }, { 500, 800 }, { 800, 1000 },{ 1000, 1000 } },
    int = { { 50, 100 }, { 200, 500 }, { 500, 800 }, { 800, 1000 },{ 1000, 1000 } },
    life_back = { { 2, 5 }, { 7, 10 }, { 12, 25 }, { 30, 50 },{ 50, 50 } },
    avoid = { { 4, 6 }, { 4, 6 }, { 4, 6 }, { 4, 6 },{ 6, 6 } },
    aim = { { 4, 6 }, { 4, 6 }, { 4, 6 }, { 4, 6 },{ 6, 6 } },
    hemophagia = { { 4, 6 }, { 4, 6 }, { 4, 6 }, { 4, 6 },{ 6, 6 } },
    hemophagia_skill = { { 4, 6 }, { 4, 6 }, { 4, 6 }, { 4, 6 },{ 6, 6 } },
    e_physical = { { 6, 12 }, { 8, 14 }, { 10, 16 }, { 12, 20 },{ 20, 20 } },
    e_magic = { { 6, 12 }, { 8, 14 }, { 10, 16 }, { 12, 20 },{ 20, 20 } },
    e_fire = { { 6, 12 }, { 8, 14 }, { 10, 16 }, { 12, 20 },{ 20, 20 } },
    e_ice = { { 6, 12 }, { 8, 14 }, { 10, 16 }, { 12, 20 },{ 20, 20 } },
    e_electric = { { 6, 12 }, { 8, 14 }, { 10, 16 }, { 12, 20 },{ 20, 20 } },
    e_poison = { { 6, 12 }, { 8, 14 }, { 10, 16 }, { 12, 20 } ,{ 20, 20 }},
    gold_ratio = { { 10, 15 }, { 17, 22 }, { 25, 30 }, { 33, 45 },{ 45, 45 } },
    exp_ratio = { { 10, 15 }, { 17, 22 }, { 25, 30 }, { 33, 45 },{ 45, 45 } },
    e_physical_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 },{ 10, 10 } },
    e_magic_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 },{ 10, 10 } },
    e_fire_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 },{ 10, 10 } },
    e_electric_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 },{ 10, 10 } },
    e_poison_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 } ,{ 10, 10 }},
    e_ice_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 },{ 10, 10 } },
    swim_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 },{ 10, 10 } },
    broken_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 },{ 10, 10 } },
    silent_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 },{ 10, 10 } },
    unarm_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 },{ 10, 10 } },
    fetter_oppose = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 } ,{ 10, 10 }},
    damage_decrease = { { 3, 6 }, { 4, 7 }, { 5, 8 }, { 6, 10 } ,{ 10, 10 }},
    cure = { { 10, 15 }, { 17, 22 }, { 25, 30 }, { 33, 45 },{ 45, 45 } },
}

--- 附加单位获得物品后的属性
---@protected
XaddProperty = function(whichUnit, itId, tab, charges)
    if (whichUnit == nil or itId == nil or charges < 1 or type(tab) ~= "table") then
        return
    end
    hattribute.caleAttribute(CONST_DAMAGE_SRC.item, true, whichUnit, tab, charges)
    for _ = 1, charges, 1 do
        hring.insert(whichUnit, itId)
    end
end
--- 削减单位获得物品后的属性
---@protected
XsubProperty = function(whichUnit, itId, tab, charges)
    if (whichUnit == nil or itId == nil or charges < 1 or type(tab) ~= "table") then
        return
    end
    hattribute.caleAttribute(CONST_DAMAGE_SRC.item, false, whichUnit, tab, charges)
    for _ = 1, charges, 1 do
        hring.remove(whichUnit, itId)
    end
end




itemCream = function(items)

    hcache.alloc(items)
    local itemData = hcache.get(items, "itemData", nil)
    if (itemData == nil) then
        itemData = {
            name = "",
            ico = "",
            type = "",
            lv = 0,
            attr = {}
        }
        hcache.set(items, "itemData", itemData)
    end

    local tb = {"刀","枪","锤","剑","甲"}
    local num = {10,20,30,40,50}
    itemData.lv = table.random(num)
    itemData.type = table.random(tb)
    itemData.ico = table.random(ITEM_INIT[itemData.type].ico)
    itemData.name = table.random(ITEM_INIT[itemData.type].name)
    local attr = table.clone(ITEM_INIT[itemData.type].attr)
    local itLv = itemData.lv / 10
    for _ = 1, 5 do
        local a = table.random(attr)
        itemData.attr[a] = "+" .. math.random(NUMERICAL_VALUE[a][itLv][1], NUMERICAL_VALUE[a][itLv][2])
        table.delete(attr,a)
    end

end