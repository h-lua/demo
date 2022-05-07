local skill = {
    {
        Name = "穿云箭",
        Art = "ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp",
        DataB = { 2 },
        Hotkey = "Q",
        DataF = { "channel" },
    },
    {
        Name = "多重穿云箭",
        Art = "ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp",
        DataB = { 2 },
        Hotkey = "W",
        DataF = { "charm" },
    }
}

for _, v in pairs(skill) do
    v._parent = "ANcl"
    v.DataA = { 0 }
    v.EffectArt = ""
    v.TargetArt = ""
    v.CasterArt = ""
    v.Cool = { 1 }
    v.Cost = { 0 }
    v.DataD = { 0 }
    v.DataC = { 1 }
    v.Rng = { 1000 }
    v.targs = { "enemies" }
    v.DataE = { 0 }
    hslk_ability(v)
end