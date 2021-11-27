local features = {
    {
        Name = "典雅之月",
        Art = "ReplaceableTextures\\PassiveButtons\\PASBTNElunesBlessing.blp",
        _remarks = "在月光下行动的精灵使者，灵动而又不惧怕黑暗魔法",
        _attr = {
            attack_speed = "+13",
            damage_reduction = "+16",
            e_dark_oppose = "+10"
        },
    },
    {
        Name = "剑圣",
        Art = "war3mapImported\\icon_pas_Spell_Nature_UnleashedRage.blp",
        _remarks = "剑之圣者，一瞬断魂",
        _attr = {
            attack_speed = "+24",
            move = "+20",
            xtras = {
                _xtras({
                    on = CONST_EVENT.attack, action = "targetUnit.spec.knocking",
                    odds = 20, val = "damage", percent = 75
                }),
            },
        },
    },
    {
        Name = "王权",
        Art = "war3mapImported\\icon_pas_Spell_Holy_Power.blp",
        _remarks = "身为领袖之人，具有王者气派",
        _attr = {
            life = "+600",
            life_back = "+20",
            sight = "+300",
            gold_ratio = "+5"
        },
    },
    {
        Name = "皇家骑士",
        Art = "war3mapImported\\icon_pas_Holy_GreaterBlessingofKings.blp",
        _attr = {
            str_green = "+100",
            life = "+300",
        },
    },
    {
        Name = "暗夜精灵",
        Art = "war3mapImported\\icon_pas_AvengingAssassin.blp",
        Ubertip = "在夜晚每隔30秒自动获得隐身5秒的效果",
        _remarks = "远古神秘的暗夜精灵",
        _attr = {
            e_dark_attack = "+30",
        },
    },
}

for _, v in ipairs(features) do
    v.Name = "特性 - " .. v.Name
    v.race = v.race or "human"
    v.Buttonpos_1 = 3
    v.Buttonpos_2 = 0
    hslk_ability_empty(v)
end

