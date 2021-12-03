hdzui.wideScreen()
-- hdzui.hideInterface()

UI = function()
    -- 编写属于你的UI
    -- Print your UI
    hdzui.loadToc("UI\\frame.toc")
    local demoCache = {}
    demoCache.game = hdzui.origin.game()

    demoCache.itemSlot = hdzui.origin.itemSlot()

    demoCache.tooltip = hdzui.origin.tooltip()

    demoCache.itemIco = {}

    local playerTxt = {}
    hplayer.forEach(function(enumPlayer, idx)
        if (his.playing(enumPlayer)) then
            playerTxt[idx] = {}
        end
    end)

    local tip = {}
    tip[1] = hdzui.frameTag("BACKDROP", "exp_kk", hdzui.origin.game())

    tip[2] = hdzui.frameTag("TEXT", "txt_10l", tip[1])
    hjapi.DzFrameSetSize(tip[2], 0.16, 0)
    hjapi.DzFrameSetPoint(tip[1], 0, tip[2], 0, -0.005, 0.005)
    hjapi.DzFrameSetPoint(tip[1], 8, tip[2], 8, 0.005, -0.005)
    hjapi.DzFrameShow(tip[1], false)

    local tipTxt = function()
        local fm = hjapi.DzGetTriggerUIEventFrame()
        local idx = hplayer.index(hjapi.DzGetTriggerUIEventPlayer())
        if (playerTxt[idx][fm] ~= nil) then
            hjapi.DzFrameClearAllPoints(demoCache.tooltip)
            hjapi.DzFrameSetAbsolutePoint(demoCache.tooltip, 4, 0.9, 0.7)

            hjapi.DzFrameSetText(tip[2], playerTxt[idx][fm])
            hdzui.framePoint(tip[2], hjapi.DzFrameGetItemBarButton(0), FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_RIGHT_TOP, -0.01, 0.01)
            hjapi.DzFrameShow(tip[1], true)
        end

    end
    local tipTxtNo = function()
        hjapi.DzFrameClearAllPoints(demoCache.tooltip)
        hjapi.DzFrameSetPoint(demoCache.tooltip, 6, hjapi.DzFrameGetItemBarButton(0), 0, -0.02, 0.02)
        hjapi.DzFrameShow(tip[1], false)
    end




    hsync.onSend("item", function(syncData)
        local i = tonumber(syncData.triggerData[1])
        if (cj.UnitItemInSlot(hero, i - 1) ~= nil) then

            htime.setTimeout(0.1,function(curTimer)
                curTimer.destroy()
                if (syncData.triggerPlayer == hplayer.loc()) then
                    hjapi.DzFrameSetSize(demoCache.itemIco[i], 0.033, 0.034)
                end
            end)
            if (syncData.triggerPlayer == hplayer.loc()) then
                hjapi.DzFrameSetSize(demoCache.itemIco[i], 0.030, 0.031)

            end
        end
    end)

    for i, f in ipairs(demoCache.itemSlot) do
        demoCache.itemIco[i]  = hdzui.frameTag("BACKDROP", "itemCleart" .. i, demoCache.game)
        hdzui.framePoint(demoCache.itemIco[i], f, FRAME_ALIGN_CENTER, FRAME_ALIGN_CENTER, 0, 0)
        hjapi.DzFrameSetSize(demoCache.itemIco[i], 0.033, 0.034)
        hjapi.DzFrameShow(demoCache.itemIco[i], false)

        hdzui.onMouse(f, MOUSE_ORDER_CLICK, function()
            local tb = { i }
            hsync.send("item",tb)
        end)

        hdzui.onMouse(f, 2, tipTxt)
        hdzui.onMouse(f, 3, tipTxtNo)

    end

    demoCache.cstg = hdzui.frameTag("BACKDROP", "cstg", demoCache.knapsack)
    hjapi.DzFrameSetSize(demoCache.cstg, 0.025, 0.025)
    hjapi.DzFrameShow(demoCache.cstg, false)


    demoCache.update = function()

        hplayer.forEach(function(enumPlayer, idx)

            local selection
            if (his.playing(enumPlayer)) then
                selection = hplayer.getSelection(enumPlayer)

                if (selection ~= nil) then


                    for i, f in ipairs(demoCache.itemSlot) do
                        if ((cj.UnitItemInSlot(selection, i - 1) ~= nil)) then
                            local items = cj.UnitItemInSlot(selection, i - 1)
                            local ub
                            local itemData = hcache.get(items, "itemData", nil)
                            local ico = itemData.ico
                            if (itemData ~= nil) then
                                ub = hcolor.yellowLight(itemData.name) .. "|n" .. hcolor.red("|n等级:" .. itemData.lv ..
                                    hcolor.yellowLight("|n类型:" .. itemData.type) .. "|n" .. "- 主要属性|n" ..
                                    hcolor.greenLight(CONST_UBERTIP_ATTR(itemData.attr)))
                            end
                            playerTxt[idx][f] = ub
                            if (enumPlayer == hplayer.loc()) then
                                hjapi.DzFrameSetTexture(demoCache.itemIco[i], ico, false)
                                hjapi.DzFrameShow(demoCache.itemIco[i], true)
                            end
                        else
                            playerTxt[idx][f] = nil
                            if (enumPlayer == hplayer.loc()) then
                                hjapi.DzFrameShow(demoCache.itemIco[i], false)
                            end
                        end
                    end


                end
            end
        end)
    end



    -- UI展示
    demoCache.update()
    demoCache.updateTimer = htime.setInterval(0.03, function(_)
        demoCache.update()
    end)




    --local t = cj.CreateTrigger()
    --cj.TriggerRegisterUnitEvent(t, hero, EVENT_UNIT_ISSUED_TARGET_ORDER)
    --cj.TriggerAddAction(t, function()
    --    if (cj.GetIssuedOrderId() == 852002 or cj.GetIssuedOrderId() == 852003 or cj.GetIssuedOrderId() == 852004
    --        or cj.GetIssuedOrderId() == 852005 or cj.GetIssuedOrderId() == 852006 or cj.GetIssuedOrderId() == 852007) then
    --
    --        local idx = hplayer.index(hunit.getOwner(cj.GetOrderedUnit()))
    --        playerBr[1] = false
    --
    --    end
    --end)

end