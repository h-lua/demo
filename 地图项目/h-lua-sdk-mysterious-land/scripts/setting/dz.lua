local prestigeMap = {
    { mark = 0, label = "冒险者" },
    { mark = 100, label = "历险者" },
    { mark = 500, label = "先驱者" },
    { mark = 1000, label = "千军勇士" },
    { mark = 2500, label = "神武飞将" },
    { mark = 5000, label = "天绝斗者" },
    { mark = 10000, label = "灭劫霸王" },
    { mark = 60000, label = "六御武帝" },
    { mark = 99999, label = "九苍武神" },
}
dzCurrent = {}
dzCurrent.calePrestige = function(power)
    local prestige = 1
    for pi, pm in ipairs(prestigeMap) do
        if (power >= pm.mark) then
            prestige = pi
        else
            break
        end
    end
    return prestigeMap[prestige].label
end
dzCurrent.doRecord = function(whichPlayer)
    local playerIndex = hplayer.index(whichPlayer)
    if (hhero.player_heroes[playerIndex][1] == nil) then
        return
    end
    -- hero
    local heroLv = hhero.getCurLevel(hhero.player_heroes[playerIndex][1])
    -- item
    local itLv = 0
    hitem.forEach(hhero.player_heroes[playerIndex][1], function(slotItem)
        if (slotItem ~= nil) then
            itLv = itLv + hitem.getLevel(slotItem) * (hitem.getCharges(slotItem) + 1)
        end
    end)
    -- 杀敌
    local kill = hplayer.getKill(whichPlayer)
    -- 计算战力
    game.playerData.power[playerIndex] = kill + heroLv * 2 + itLv
    if (game.playerData.gift[playerIndex].gift_weapon ~= nil) then
        game.playerData.power[playerIndex] = game.playerData.power[playerIndex] + 100
    end
    if (game.playerData.gift[playerIndex].gift_defend ~= nil) then
        game.playerData.power[playerIndex] = game.playerData.power[playerIndex] + 100
    end
    if (game.playerData.gift[playerIndex].gift_speed ~= nil) then
        game.playerData.power[playerIndex] = game.playerData.power[playerIndex] + 100
    end
    if (game.playerData.gift[playerIndex].gift_tao ~= nil) then
        game.playerData.power[playerIndex] = game.playerData.power[playerIndex] + 100
    end
    -- 计算称号
    local prestigeLabel = dzCurrent.calePrestige(game.playerData.power[playerIndex])
    hplayer.setPrestige(whichPlayer, prestigeLabel)
    -- 计算探奇
    local point = game.playerData.prevPoint[playerIndex] + gameQuestPoint
    if (point > (game.playerData.prevPoint[playerIndex] + 100)) then
        point = game.playerData.prevPoint[playerIndex] + 100
    end
    -- 写入服务器
    hdzapi.saveServer(whichPlayer, "power", game.playerData.power[playerIndex])
    hdzapi.saveServer(whichPlayer, "point", point)
    if (game.playerData.power[playerIndex] > game.playerData.prevPower[playerIndex]) then
        hdzapi.setRoomStat(whichPlayer, "prestige", prestigeLabel) --房间称号
        hdzapi.setRoomStat(whichPlayer, "power", math.integerFormat(game.playerData.power[playerIndex])) --房间战力
    end
    if (point > game.playerData.prevPoint[playerIndex]) then
        hdzapi.setRoomStat(whichPlayer, "point", math.integerFormat(point)) -- 探奇点
    end
end

dzCurrent.enableRecord = function(whichPlayer)
    hdzapi.setRoomStat(whichPlayer, "prestige", '')
    hdzapi.setRoomStat(whichPlayer, "power", '0')
    hdzapi.setRoomStat(whichPlayer, "point", '0')
    hdzapi.clearServer(whichPlayer, "power")
    hdzapi.clearServer(whichPlayer, "point")
    if (whichPlayer == nil or his.playing(whichPlayer) == false) then
        return
    end
    local playerIndex = hplayer.index(whichPlayer)
    -- init
    game.playerData.gift[playerIndex] = {
        gift_weapon = nil,
        gift_defend = nil,
        gift_speed = nil,
        gift_tao = nil,
    }
    game.playerData.prevPower[playerIndex] = hdzapi.loadServerInteger(whichPlayer, "power")
    game.playerData.prevPoint[playerIndex] = hdzapi.loadServerInteger(whichPlayer, "point")
    local prestigeLabel = dzCurrent.calePrestige(game.playerData.prevPower[playerIndex])
    hplayer.setPrestige(whichPlayer, prestigeLabel)
    -- 20秒保存一次，自动检测玩家数据并保存
    htime.setInterval(20, function()
        for i = 1, hplayer.qty_max, 1 do
            if (his.playing(hplayer.players[i])) then
                dzCurrent.doRecord(hplayer.players[i])
            end
        end
    end)
end
