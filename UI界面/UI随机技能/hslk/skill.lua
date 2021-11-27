for i = 1, 10 do
    hslk_ability({
        Name = "演示技能" .. i,
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