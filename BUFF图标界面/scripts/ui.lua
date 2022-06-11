hjapi.DzEnableWideScreen(true)
--hjapi.DzFrameHideInterface()
--hjapi.DzFrameEditBlackBorders(0, 0)

UI = function()
    hjapi.DzLoadToc("UI\\frame.toc")

    UI_ABILITY_MAX = 11 * 2 --最大buff数,偶数

    local bagRx = 0.016
    local bagRy = bagRx * (8 / 6)

    local _buffBtns = {}
    local _buffTxt = {}
    local _buffExts = {}
    local _buffBorders = {}

    for i = 1, UI_ABILITY_MAX do
        local x = -0.084 + bagRx * (i - 1)
        local y = 0.142
        local half = UI_ABILITY_MAX / 2
        if (i > half) then
            x = -0.084 + bagRx * (i - half - 1)
            y = 0.142 + bagRy
        end

        --buff图标
        _buffExts[i] = hjapi.FrameTag("BACKDROP", "sdk_buff->ext->" .. i, hjapi.DzGetGameUI(), "")
        hjapi.DzFrameSetPoint(_buffExts[i], 7, hjapi.DzGetGameUI(), 7, x, y)
        hjapi.DzFrameSetSize(_buffExts[i], bagRx, bagRy)
        hjapi.DzFrameShow(_buffExts[i], false)

        --三角图标
        _buffBorders[i] = hjapi.FrameTag("BACKDROP", "sdk_buff->border->" .. i, _buffExts[i], "")
        hjapi.DzFrameSetPoint(_buffBorders[i], 4, _buffExts[i], 4, 0, 0)
        hjapi.DzFrameSetSize(_buffBorders[i], bagRx, bagRy)
        hjapi.DzFrameShow(_buffBorders[i], true)

        --时间文本
        _buffTxt[i] = hjapi.FrameTag("TEXT", "T666", _buffExts[i])
        hjapi.DzFrameSetText(_buffTxt[i], "")
        hjapi.DzFrameSetPoint(_buffTxt[i], 4, _buffExts[i], 4, 0, 0)
        hjapi.DzFrameShow(_buffTxt[i], true)

        --按钮
        _buffBtns[i] = hjapi.FrameTag("BUTTON", "sdk_buff->btn->" .. i, _buffExts[i], nil)
        hjapi.DzFrameSetPoint(_buffBtns[i], 4, _buffExts[i], 4, 0, 0)
        hjapi.DzFrameSetSize(_buffBtns[i], bagRx, bagRy)
        hjapi.DzFrameShow(_buffBtns[i], true)
    end

    htime.setInterval(0.1, function(_)
        if (hplayer.loc() == hplayer.loc()) then
            local selection = hplayer.getSelection(hplayer.loc())
            local show = false
            local showIdx = {}
            if (hplayer.isPlaying(hplayer.loc()) and selection ~= nil) then
                if (hunit.isAlive(selection)) then
                    local buffHandle = hcache.get(selection, BUFF_KEY)
                    if (buffHandle ~= nil) then
                        show = true
                        local sort = {}
                        for _, bk in ipairs(CONST_ATTR_KEYS) do
                            if (type(buffHandle[bk]) == "table") then
                                for _, bidx in ipairs(buffHandle[bk]._idx) do
                                    local curBuff = buffHandle[bk][bidx]
                                    local diff = curBuff.diff
                                    local signal = ""
                                    if (diff > 0) then
                                        signal = "buffIcon\\up.tga"
                                    else
                                        signal = "buffIcon\\down.tga"
                                    end
                                    local label, icon
                                    if (BUFF_DISPLAY_KV[bk]) then
                                        label = BUFF_DISPLAY_KV[bk].label
                                        icon = BUFF_DISPLAY_KV[bk].icon
                                    else
                                        label = "未命名key:" .. bk
                                        icon = "ReplaceableTextures\\TeamColor\\TeamColor12.blp"
                                    end
                                    local s = {
                                        key = bk,
                                        diff = diff,
                                        signal = signal,
                                        label = label,
                                        icon = icon,
                                        remain = math.round(curBuff.times.remain(), 1)
                                    }
                                    table.insert(sort, s)
                                end
                            end
                        end
                        --排序
                        table.sort(sort, function(a, b)
                            return a.key < b.key
                        end)
                        if (show) then
                            for idxs, v in ipairs(sort) do
                                if (idxs < UI_ABILITY_MAX) then
                                    showIdx[idxs] = true
                                    local t = v.remain
                                    hjapi.DzFrameSetTexture(_buffBorders[idxs], v.signal, false)
                                    hjapi.DzFrameSetText(_buffTxt[idxs], t)
                                    hjapi.DzFrameSetTexture(_buffExts[idxs], v.icon, false)
                                    if (t <= 3) then
                                        local transparency = 50 + 255 * t / 3
                                        hjapi.DzFrameSetAlpha(_buffTxt[idxs], transparency)
                                        hjapi.DzFrameSetAlpha(_buffExts[idxs], transparency)
                                        hjapi.DzFrameSetAlpha(_buffBorders[idxs], transparency)
                                    else
                                        hjapi.DzFrameSetAlpha(_buffTxt[idxs], 255)
                                        hjapi.DzFrameSetAlpha(_buffExts[idxs], 255)
                                        hjapi.DzFrameSetAlpha(_buffBorders[idxs], 255)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            for k, _ in ipairs(_buffBtns) do
                if (show and showIdx[k] == true) then
                    hjapi.DzFrameShow(_buffExts[k], true)
                else
                    hjapi.DzFrameShow(_buffExts[k], false)
                end
            end
        end
    end)
end