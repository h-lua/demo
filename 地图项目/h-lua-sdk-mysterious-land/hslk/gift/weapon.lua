local gift = {
    {
        Name = "封印",
        Art = "war3mapImported\\icon_pas_Slow_Grey.blp",
        _remarks = "[武]字技，在于加强英雄的战斗力|n当前正处于封印状态",
        _attr = nil,
    },
    {
        Name = "大剑修炼",
        Art = "war3mapImported\\icon_pas_Ability_Rogue_BladeTwisting.blp",
        _attr = {
            attack_green = "+70",
        },
    },
    {
        Name = "回音剑技",
        Art = "war3mapImported\\icon_pas_Warrior_WeaponMastery.blp",
        _attr = {
            attack_green = "+90",
            attack_speed = "+25",
        },
    },
    {
        Name = "嗜血割裂",
        Art = "war3mapImported\\icon_pas_Ability_Gouge.blp",
        _attr = {
            attack_green = "+40",
            hemophagia = "+5",
            xtras = {
                { on = CONST_EVENT.attack, action = "targetUnit.attr.life_back", val = -2.5, odds = 50, during = 3, effect = nil },
                { on = CONST_EVENT.attack, action = "targetUnit.attr.defend_green", val = -1, odds = 50, during = 3, effect = nil },
            },
        },
    },
    {
        Name = "淬火铁手",
        Art = "war3mapImported\\icon_pas_AdvancedUnholyStrength.blp",
        _attr = {
            str_green = "+180",
            e_fire_attack = "+1",
            e_fire = "+20",
        },
    },
    {
        Name = "心碎",
        Art = "war3mapImported\\icon_pas_BrokenHeart.blp",
        _attr = {
            xtras = {
                { on = CONST_EVENT.attack, action = "targetUnit.attr.life_back", val = -3.5, odds = 50, during = 4, effect = nil },
                { on = CONST_EVENT.attack, action = "targetUnit.attr.move", val = -5, odds = 50, during = 4, effect = nil },
            },
        },
    },
    {
        Name = "贤者之剑",
        Art = "war3mapImported\\icon_pas_Holy_PersuitofJustice.blp",
        _attr = {
            e_magic_attack = "+2",
            int_green = "+30",
            xtras = {
                { on = CONST_EVENT.attack, action = "targetUnit.spec.knocking", val = 'damage', odds = 60, percent = 35, effect = nil },
                { on = CONST_EVENT.attack, action = "targetUnit.attr.move", val = -5, odds = 50, during = 4, effect = nil },
            },
        },
    },
}

local _used = _onItemUsed(function(evtData)
    local triggerUnit = evtData.triggerUnit
    local playerIndex = hplayer.index(hunit.getOwner(triggerUnit))
    local hero = hhero.player_heroes[playerIndex][1] -- 兼容信使
    if (hero == nil or his.deleted(hero)) then
        return
    end
    local gt = "weapon"
    local fid = hslk.n2i("武 - 封印")
    if (hskill.has(hero, fid)) then
        hskill.del(hero, fid)
    end
    if (game.playerData.gift[playerIndex][gt] ~= nil) then
        hskill.del(hero, game.playerData.gift[playerIndex][gt])
    end
    local itemName = hitem.getName(evtData.triggerItem)
    local abName = string.gsub(itemName, "秘笈：", "")
    local triggerSkill = hslk.n2i(abName)
    hskill.add(hero, triggerSkill)
    game.playerData.gift[playerIndex][gt] = triggerSkill
    heffect.toUnit("Abilities\\Spells\\Items\\AIem\\AIemTarget.mdl", hero)
    echo("学会了[武]技[" .. hcolor.green(abName) .. "]")
end)

for _, v in ipairs(gift) do
    hslk_ability_empty({
        Art = v.Art,
        Name = "武 - " .. v.Name,
        Buttonpos_1 = 0,
        Buttonpos_2 = 1,
        race = "human",
        _desc = v._desc,
        _attr = v._attr,
    })
end

for _, v in ipairs(gift) do
    if (v._attr ~= nil) then
        local _attr = table.clone(v._attr)
        _attr.disabled = true
        hslk_item({
            Art = v.Art,
            Name = "秘笈：武 - " .. v.Name,
            Ubertip = "使用习得[武技]：" .. v.Name,
            file = "Objects\\InventoryItems\\tomeBlue\\tomeBlue.mdl",
            race = "human",
            perishable = 1,
            _type = "gift_weapon",
            _cooldown = 0,
            _attr = _attr,
            _onItemUsed = _used,
        })
    end
end












