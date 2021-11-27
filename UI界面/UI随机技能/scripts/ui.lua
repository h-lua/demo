hdzui.wideScreen()
-- hdzui.hideInterface()

UI = function()
    --加载toc
    hdzui.loadToc("UI\\frame.toc")
    --初始化
    game.awar = hdzui.frame("awar", hdzui.origin.game(), 0)
    --设置位置
    hjapi.DzFrameSetAbsolutePoint(game.awar, 4, 0.388, 0.350)
    hjapi.DzFrameShow(game.awar, false)


    --注册3个按钮点击事件
    --同步
    hsync.onSend("skillLeft", function(syncData)
        local i = tonumber(syncData.triggerData[1])
        hskill.add(game.hero[syncData.triggerPlayer], game.skillData[syncData.triggerPlayer][i], 1)
    end)

    --鼠标点击
    for i = 1, 3 do
        hdzui.onMouse(hjapi.DzFrameFindByName("awar_" .. i, 0), GAME_KEY_MOUSE_LEFT, function()
            local tb = { i }
            hsync.send("skillLeft", tb)
            hjapi.DzFrameShow(game.awar, false)
        end)
    end

end