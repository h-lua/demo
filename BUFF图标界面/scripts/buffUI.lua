-- buff 展示 keys
BUFF_DISPLAY_KV = {}

-- buff图标对应关系
BUFF_ICON = {
    reborn = "buffIcon\\buff_reborn.tga",
    attack_speed = "buffIcon\\buff_attack_speed.tga",
    attack_space = "buffIcon\\buff_attack_speed.tga",
    attack_space_origin = "buffIcon\\buff_attack_speed.tga",
    attack = "buffIcon\\buff_attack.tga",
    attack_white = "buffIcon\\buff_attack.tga",
    attack_green = "buffIcon\\buff_attack.tga",
    attack_range_acquire = "buffIcon\\buff_attack_range_acquire.tga",
    attack_range = "buffIcon\\buff_attack_range_acquire.tga",
    defend = "buffIcon\\buff_defend.tga",
    defend_white = "buffIcon\\buff_defend.tga",
    defend_green = "buffIcon\\buff_defend.tga",
    str = "buffIcon\\buff_str.tga",
    agi = "buffIcon\\buff_agi.tga",
    int = "buffIcon\\buff_int.tga",
    str_green = "buffIcon\\buff_str.tga",
    agi_green = "buffIcon\\buff_agi.tga",
    int_green = "buffIcon\\buff_int.tga",
    str_white = "buffIcon\\buff_str.tga",
    agi_white = "buffIcon\\buff_agi.tga",
    int_white = "buffIcon\\buff_int.tga",
    life = "buffIcon\\buff_life.tga",
    mana = "buffIcon\\buff_mana.tga",
    life_back = "buffIcon\\buff_life_back.tga",
    mana_back = "buffIcon\\buff_mana_back.tga",
    move = "buffIcon\\buff_move.tga",
    sight = "buffIcon\\buff_sight.tga",
    gold_ratio = "buffIcon\\buff_gold_ratio.tga",
    lumber_ratio = "buffIcon\\buff_lumber_ratio.tga",
    exp_ratio = "buffIcon\\buff_exp_ratio.tga",
    sell_ratio = "buffIcon\\buff_sell_ratio.tga",
}
for _, k in ipairs(CONST_ATTR_KEYS) do
    BUFF_DISPLAY_KV[k] = {
        label = CONST_ATTR_LABEL[k],
        icon = BUFF_ICON[k],
    }
end