hjapi.DzEnableWideScreen(true)
--hjapi.DzFrameHideInterface()
--hjapi.DzFrameEditBlackBorders(0, 0)

UI = function()
    print(hjapi.DzLoadToc("UI\\frame.toc"))
    --初始化
    game.awar = hjapi.DzCreateFrame("awar", hjapi.DzGetGameUI(), 0)
    --设置位置
    hjapi.DzFrameSetAbsolutePoint(game.awar, 4, 0.388, 0.350)
    hjapi.DzFrameShow(game.awar, false)


    --注册3个按钮点击事件
    --同步
    hsync.onSend("skillLeft", function(syncData)
        local i = tonumber(syncData.triggerData[1])
        local idx = hplayer.index(syncData.triggerPlayer)
        hskill.add(game.hero[idx], game.skillData[idx][i], 1)
        echo("获得技能" .. hskill.getName(game.skillData[idx][i]),syncData.triggerPlayer)
    end)

    --鼠标点击
    for i = 1, 3 do
        hjapi.DzFrameSetScriptByCode(hjapi.DzFrameFindByName("awar_" .. i, 0), GAME_KEY_MOUSE_LEFT, function()
            local tb = { i }
            hjapi.DzFrameShow(game.awar, false)
            hsync.send("skillLeft", tb)
        end, false)
    end

end