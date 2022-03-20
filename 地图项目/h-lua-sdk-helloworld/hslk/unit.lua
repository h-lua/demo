local heros = {
    {
        Name = "剑士",
        Propernames = "无名氏",
        Ubertip = hcolor.grey("身穿盔甲的战士，持剑作战，攻防兼备。"),
        Art = "ReplaceableTextures\\CommandButtons\\BTNFootman.blp",
        file = "units\\human\\Footman\\Footman",
        unitSound = "Footman",
        movetp = "foot",
        moveHeight = 0.00,
        spd = 270, -- 移动速度
        rangeN1 = 125, -- 攻击范围
        dmgplus1 = 20, -- 基础攻击
        weapTp1 = CONST_WEAPON_TYPE.normal.value, -- 攻击类型
        weapType1 = CONST_WEAPON_SOUND.MetalMediumSlice.value, -- 攻击类型
        Missileart = "", -- 箭矢
        cool1 = 1.0, -- 攻击周期
        backSw1 = 0.5, -- 攻击后摇
        dmgpt1 = 0.5, -- 攻击前摇
        modelScale = 1.10,
        scale = 1.10,
        Primary = "AGI",
        STR = 24,
        AGI = 27,
        INT = 25,
        STRplus = 1.9,
        AGIplus = 2.3,
        INTplus = 2.1,
        goldcost = 0,
        heroAbilList = "",
        _msg = "自定义信息，爱写啥写啥",
        _attr = {
            reborn = "=5",
            e_fire_attack = "+1", -- 附魔1层火
            attack_white = "+200",
            attack_speed = "+5",
            life = "+1000",
            life_back = "+30",
        },
    },
    {
        Name = "骑士",
        Propernames = "无名氏",
        Ubertip = hcolor.grey("骑架铁马的战士，冲锋陷阵，防御奇佳。"),
        Art = "ReplaceableTextures\\CommandButtons\\BTNKnight.blp",
        file = "units\\human\\Knight\\Knight",
        unitSound = "Knight",
        movetp = "horse",
        moveHeight = 0.00,
        spd = 290, -- 移动速度
        rangeN1 = 200, -- 攻击范围
        dmgplus1 = 18, -- 基础攻击
        weapTp1 = CONST_WEAPON_TYPE.normal.value, -- 攻击类型
        weapType1 = CONST_WEAPON_SOUND.MetalHeavySlice.value, -- 攻击类型
        Missileart = "", -- 箭矢
        cool1 = 1.7, -- 攻击周期
        backSw1 = 0.44, -- 攻击后摇
        dmgpt1 = 0.66, -- 攻击前摇
        modelScale = 1.10,
        scale = 1.10,
        Primary = "STR",
        STR = 30,
        AGI = 15,
        INT = 22,
        STRplus = 2.4,
        AGIplus = 1.7,
        INTplus = 2.0,
        goldcost = 0,
        heroAbilList = "",
        _attr = {
            reborn = "=3",
            attack_white = "+100",
            life = "+500000",
            life_back = "+3000",
            defend = "+50",
        },
    },
}

for _, v in pairs(heros) do
    v.race = "human"
    hslk_hero(v)
end