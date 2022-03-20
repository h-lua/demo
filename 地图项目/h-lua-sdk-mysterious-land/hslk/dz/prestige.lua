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
        }
    },
    {
        prestige = "天绝斗者",
        _attr = {
            life = "+400",
            attack_green = "+150",
            attack_speed = "+12",
        }
    },
    {
        prestige = "灭劫霸王",
        _attr = {
            life = "+500",
            attack_green = "+200",
            attack_speed = "+16",
        }
    },
    {
        prestige = "六御武帝",
        _attr = {
            life = "+600",
            attack_green = "+250",
            attack_speed = "+20",
        }
    },
    {
        prestige = "九苍武神",
        _attr = {
            life = "+900",
            attack_green = "+300",
            attack_speed = "+30",
        }
    },
}

for _, v in ipairs(items) do
    v.Name = "诀尊阳钥[" .. v.prestige .. "专享]"
    v.Art = "ReplaceableTextures\\CommandButtons\\BTNSunKey.blp"
    v.goldcost = 0
    v.lumbercost = 0
    v.powerup = 0
    v.sellable = 0
    v.pawnable = 0
    v.pawnable = 1
    v.droppable = 1
    v._remarks = v.prestige .. "专用的太阳神钥匙"
    hslk_item(v)
end
