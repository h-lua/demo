hjapi.DzEnableWideScreen(true)
--hjapi.DzFrameHideInterface()
--hjapi.DzFrameEditBlackBorders(0, 0)

UI = function()
    hjapi.DzLoadToc("UI\\frame.toc")

    local playerTxt = {}
    playerTxt[hplayer.index(hplayer.players[1])] = {}
    hplayer.forEach(function(enumPlayer, idx)
        if (his.playing(enumPlayer)) then
            playerTxt[idx] = {}
        end
    end)

    local tip = {}
    tip[1] = hjapi.FrameTag("BACKDROP", "exp_kk", hjapi.DzGetGameUI())

    tip[2] = hjapi.FrameTag("TEXT", "txt_10l", tip[1])
    hjapi.DzFrameSetSize(tip[2], 0.16, 0)
    hjapi.DzFrameSetPoint(tip[1], 0, tip[2], 0, -0.005, 0.005)
    hjapi.DzFrameSetPoint(tip[1], 8, tip[2], 8, 0.005, -0.005)
    hjapi.DzFrameShow(tip[1], false)

    local tipTxt = function()
        local fm = hjapi.DzGetTriggerUIEventFrame()
        local idx = hplayer.index(hjapi.DzGetTriggerUIEventPlayer())
        hjapi.DzFrameSetText(tip[2], playerTxt[idx][fm])
        hjapi.FrameRelation(tip[2], FRAME_ALIGN_LEFT_BOTTOM, fm, FRAME_ALIGN_RIGHT_TOP, -0.01, 0.01)
        hjapi.DzFrameShow(tip[1], true)
    end
    local tipTxtNo = function()
        hjapi.DzFrameShow(tip[1], false)
    end

    SINGLUAR_UI_ABILITY_MAX = 11 * 2 --最大buff数,偶数

    local bagRx = 0.016
    local bagRy = bagRx * (8 / 6)

    local SLBuffBtns = {}
    local SLBuffTxt = {}
    local SLBuffExts = {}
    local SLBuffBorders = {}

    for i = 1, SINGLUAR_UI_ABILITY_MAX do
        local x = -0.084 + bagRx * (i - 1)
        local y = 0.142
        local half = SINGLUAR_UI_ABILITY_MAX / 2
        if (i > half) then
            x = -0.084 + bagRx * (i - half - 1)
            y = 0.142 + bagRy
        end


        --buff图标
        SLBuffExts[i] = hjapi.FrameTag("BACKDROP", "sdk_buff->ext->" .. i, hjapi.DzGetGameUI(), "")
        hjapi.DzFrameSetPoint(SLBuffExts[i], 7, hjapi.DzGetGameUI(), 7, x, y)
        hjapi.DzFrameSetSize(SLBuffExts[i], bagRx, bagRy)
        hjapi.DzFrameShow(SLBuffExts[i], false)

        --三角图标
        SLBuffBorders[i] = hjapi.FrameTag("BACKDROP", "sdk_buff->border->" .. i, SLBuffExts[i], "")
        hjapi.DzFrameSetPoint(SLBuffBorders[i], 4, SLBuffExts[i], 4, 0, 0)
        hjapi.DzFrameSetSize(SLBuffBorders[i], bagRx, bagRy)
        hjapi.DzFrameShow(SLBuffBorders[i], true)

        --时间文本
        SLBuffTxt[i] = hjapi.FrameTag("TEXT", "T666", SLBuffExts[i])
        hjapi.DzFrameSetText(SLBuffTxt[i], "")
        hjapi.DzFrameSetPoint(SLBuffTxt[i], 4, SLBuffExts[i], 4, 0, 0)
        hjapi.DzFrameShow(SLBuffTxt[i], true)

        --按钮
        SLBuffBtns[i] = hjapi.FrameTag("BUTTON", "sdk_buff->btn->" .. i, SLBuffExts[i], nil)
        hjapi.DzFrameSetPoint(SLBuffBtns[i], 4, SLBuffExts[i], 4, 0, 0)
        hjapi.DzFrameSetSize(SLBuffBtns[i], bagRx, bagRy)
        hjapi.DzFrameShow(SLBuffBtns[i], true)

        --进入按钮动作

        hjapi.DzFrameSetScriptByCode(SLBuffBtns[i], 2, tipTxt, false)
        hjapi.DzFrameSetScriptByCode(SLBuffBtns[i], 3, tipTxtNo, false)
        --

    end

    htime.setInterval(0.1, function(_)
        hplayer.forEach(function(enumPlayer, idx)
            local selection = selectedUnit[idx]
            local show = false
            local showIdx = {}
            if (his.playing(enumPlayer) and selection ~= nil) then
                if (his.alive(selection)) then
                    local buffHandle = hcache.get(selection, CONST_CACHE.BUFF)
                    if (buffHandle ~= nil) then
                        show = true
                        local buffTab = {}
                        local sort = {}
                        for bi, b in ipairs(CONST_ATTR_KEYS) do
                            local keys = ""
                            local symbol = ""
                            if (buffHandle["attr." .. b .. "+"] ~= nil) then
                                keys = "attr." .. b .. "+"
                                symbol = "+"
                                for _, buffKey in ipairs(buffHandle[keys]._idx) do
                                    buffHandle[keys][buffKey].num = bi
                                    buffHandle[keys][buffKey].symbol = symbol
                                    buffTab[buffKey] = buffHandle[keys][buffKey]
                                    local s = { key = buffKey }
                                    table.insert(sort, s)
                                end
                            end
                            if (buffHandle["attr." .. b .. "-"] ~= nil) then
                                keys = "attr." .. b .. "-"
                                symbol = "-"
                                for _, buffKey in ipairs(buffHandle[keys]._idx) do
                                    buffHandle[keys][buffKey].num = bi
                                    buffHandle[keys][buffKey].symbol = symbol
                                    buffTab[buffKey] = buffHandle[keys][buffKey]
                                    local s = { key = buffKey }
                                    table.insert(sort, s)
                                end
                            end
                        end
                        ----
                        --排序
                        table.sort(sort, function(a, b)
                            return a.key < b.key
                        end)

                        if (show) then
                            for idxs, v in ipairs(sort) do
                                if (idxs < SINGLUAR_UI_ABILITY_MAX) then
                                    showIdx[idxs] = true
                                    local time = buffTab[v.key].times
                                    local bi = buffTab[v.key].num
                                    local icon = BUFF_DISPLAY_KEYS[bi].icon
                                    local name = BUFF_DISPLAY_KEYS[bi].name
                                    local t = math.round(time.remain(), 1)
                                    local difference = 0
                                    local icoTga = ""
                                    if (buffTab[v.key].symbol == "+") then
                                        icoTga = "buffIcon\\up.tga"
                                        difference = hcolor.green(buffTab[v.key].symbol .. buffTab[v.key].difference)
                                    else
                                        icoTga = "buffIcon\\down.tga"
                                        difference = hcolor.red(buffTab[v.key].difference)
                                    end
                                    --提示框 需要，没做 自己弄
                                    playerTxt[idx][SLBuffBtns[idxs]] = name .. ":" .. difference .. "|n" .. hcolor.greenLight("持续:" .. t .. "秒")
                                    if (enumPlayer == hplayer.loc()) then
                                        hjapi.DzFrameSetTexture(SLBuffBorders[idxs], icoTga, false)
                                        hjapi.DzFrameSetText(SLBuffTxt[idxs], t)
                                        hjapi.DzFrameSetTexture(SLBuffExts[idxs], icon, false)
                                        if (t <= 3) then
                                            local transparency = 50 + 255 * t / 3
                                            hjapi.DzFrameSetAlpha(SLBuffTxt[idxs], transparency)
                                            hjapi.DzFrameSetAlpha(SLBuffExts[idxs], transparency)
                                            hjapi.DzFrameSetAlpha(SLBuffBorders[idxs], transparency)
                                        else
                                            hjapi.DzFrameSetAlpha(SLBuffTxt[idxs], 255)
                                            hjapi.DzFrameSetAlpha(SLBuffExts[idxs], 255)
                                            hjapi.DzFrameSetAlpha(SLBuffBorders[idxs], 255)
                                        end
                                    end
                                end
                            end
                        end

                    end


                end
            end
            for k, _ in ipairs(SLBuffBtns) do
                if (enumPlayer == hplayer.loc()) then
                    if (show and showIdx[k] == true) then
                        hjapi.DzFrameShow(SLBuffExts[k], true)
                    else
                        hjapi.DzFrameShow(SLBuffExts[k], false)
                    end
                end
            end
        end)
    end)


end
