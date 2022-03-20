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
        }
    },
}

for k, v in ipairs(items) do
    if (k == #items) then
        v.Name = "初始月钥-Max"
    else
        v.Name = "初始月钥-Lv" .. k
    end
    v.Art = "ReplaceableTextures\\CommandButtons\\BTNMoonKey.blp"
    v.goldcost = 0
    v.lumbercost = 0
    v.powerup = 0
    v.sellable = 0
    v.pawnable = 1
    v.droppable = 1
    v.perishable = 0
    v._remarks = "烂大街的月亮神钥匙"
    hslk_item(v)
end
