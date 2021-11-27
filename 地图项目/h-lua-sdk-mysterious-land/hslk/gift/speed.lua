local gift = {
    {
        Name = "封印",
        Art = "war3mapImported\\icon_pas_Slow_Grey.blp",
        _remarks = "[速]字技，在于加快英雄的速度|n当前正处于封印状态",
        _attr = nil,
    },
    {
        Name = "虚幻之刀",
        Art = "war3mapImported\\icon_pas_ThrowingKnife_06.blp",
        _attr = {
            attack_speed = "+45"
        },
    },
    {
        Name = "断臂之勇",
        Art = "war3mapImported\\icon_pas_Ability_Warrior_Intervene.blp",
        _attr = {
            attack_green = "-45",
            attack_speed = "+55",
        },
    },
    {
        Name = "神行太保",
        Art = "war3mapImported\\icon_pas_Rogue_FleetFooted.blp",
        _attr = {
            move = "+50",
            avoid = "+15"
        },
    },
    {
        Name = "猎豹拟态",
        Art = "war3mapImported\\icon_pas_Hunter_CatlikeReflexes.blp",
        _attr = {
            agi_green = "+50",
            move = "+30",
        },
    },
    {
        Name = "飞火靴",
        Art = "war3mapImported\\icon_pas_Fire_BurningSpeed.blp",
        _attr = {
            move = "+60",
            e_fire_oppose = "+40",
        },
    },
    {
        Name = "远古弓术",
        Art = "war3mapImported\\icon_pas_Hunter_ZenArchery.blp",
        _attr = {
            aim = "+15",
            attack_speed = "+45",
            avoid = "+5",
        },
    },
    {
        Name = "缥缈",
        Art = "war3mapImported\\icon_pas_Inextricable.blp",
        _attr = {
            attack_speed = "+10",
            avoid = "+30",
            move = "+20",
        },
    },
    {
        Name = "瞄准",
        Art = "war3mapImported\\icon_pas_Ability_Hunter_SniperShot.blp",
        _attr = {
            aim = "+30",
            xtras = {
                { on = CONST_EVENT.attack, action = "targetUnit.attr.avoid", val = -10, odds = 100, during = 3, effect = nil },
                { on = CONST_EVENT.attack, action = "triggerUnit.attr.attack_speed", val = 10, odds = 100, during = 3, effect = nil },
            },
        },
    },
}

for _, v in ipairs(gift) do
    hslk_ability_empty({
        Art = v.Art,
        Name = "速 - " .. v.Name,
        Buttonpos_1 = 2,
        Buttonpos_2 = 1,
        race = "human",
        _remarks = v._remarks,
        _attr = v._attr,
    })
end

local _used = _onItemUsed(function(evtData)
    local triggerUnit = evtData.triggerUnit
    local playerIndex = hplayer.index(hunit.getOwner(triggerUnit))
    local hero = hhero.player_heroes[playerIndex][1] -- 兼容信使
    if (hero == nil or his.deleted(hero)) then
        return
    end
    local gt = "speed"
    local fid = hslk.n2i("速 - 封印")
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
    echo("学会了[速]技[" .. hcolor.green(abName) .. "]")
end)

for _, v in ipairs(gift) do
    if (v._attr ~= nil) then
        local _attr = table.clone(v._attr)
        _attr.disabled = true
        hslk_item({
            Art = v.Art,
            Name = "秘笈：速 - " .. v.Name,
            Ubertip = "使用习得[速技]：" .. v.Name,
            file = "Objects\\InventoryItems\\tomeBlue\\tomeBlue.mdl",
            race = "human",
            perishable = 1,
            _type = "gift_speed",
            _cooldown = 0,
            _attr = _attr,
            _onItemUsed = _used,
        })
    end
end
