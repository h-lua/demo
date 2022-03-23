local items = {
    {
        Name = "铁剑",
        Ubertip = "主动演示（效果需要自己处理，本图无效果）|n被动演示（效果需要自己处理，本图无效果）",
        Art = "ReplaceableTextures\\CommandButtons\\BTNSteelMelee.blp",
        goldcost = 1000,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "Q",
        abilList = "",
        _remarks = "精铁铸造的大剑，是武斗者必备的武器",
        _attr = _attr({
            attack = "+30", --smart
            attack_range = "+100",
        }),
    },
    {
        Name = "铁盾",
        Art = "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpOne.blp",
        goldcost = 1000,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "W",
        abilList = "",
        _remarks = "普通的铁盾",
        _attr = {
            defend = "+1", --smart
            life = "+300",
            life_back = "+10",
        },
    },
    {
        Name = "双铁剑",
        Ubertip = "点人",
        Art = "ReplaceableTextures\\CommandButtons\\BTNDaggerOfEscape.blp",
        goldcost = 2000,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "E",
        Rng1 = 1000,
        uses = 3,
        Missileart = "",
        _cooldown = 2,
        _cooldownTarget = CONST_ABILITY_TARGET.unit.value,
        _remarks = "双倍的铁，双倍的快乐",
        _attr = {
            reborn = '-0.4',
            attack = "+50",
            attack_space = '-0.1',
        },
    },
}

for _, v in pairs(items) do
    v.race = "human"
    hslk_item(v)
end