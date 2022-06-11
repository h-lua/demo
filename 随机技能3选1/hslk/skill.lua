local art = {
    "ReplaceableTextures\\CommandButtons\\BTNMonsoon.blp",
    "ReplaceableTextures\\CommandButtons\\BTNBanish.blp",
    "ReplaceableTextures\\CommandButtons\\BTNSeaElemental.blp",
    "ReplaceableTextures\\CommandButtons\\BTNShadowStrike.blp",
    "ReplaceableTextures\\CommandButtons\\BTNBlizzard.blp",
    "ReplaceableTextures\\CommandButtons\\BTNPolymorph.blp",
    "ReplaceableTextures\\CommandButtons\\BTNColdArrowsOn.blp",
    "ReplaceableTextures\\CommandButtons\\BTNCripple.blp",
    "ReplaceableTextures\\CommandButtons\\BTNCrushingWave.blp",
    "ReplaceableTextures\\CommandButtons\\BTNManaBurn.blp"
}

for i = 1, 10 do
    hslk_ability({
        Name = "演示技能" .. i,
        Ubertip = hcolor.greenLight("演示技能"),
        Art = art[i],
        _type = "skill",
        Hotkey = "Q",
        _parent = "ANcl",
        DataA = { 0 },
        EffectArt = "",
        TargetArt = "",
        CasterArt = "",
        Cool = { 10 },
        DataB = { 0 },
        Cost = { 0 },
        DataD = { 0 },
        DataC = { 1 },
        Rng = { 1000 },
        DataF = { "channel" },
        targs = { "enemies" },
        DataE = { 0 }
    })
end