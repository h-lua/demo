local gift = {
    {
        Name = "封印",
        Art = "war3mapImported\\icon_pas_Slow_Grey.blp",
        _remarks = "[奇]字技，特别神奇且怪异的技能|n当前正处于封印状态",
        _attr = nil,
    },
    {
        Name = "无我",
        Art = "war3mapImported\\icon_pas_Arcane_MindMastery.blp",
        _attr = {
            sight = "+500",
            damage_reduction = "+200",
        },
    },
    {
        Name = "醍醐点化",
        Art = "war3mapImported\\icon_pas_Holy_BlindingHeal.blp",
        _attr = {
            gold_ratio = "+50",
            exp_ratio = "+50",
        },
    },
    {
        Name = "勿想冥念",
        Art = "war3mapImported\\icon_pas_Arcane_StudentOfMagic.blp",
        _attr = {
            mana = "+1000",
            int_green = "+200",
        },
    },
    {
        Name = "神的使者",
        Art = "war3mapImported\\icon_pas_Holy_Absolution.blp",
        _attr = {
            e_god_attack = "+1",
            e_god = "+30",
            e_god_oppose = "+30",
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
    local gt = "tao"
    local fid = hslk.n2i("奇 - 封印")
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
    echo("学会了[奇]技[" .. hcolor.green(abName) .. "]")
end)

for _, v in ipairs(gift) do
    hslk_ability_empty({
        Art = v.Art,
        Name = "奇 - " .. v.Name,
        Buttonpos_1 = 3,
        Buttonpos_2 = 1,
        race = "human",
        _remarks = v._remarks,
        _attr = v._attr,
    })
end

for _, v in ipairs(gift) do
    if (v._attr ~= nil) then
        local _attr = table.clone(v._attr)
        _attr.disabled = true
        hslk_item({
            Art = v.Art,
            Name = "秘笈：奇 - " .. v.Name,
            Ubertip = "使用习得[奇技]：" .. v.Name,
            file = "Objects\\InventoryItems\\tomeBlue\\tomeBlue.mdl",
            race = "human",
            perishable = 1,
            _type = "gift_tao",
            _cooldown = 0,
            _attr = _attr,
            _onItemUsed = _used,
        })
    end
end
