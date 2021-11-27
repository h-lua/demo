local items = {
    {
        _attr = _attr({
            life = "+30",
        })
    },
    {
        _attr = {
            life = "+40",
            life_back = "+0.5",
        }
    },
    {
        _attr = {
            life = "+50",
            life_back = "+1.0",
            defend_green = "+2",
        }
    },
    {
        _attr = {
            life = "+70",
            life_back = "+1.2",
            mana = "+50",
            defend_green = "+2",
        }
    },
    {
        _attr = {
            life = "+100",
            life_back = "+1.6",
            mana = "+70",
            mana_back = "+0.6",
            defend_green = "+4",
        }
    },
    {
        _attr = {
            life = "+130",
            life_back = "+2.0",
            mana = "+90",
            mana_back = "+0.8",
            defend_green = "+4",
            move = "+10",
        }
    },
    {
        _attr = {
            life = "+150",
            life_back = "+2.2",
            mana = "+100",
            mana_back = "+1.0",
            defend_green = "+6",
            move = "+20",
            aim = "+10",
        }
    },
    {
        _attr = {
            life = "+180",
            life_back = "+2.5",
            mana = "+120",
            mana_back = "+1.3",
            defend_green = "+6",
            move = "+30",
            aim = "+12",
        }
    },
    {
        _attr = {
            life = "+200",
            life_back = "+2.8",
            mana = "+150",
            mana_back = "+1.5",
            defend_green = "+8",
            move = "+40",
            aim = "+16",
            damage_reduction = "+10",
        }
    },
    {
        _attr = {
            life = "+300",
            life_back = "+3.0",
            mana = "+200",
            mana_back = "+2.0",
            defend_green = "+10",
            move = "+50",
            aim = "+20",
            damage_reduction = "+20",
            sight = "+200",
        }
    },
}

local _use = _onItemUsed(function(evtData)
    local _attr = hslk.i2v(hitem.getId(evtData.triggerItem), "_attr")
    local _half = {}
    for _, arr in ipairs(table.obj2arr(_attr, CONST_ATTR_KEYS)) do
        local k = arr.key
        local v = arr.value
        if (type(v) == "string") then
            local opr = string.sub(v, 1, 1)
            v = string.sub(v, 2, string.len(v))
            _half[k] = opr .. math.floor(tonumber(v) * 0.4)
        end
    end
    hattribute.set(evtData.triggerUnit, 0, _half)
end)

for k, v in ipairs(items) do
    if (k == #items) then
        v.Name = "初始月钥-Max"
    else
        v.Name = "初始月钥-Lv" .. k
    end
    v.Ubertip = "使用消耗钥匙并获得40%的属性"
    v.Art = "ReplaceableTextures\\CommandButtons\\BTNMoonKey.blp"
    v.goldcost = 0
    v.lumbercost = 0
    v.powerup = 0
    v.sellable = 0
    v.pawnable = 0
    v.droppable = 0
    v.perishable = 1
    v._cooldown = 0
    v._overlie = 1
    v._weight = 0
    v._remarks = "烂大街的月亮神钥匙"
    v._onItemUsed = _use
    hslk_item(v)
end
