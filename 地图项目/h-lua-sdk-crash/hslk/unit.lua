hslk_unit({
    _id_force = "u00U",
    Name = "剑士",
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
    abilList = "",
    _attr = {
        life = "+1",
        attack_white = "+1",
        attack_speed = "+1",
        move = "+1",
    },
})