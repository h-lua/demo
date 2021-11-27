local monster = {
    {
        Name = "小鱼妖",
        file = "units\\creeps\\Murloc\\Murloc",
        modelScale = 1.00,
        scale = 1.00,
        unitSound = "murloc",
    },
    {
        Name = "青鱼妖",
        file = "units\\creeps\\MurlocMutant\\MurlocMutant",
        modelScale = 1.00,
        scale = 1.00,
        unitSound = "murloc",
    },
    {
        Name = "夜鱼妖",
        file = "units\\creeps\\MurlocFlesheater\\MurlocFlesheater",
        modelScale = 1.00,
        scale = 1.00,
        unitSound = "murloc",
    },
}

for _, v in ipairs(monster) do
    v.race = "undead"
    v.Art = "ReplaceableTextures\\CommandButtons\\BTNShade.blp"
    v.HP = 100
    v.spd = 100
    v.sight = 1000
    v.nsight = 800
    v.acquire = 1000
    v.weapsOn = 1
    v.goldcost = 0
    v.lumbercost = 0
    v.fmade = 0
    v.fused = 0
    if (v.movetp == "fly") then
        v.moveHeight = 250
    elseif (v.movetp == "hover") then
        v.moveHeight = 30
    end
    if (v.weapTp1 == CONST_WEAPON_TYPE.missile.value) then
        v.rangeN1 = 600
        v.Missileart_1 = v.Missileart_1 or "Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl"
        v.Missilearc_1 = 0.1
    else
        v.rangeN1 = 130
        v.weapType1 = CONST_WEAPON_SOUND.WoodHeavyBash.value
    end
    hslk_unit(v)
end
