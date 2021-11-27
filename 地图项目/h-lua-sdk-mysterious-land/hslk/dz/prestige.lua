local items = {
    {
        prestige = "冒险者",
        _attr = {
            life = "+50",
            attack_green = "+10",
        }
    },
    {
        prestige = "历险者",
        _attr = {
            life = "+100",
            attack_green = "+30",
        }
    },
    {
        prestige = "先驱者",
        _attr = {
            life = "+150",
            attack_green = "+50",
            attack_speed = "+4",
        }
    },
    {
        prestige = "千军勇士",
        _attr = {
            life = "+250",
            attack_green = "+80",
            attack_speed = "+6",
        }
    },
    {
        prestige = "神武飞将",
        _attr = {
            life = "+350",
            attack_green = "+120",
            attack_speed = "+8",
            punish = "+200",
        }
    },
    {
        prestige = "天绝斗者",
        _attr = {
            life = "+400",
            attack_green = "+150",
            attack_speed = "+12",
            punish = "+400",
        }
    },
    {
        prestige = "灭劫霸王",
        _attr = {
            life = "+500",
            attack_green = "+200",
            attack_speed = "+16",
            punish = "+600",
            weight = "+10",
        }
    },
    {
        prestige = "六御武帝",
        _attr = {
            life = "+600",
            attack_green = "+250",
            attack_speed = "+20",
            punish = "+800",
            weight = "+20",
            damage_extent = "+6",
        }
    },
    {
        prestige = "九苍武神",
        _attr = {
            life = "+900",
            attack_green = "+300",
            attack_speed = "+30",
            punish = "+1000",
            weight = "+30",
            damage_extent = "+10",
            hemophagia = "+20",
            hemophagia_skill = "+20",
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
            _half[k] = opr .. math.floor(tonumber(v) * 0.75)
        end
    end
    hattribute.set(evtData.triggerUnit, 0, _half)
end)

for _, v in ipairs(items) do
    v.Name = "诀尊阳钥[" .. v.prestige .. "专享]"
    v.Art = "ReplaceableTextures\\CommandButtons\\BTNSunKey.blp"
    v.Ubertip = "使用消耗钥匙并获得75%的属性"
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
    v._remarks = v.prestige .. "专用的太阳神钥匙"
    v._onItemUsed = _use
    hslk_item(v)
end
