local couriers = {
    {
        Name = "小饥鸡",
        Ubertip = "一只饥饿的小鸡，喜欢把东西捡起来",
        unitSound = "Chicken",
        file = "units\\critters\\EasterChicken\\EasterChicken",
        Art = "ReplaceableTextures\\CommandButtons\\BTNCritterChicken.blp",
        modelScale = 1.40,
        scale = 1.20,
        moveHeight = 0,
        targType = "ground",
        armor = "Flesh",
        spd = 500,
    },
    {
        Name = "冷静的绵羊",
        Ubertip = "一只冷酷安静的绵羊，用毛茸茸的白毛携带物品",
        unitSound = "Sheep",
        file = "units\\critters\\Sheep\\Sheep",
        Art = "ReplaceableTextures\\CommandButtons\\BTNSheep.blp",
        modelScale = 1.50,
        scale = 1.20,
        moveHeight = 0,
        targType = "ground",
        armor = "Flesh",
        HP = 500,
    },
    {
        Name = "依诺吸吸",
        Ubertip = "红心国山区的野猪，彪悍而结实",
        unitSound = "QuillBeast",
        file = "units\\critters\\Felboar\\Felboar",
        Art = "ReplaceableTextures\\CommandButtons\\BTNFelBoar.blp",
        modelScale = 1.40,
        scale = 1.20,
        moveHeight = 0,
        targType = "ground",
        armor = "Flesh",
        spd = 500,
    },
    {
        Name = "烈火凤凰",
        Ubertip = "从圣火中诞生的火凤凰",
        unitSound = "Phoenix",
        file = "units\\human\\phoenix\\phoenix",
        Art = "war3mapImported\\icon_unit_Phoenix.blp",
        modelScale = 1.20,
        scale = 1.20,
        targType = "air",
        armor = CONST_ARMOR_TYPE.Ethereal.value,
        spd = 500,
        movetp = CONST_MOVE_TYPE.fly.value,
        moveHeight = 260,
    },
    {
        Name = "冰戟幻灵",
        Ubertip = "在寒冰深山里被封印的幻灵",
        unitSound = "Gargoyle",
        file = "war3mapImported\\unit_Frost_Fury_v1.1.md",
        Art = "war3mapImported\\icon_unit_Hunter_Pet_NetherRay.blp",
        modelScale = 1.10,
        scale = 1.10,
        targType = "air",
        armor = CONST_ARMOR_TYPE.Metal.value,
        spd = 500,
        movetp = CONST_MOVE_TYPE.hover.value,
        moveHeight = 120,
    },
}

-- courier
for _, v in ipairs(couriers) do
    v.race = "human"
    v.abilList = "Avul"
    v.HP = 1000
    v._attr = {
        weight = "=9999"
    }
    hslk_courier(v)
end
