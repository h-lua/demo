--- 记录demo所有UI的变量
local demoCache = {}

--- 框架自带的demo
--- !仅供参考，切勿乱用!
--- 玩家、选择单位的属性显示
--- 需要在main函数前 hideInterface()
--[[
    options = {
        target_hp_unit = 5000, --目标单位单条血量
    }
]]
return {
    data = demoCache,
    ---@param options table
    run = function(options)
        options = options or {}
        options.target_hp_unit = options.target_hp_unit or 5000
        options.hp_y = options.hp_y or 0.0038
        options.mp_y = options.mp_y or 0.0038
        --
        cj.FogMaskEnable(false)
        hdzui.loadToc("UI\\frame.toc")
        local width = 3200
        local height = 562.5
        local size_x = 0.8
        local size_y = height / width * size_x
        local _x = function(num)
            return num / width * size_x
        end
        local _y = function(num)
            return -(num - (1024 - height)) / height * size_y
        end
        local pxItx0 = 1982.1888
        local pxIty0 = 608.2505
        local pxSkx0 = 1278
        local pxSky0 = 570
        local pxIt = 125
        local pxItx = 10.5
        local pxIty = 8.5
        local pxSk = 154
        local pxSkx = 8.4
        local pxSky = 8.4
        local px = {
            minMap = { w = _x(406.5), h = _x(404.6171), x = _x(16.2112), y = _y(595.8818) },
            minMapBtn = {
                { w = _x(57.3752), h = _x(49.0005), x = _x(450.1169), y = _y(603.6252) },
                { w = _x(57.3752), h = _x(49.0005), x = _x(450.1169), y = _y(667.1378) },
                { w = _x(57.3752), h = _x(49.0005), x = _x(450.1169), y = _y(733.2279) },
                { w = _x(57.3752), h = _x(49.0005), x = _x(450.1169), y = _y(798.1465) },
                { w = _x(51.9999), h = _x(48.2053), x = _x(453.3563), y = _y(881.1255) },
            },
            portrait = { w = _x(506.5595), h = _x(347.5005), x = _x(732.1953), y = _y(400) },
            name = { w = _x(341.9895), h = _x(61.1439), x = _x(1426.8867), y = _y(489.5215) },
            hp = { w = _x(638), h = _x(50), x = _x(1280), y = _y(900) },
            mp = { w = _x(638), h = _x(50), x = _x(1280), y = _y(960) },
            info = { w = _x(461.1502), h = _x(255.7398), x = _x(764.8712), y = _y(763.868) },
            sell = { w = _x(264.8081), h = _x(48.071), x = _x(1988.7271), y = _y(524.8218) },
            resource = { w = _x(403.542), h = _x(171.6668), x = _x(2788.0591), y = _y(854.5002) },
            item = {
                { w = _x(pxIt), h = _x(pxIt), x = _x(pxItx0), y = _y(pxIty0) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(pxItx0 + (pxIt + pxItx)), y = _y(pxIty0) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(pxItx0), y = _y(pxIty0 + (pxIt + pxIty)) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(pxItx0 + (pxIt + pxItx)), y = _y(pxIty0 + (pxIt + pxIty)) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(pxItx0), y = _y(pxIty0 + (pxIt + pxIty) * 2) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(pxItx0 + (pxIt + pxItx)), y = _y(pxIty0 + (pxIt + pxIty) * 2) },
            },
            skill = {
                { w = 0, h = 0, x = -0.5, y = -0.5 }, -- 这套UI隐藏前4个技能
                { w = 0, h = 0, x = -0.5, y = -0.5 }, -- 这套UI隐藏前4个技能
                { w = 0, h = 0, x = -0.5, y = -0.5 }, -- 这套UI隐藏前4个技能
                { w = 0, h = 0, x = -0.5, y = -0.5 }, -- 这套UI隐藏前4个技能
                { w = _x(pxSk), h = _x(pxSk), x = _x(pxSkx0), y = _y(pxSky0) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(pxSkx0 + (pxSk + pxSkx)), y = _y(pxSky0) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(pxSkx0 + (pxSk + pxSkx) * 2), y = _y(pxSky0) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(pxSkx0 + (pxSk + pxSkx) * 3), y = _y(pxSky0) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(pxSkx0), y = _y(pxSky0 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(pxSkx0 + (pxSk + pxSkx)), y = _y(pxSky0 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(pxSkx0 + (pxSk + pxSkx) * 2), y = _y(pxSky0 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(pxSkx0 + (pxSk + pxSkx) * 3), y = _y(pxSky0 + (pxSk + pxSky)) },
            },
        }
        local targetHPColors = {
            "hLua\\ui\\bar_red.tga",
            "hLua\\ui\\bar_blue.tga",
            "hLua\\ui\\bar_green.tga",
            "hLua\\ui\\bar_orange.tga",
            "hLua\\ui\\bar_blue2.tga",
            "hLua\\ui\\bar_green2.tga",
            "hLua\\ui\\bar_yellow.tga",
        }
        --
        demoCache.game = hdzui.origin.game()
        -- 底部命令区
        demoCache.main = hdzui.frame("main", demoCache.game)
        hjapi.DzFrameSetAlpha(demoCache.main, 240)
        hdzui.frameSize(demoCache.main, size_x, size_x * (height / width))
        hdzui.framePoint(demoCache.main, demoCache.game, FRAME_ALIGN_BOTTOM, FRAME_ALIGN_BOTTOM, 0, 0)
        -- 设置
        local txt = {
            { "F1", "F1  英雄" },
            { "F8", "F8  信使" },
            { "F9", "F9  帮助" },
            { "F10", "F10 菜单" },
            { "F11", "F11 盟友" },
            { "F12", "F12 消息" },
        }
        for i, t in ipairs(txt) do
            demoCache[t[1]] = hdzui.frameTag("TEXT", "txt_10l", demoCache.game)
            hdzui.framePoint(demoCache[t[1]], demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.item[2].x + 0.05, px.item[2].y - (i - 1) * 0.016)
            hdzui.frameSetText(demoCache[t[1]], t[2])
        end
        --- 系统消息框
        demoCache.unitMessage = hdzui.origin.unitMessage()
        hdzui.frameSize(demoCache.unitMessage, 0.2, 0.1)
        hdzui.framePoint(demoCache.unitMessage, demoCache.main, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_LEFT_TOP, px.minMap.x + 0.01, -0.01)
        hdzui.frameToggle(demoCache.unitMessage, true)
        --- 上方消息框
        demoCache.topMessage = hdzui.origin.topMessage()
        hdzui.framePoint(demoCache.topMessage, demoCache.game, FRAME_ALIGN_TOP, FRAME_ALIGN_TOP, 0, -0.04)
        hdzui.frameToggle(demoCache.topMessage, true)
        -- 小地图
        demoCache.minMap = hdzui.origin.miniMap()
        hdzui.frameSize(demoCache.minMap, px.minMap.w, px.minMap.h)
        hdzui.framePoint(demoCache.minMap, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.minMap.x, px.minMap.y)
        -- 小地图按钮
        demoCache.minMapBtn = hdzui.origin.miniMapBtn()
        for i, f in ipairs(demoCache.minMapBtn) do
            hdzui.frameToggle(f, true)
            hdzui.frameSize(f, px.minMapBtn[i].w, px.minMapBtn[i].h)
            hdzui.framePoint(f, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.minMapBtn[i].x, px.minMapBtn[i].y)
        end
        --- 单位大头像
        demoCache.portrait = hdzui.origin.portrait()
        hdzui.frameToggle(demoCache.portrait, true)
        hdzui.frameSize(demoCache.portrait, px.portrait.w, px.portrait.h)
        hdzui.framePoint(demoCache.portrait, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.portrait.x, px.portrait.y)
        --- 聊天消息
        demoCache.chatMessage = hdzui.origin.chatMessage()
        hdzui.frameSize(demoCache.chatMessage, 0.18, 0.2)
        hdzui.framePoint(demoCache.chatMessage, demoCache.main, FRAME_ALIGN_BOTTOM, FRAME_ALIGN_TOP, 0, 0.015)
        hdzui.frameToggle(demoCache.chatMessage, true)
        --- 物品栏
        demoCache.itemSlot = hdzui.origin.itemSlot()
        demoCache.itemSlotBlock = {}
        for i, f in ipairs(demoCache.itemSlot) do
            hdzui.frameSize(f, px.item[i].w, px.item[i].w)
            hdzui.framePoint(f, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.item[i].x, px.item[i].y)
            hdzui.frameToggle(f, true)
            local block = hdzui.frameTag("BACKDROP", "bg_block", demoCache.main)
            hdzui.framePoint(block, f, FRAME_ALIGN_CENTER, FRAME_ALIGN_CENTER, 0, 0)
            hdzui.frameSize(block, px.item[i].w, px.item[i].w)
            hjapi.DzFrameSetAlpha(block, 127)
            table.insert(demoCache.itemSlotBlock, block)
        end
        --- 鼠标提示
        demoCache.tooltip = hdzui.origin.tooltip()
        hdzui.framePoint(demoCache.tooltip, demoCache.itemSlot[1], FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_LEFT_TOP, -0.002, 0.03)
        hdzui.frameToggle(demoCache.tooltip, true)
        --- 技能栏
        demoCache.skillSlot = hdzui.origin.skill()
        demoCache.skillSlotBlock = {}
        for i, sk in ipairs(demoCache.skillSlot) do
            hdzui.frameSize(sk, px.skill[i].w, px.skill[i].w)
            hdzui.framePoint(sk, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.skill[i].x, px.skill[i].y)
            hdzui.frameToggle(sk, true)
            local block = hdzui.frameTag("BACKDROP", "bg_block", demoCache.main)
            hdzui.framePoint(block, sk, FRAME_ALIGN_CENTER, FRAME_ALIGN_CENTER, 0, 0)
            hdzui.frameSize(block, px.skill[i].w, px.skill[i].w)
            hjapi.DzFrameSetAlpha(block, 127)
            table.insert(demoCache.skillSlotBlock, block)
        end
        -- 条:长度
        local bar_width = 0.082
        local target_width = 0.2126
        local moreBtns = { "more_attr", "more_x_up", "more_x_tras", "more_x_oppose", "more_e_attack", "more_e_up", "more_e_append", "more_e_oppose" }
        -- 之后下面是自定义UI
        -- 每个周期都更新UI
        demoCache.update = function()
            hplayer.forEach(function(enumPlayer, idx)
                if (cj.GetLocalPlayer() == enumPlayer) then
                    hdzui.frameSetText(demoCache.gold, hcolor.mixed(hplayer.getGold(enumPlayer), "E7B730"))
                    hdzui.frameSetText(demoCache.lumber, hcolor.mixed(hplayer.getLumber(enumPlayer), "C47A3A"))
                    hdzui.frameSetText(demoCache.gold_ratio, hcolor.grey(hplayer.getGoldRatio(enumPlayer) .. "%"))
                    hdzui.frameSetText(demoCache.lumber_ratio, hcolor.grey(hplayer.getLumberRatio(enumPlayer) .. "%"))
                    hdzui.frameSetText(demoCache.sell_ratio, "售卖率:" .. hplayer.getSellRatio(enumPlayer) .. "%")
                    hdzui.frameSetText(demoCache.exp_ratio, "经验率:" .. hplayer.getExpRatio(enumPlayer) .. "%")
                end
                local show = false
                local isHero = false
                local isPeriod = false
                local isOpenPunish = false
                local isBarE1 = false
                local isBarE2 = false
                local isBarExp = false
                local isBarPeriod = false
                local isBarPunish = false
                local selection
                local data = {}
                local lastTarget
                local attrBuilder = function(label, def, defCheck, buffs, isPositive, val, unit)
                    if (defCheck == true) then
                        return hcolor.grey(label .. ":" .. def)
                    end
                    local sUp = "+"
                    local sDown = "-"
                    if (isPositive == false) then
                        sUp = "-"
                        sDown = "+"
                    end
                    local up = 0
                    local down = 0
                    if (type(buffs) == "table") then
                        for _, bk in ipairs(buffs) do
                            up = up + hbuff.count(selection, "attr." .. bk .. sUp)
                            down = down + hbuff.count(selection, "attr." .. bk .. sDown)
                        end
                    end
                    local atr
                    if (up == down) then
                        atr = label .. ":" .. val .. unit
                    elseif (up > down) then
                        atr = label .. ":" .. hcolor.green(val .. unit)
                    else
                        atr = label .. ":" .. hcolor.red(val .. unit)
                    end
                    return atr
                end
                if (his.playing(enumPlayer)) then
                    selection = hplayer.getSelection(enumPlayer)
                    lastTarget = hevent.getPlayerLastDamageTarget(enumPlayer)
                    if (selection ~= nil) then
                        local attr = hattribute.get(selection)
                        if (attr ~= nil and his.alive(selection) and false == his.deleted(selection)) then
                            show = true
                            isHero = his.hero(selection)
                            local primary = hhero.getPrimary(selection)
                            isPeriod = hunit.getPeriod(selection) > 0
                            isOpenPunish = hunit.isPunishing(selection)
                            isBarE1 = isPeriod or isHero
                            isBarE2 = isOpenPunish
                            isBarExp = isHero
                            isBarPeriod = isPeriod
                            isBarPunish = isOpenPunish
                            -- sign
                            if (primary == "STR") then
                                data.sign = "hLua\\ui\\sign_str.tga"
                            elseif (primary == "AGI") then
                                data.sign = "hLua\\ui\\sign_agi.tga"
                            elseif (primary == "INT") then
                                data.sign = "hLua\\ui\\sign_int.tga"
                            elseif (his.canAttack(selection) and his.melee(selection)) then
                                data.sign = "hLua\\ui\\sign_melee.tga"
                            elseif (his.canAttack(selection) and his.ranged(selection)) then
                                data.sign = "hLua\\ui\\sign_ranged.tga"
                            else
                                data.sign = "hLua\\ui\\sign_nor.tga"
                            end
                            -- 生命
                            local hpc = math.floor(hunit.getCurLife(selection))
                            local hpm = math.floor(hunit.getMaxLife(selection))
                            data.hp = hpc .. "/" .. hpm
                            data.bar_hp_texture = "hLua\\ui\\bar_green2.tga"
                            if (hpm <= 0) then
                                data.bar_hp_e = 1
                            else
                                if (hpc < hpm * 0.33) then
                                    data.bar_hp_texture = "hLua\\ui\\bar_red.tga"
                                elseif (hpc < hpm * 0.50) then
                                    data.bar_hp_texture = "hLua\\ui\\bar_orange.tga"
                                elseif (hpc < hpm * 0.66) then
                                    data.bar_hp_texture = "hLua\\ui\\bar_yellow.tga"
                                end
                                data.bar_hp_e = 1 - math.min(1, math.round(hpc / hpm, 2))
                            end
                            -- 魔法
                            local mpc = math.floor(hunit.getCurMana(selection))
                            local mpm = math.floor(hunit.getMaxMana(selection))
                            data.mp = mpc .. "/" .. mpm
                            if (mpm <= 0) then
                                data.bar_mp_e = 1
                            else
                                data.bar_mp_e = 1 - math.min(1, math.round(mpc / mpm, 2))
                            end
                            -- 治疗加成
                            local cure = 1 + 0.01 * (attr.cure or 0)
                            -- 生命恢复
                            data.life_back = ""
                            if (hpm > 0 and data.bar_hp_e > 0) then
                                local life_back = math.round(attr.life_back * cure, 1)
                                if (life_back > hattr.CURE_FLOOR) then
                                    data.life_back = "+" .. math.numberFormat(life_back, 1)
                                elseif (life_back < -hattr.CURE_FLOOR) then
                                    data.life_back = math.numberFormat(life_back, 1)
                                else
                                    data.life_back = "+0.00"
                                end
                            end
                            -- 魔法恢复
                            data.mana_back = ""
                            if (mpm > 0 and data.bar_mp_e > 0) then
                                local mana_back = math.round(attr.mana_back * cure, 1)
                                if (mana_back > hattr.CURE_FLOOR) then
                                    data.mana_back = "+" .. math.numberFormat(mana_back, 1)
                                elseif (mana_back < -hattr.CURE_FLOOR) then
                                    data.mana_back = math.numberFormat(mana_back, 1)
                                else
                                    data.mana_back = "+0.00"
                                end
                            end
                            -- 名称
                            data.unit_name = hunit.getName(selection)
                            if (isHero) then
                                data.unit_name = data.unit_name .. "·" .. hhero.getProperName(selection)
                            end
                            data.attack = attrBuilder(
                                "攻击", "无", not his.canAttack(selection),
                                { "attack_white", "attack_green" }, true,
                                math.integerFormat(attr.attack_sides[1]) .. "-" .. math.integerFormat(attr.attack_sides[2]), "")
                            data.attack_speed = attrBuilder(
                                "攻速", "无", not his.canAttack(selection),
                                { "attack_speed" }, true,
                                math.round(attr.attack_space, 1), "秒")
                            data.attack_range = attrBuilder(
                                "攻击范围", "无", not his.canAttack(selection),
                                { "attack_range" }, true,
                                math.floor(attr.attack_range), "")
                            if (his.invincible(selection)) then
                                data.defend = "护甲:" .. hcolor.gold("无敌")
                            else
                                data.defend = attrBuilder(
                                    "护甲", "无", false,
                                    { "attack_white", "attack_green" }, true,
                                    math.floor(attr.defend), "")
                                if (his.invisible(selection)) then
                                    data.defend = data.defend .. hcolor.grey("[隐身]")
                                elseif (his.immune(selection)) then
                                    data.defend = data.defend .. hcolor.grey("[魔免]")
                                elseif (his.ethereal(selection)) then
                                    data.defend = data.defend .. hcolor.grey("[虚无]")
                                else
                                    data.defend = data.defend .. hcolor.grey("(-" .. math.round(hattribute.getArmorReducePercent(attr.defend) * 100, 1) .. "%)")
                                end
                            end
                            data.damage_reduce = attrBuilder(
                                "减伤", "无", false,
                                { "damage_reduction", "damage_decrease" }, true,
                                math.round(attr.damage_decrease, 2) .. "%+" .. math.floor(attr.damage_reduction), "")
                            data.move = attrBuilder(
                                "移动", "无", false,
                                { "move" }, true,
                                math.floor(attr.move), "")
                            if (isHero) then
                                data.str = attrBuilder(
                                    hcolor.mixed("力量", "FFA99F"), "无", false,
                                    { "str_white", "str_green" }, true,
                                    math.floor(attr.str), "")
                                data.agi = attrBuilder(
                                    hcolor.mixed("敏捷", "CBFF9E"), "无", false,
                                    { "agi_white", "agi_green" }, true,
                                    math.floor(attr.agi), "")
                                data.int = attrBuilder(
                                    hcolor.mixed("智力", "A0E1FF"), "无", false,
                                    { "int_white", "int_green" }, true,
                                    math.floor(attr.int), "")
                                data.str_plus = attrBuilder(
                                    hcolor.mixed("成长", "FFA99F"), "无", false,
                                    {}, true,
                                    "+" .. hhero.getStrPlus(selection), "")
                                data.agi_plus = attrBuilder(
                                    hcolor.mixed("成长", "CBFF9E"), "无", false,
                                    {}, true,
                                    "+" .. hhero.getAgiPlus(selection), "")
                                data.int_plus = attrBuilder(
                                    hcolor.mixed("成长", "A0E1FF"), "无", false,
                                    {}, true,
                                    "+" .. hhero.getIntPlus(selection), "")
                            end
                            if (isPeriod) then
                                local pr = hunit.getPeriodRemain(selection)
                                local p = hunit.getPeriod(selection)
                                data.period_bar = bar_width * pr / p
                                data.period_val = pr .. "秒"
                            elseif (isHero) then
                                local lv = hhero.getCurLevel(selection)
                                local e = hhero.getExp(selection)
                                local en = hhero.getExpNeed(lv + 1)
                                data.exp_bar = bar_width * e / en
                                data.exp_val = "Lv" .. lv .. "   " .. math.min(e, en) .. "/" .. en
                            end
                            if (isOpenPunish) then
                                data.punish_bar = bar_width * attr.punish_current / attr.punish
                                data.punish_val = math.floor(math.max(0, attr.punish_current)) .. "/" .. math.floor(attr.punish)
                                data.punish_danger = attr.punish_current < (0.3 * attr.punish)
                                data.punish_oppose = "抵抗率:" .. math.floor(math.min(100, attr.punish_oppose)) .. "%"
                            end
                            -- more
                            for i, _ in ipairs(moreBtns) do
                                local s = {}
                                local maxLen = 0
                                local offsetLen = 0
                                local sIn = function(st, sColor)
                                    maxLen = math.max(maxLen, string.mb_len(st))
                                    if (sColor) then
                                        st = hcolor.mixed(st, sColor)
                                    end
                                    table.insert(s, st)
                                end
                                if (i == 1) then
                                    --more_attr
                                    if (isHero) then
                                        offsetLen = -0.02
                                        sIn("每1点[" .. hhero.getPrimaryLabel(selection) .. "]：" .. "+1 攻击【主】", "FFFF00")
                                        sIn("每1点[力量]：" .. "+8 生命", "ED877B")
                                        sIn("每1点[力量]：" .. "+5 硬直", "ED877B")
                                        sIn("每1点[敏捷]：" .. "+0.1% 攻速", "CCFF9F")
                                        sIn("每1点[敏捷]：" .. "+0.1% 命中", "CCFF9F")
                                        sIn("每1点[智力]：" .. "+6 魔法", "A1E1FF")
                                        sIn("每1点[智力]：" .. "+0.0625 魔法恢复", "A1E1FF")
                                        sIn("每1Kg[负重]：" .. "-1 移动", "FE3C35")
                                    else
                                        offsetLen = 0.03
                                        sIn("一个普通单位", "c0c0c0")
                                    end
                                elseif (i == 2) then
                                    --more_x_up
                                    offsetLen = 0.01
                                    if (attr.reborn < 0) then
                                        sIn("不能复活", "c0c0c0")
                                    else
                                        sIn("复活时间：" .. math.round(attr.reborn, 1) .. "秒")
                                    end
                                    if (his.hasSlot(selection)) then
                                        sIn("负重：" .. math.round(attr.weight_current, 2) .. "/" .. math.round(attr.weight, 2) .. "Kg")
                                    end
                                    sIn("无敌几率：" .. math.round(attr.invincible, 2) .. "%")
                                    if (his.canAttack(selection)) then
                                        sIn("暴击加成：" .. math.round(attr.knocking_extent, 2) .. "%")
                                        sIn("暴击几率：" .. math.round(attr.knocking_odds, 2) .. "%")
                                        sIn("攻击吸血：" .. math.round(attr.hemophagia, 2) .. "%")
                                        sIn("技能吸血：" .. math.round(attr.hemophagia_skill, 2) .. "%")
                                    end
                                    sIn("治疗加成：" .. math.round(attr.cure, 2) .. "%")
                                    sIn("回避几率：" .. math.round(attr.avoid, 2) .. "%")
                                    sIn("命中加成：" .. math.round(attr.aim, 2) .. "%")
                                    sIn("伤害增幅：" .. math.round(attr.damage_extent, 2) .. "%")
                                    sIn("反弹伤害：" .. math.round(attr.damage_rebound, 2) .. "%")
                                    sIn("白天视野：" .. math.floor(attr.sight_day))
                                    sIn("黑夜视野：" .. math.floor(attr.sight_night))
                                elseif (i == 3) then
                                    --more_x_tras
                                    local xtras = attr.xtras or {}
                                    if (#xtras > 0) then
                                        offsetLen = -0.018
                                        local xu = CONST_UBERTIP_ATTR_XTRAS(table.value(xtras, "_t"))
                                        local mx = { str = {}, num = {} }
                                        for _, xv in ipairs(xu) do
                                            if (mx.num[xv] == nil) then
                                                mx.num[xv] = 1
                                                table.insert(mx.str, xv)
                                            else
                                                mx.num[xv] = mx.num[xv] + 1
                                            end
                                        end
                                        for sti, str in ipairs(mx.str) do
                                            local color
                                            if (sti % 2 == 0) then
                                                color = "efef8f"
                                            end
                                            local split = string.mb_split(str, 32)
                                            for xvi, xvv in ipairs(split) do
                                                if (xvi == 1) then
                                                    sIn(" - " .. "[" .. mx.num[str] .. "]" .. xvv, color)
                                                else
                                                    sIn("     " .. xvv, color)
                                                end
                                            end
                                        end
                                    else
                                        offsetLen = 0.03
                                        sIn("无特殊效果", "c0c0c0")
                                    end
                                elseif (i == 4) then
                                    --more_x_oppose
                                    offsetLen = 0.01
                                    sIn("反弹伤害抵抗：" .. math.round(attr.damage_rebound_oppose, 2) .. "%")
                                    sIn("攻击吸血抵抗：" .. math.round(attr.hemophagia_oppose, 2) .. "%")
                                    sIn("技能吸血抵抗：" .. math.round(attr.hemophagia_skill_oppose, 2) .. "%")
                                    sIn("强化阻碍：" .. math.round(attr.buff_oppose, 2) .. "%")
                                    sIn("负面抵抗：" .. math.round(attr.debuff_oppose, 2) .. "%")
                                    sIn("暴击抵抗：" .. math.round(attr.knocking_oppose, 2) .. "%")
                                    sIn("分裂抵抗：" .. math.round(attr.split_oppose, 2) .. "%")
                                    sIn("僵直抵抗：" .. math.round(attr.punish_oppose, 2) .. "%")
                                    sIn("眩晕抵抗：" .. math.round(attr.swim_oppose, 2) .. "%")
                                    sIn("打断抵抗：" .. math.round(attr.broken_oppose, 2) .. "%")
                                    sIn("沉默抵抗：" .. math.round(attr.silent_oppose, 2) .. "%")
                                    sIn("缴械抵抗：" .. math.round(attr.unarm_oppose, 2) .. "%")
                                    sIn("定身抵抗：" .. math.round(attr.fetter_oppose, 2) .. "%")
                                    sIn("爆破抵抗：" .. math.round(attr.bomb_oppose, 2) .. "%")
                                    sIn("闪电链抵抗：" .. math.round(attr.lightning_chain_oppose, 2) .. "%")
                                    sIn("击飞抵抗：" .. math.round(attr.crack_fly_oppose, 2) .. "%")
                                elseif (i == 5) then
                                    --more_e_attack
                                    offsetLen = 0.02
                                    for _, v in ipairs(CONST_ENCHANT) do
                                        sIn(v.label .. "攻击：" .. math.floor(attr["e_" .. v.value .. "_attack"]) .. "级", v.color)
                                    end
                                elseif (i == 6) then
                                    --more_e_up
                                    offsetLen = 0.02
                                    for _, v in ipairs(CONST_ENCHANT) do
                                        sIn(v.label .. "伤害加成：" .. math.floor(attr["e_" .. v.value]) .. "%", v.color)
                                    end
                                elseif (i == 7) then
                                    --more_e_append
                                    offsetLen = 0.02
                                    for _, v in ipairs(CONST_ENCHANT) do
                                        sIn(v.label .. "附着：" .. math.floor(attr["e_" .. v.value .. "_append"]) .. "层", v.color)
                                    end
                                elseif (i == 8) then
                                    --more_e_oppose
                                    offsetLen = 0.01
                                    for _, v in ipairs(CONST_ENCHANT) do
                                        sIn(v.label .. "抗性：" .. math.round(attr["e_" .. v.value .. "_oppose"], 2) .. "%", v.color)
                                    end
                                end
                                local w = maxLen * 0.007 + offsetLen
                                local h = #s * 0.010 + 0.025
                                cj.SaveStr(cg.hLuaDemoHash, idx, i, string.implode("|n", s))
                                cj.SaveReal(cg.hLuaDemoHash, idx, 20 + i, w)
                                cj.SaveReal(cg.hLuaDemoHash, idx, 30 + i, h)
                            end
                        end
                    end
                    -- 目标数据
                    if (lastTarget) then
                        if (his.dead(lastTarget) or his.deleted(lastTarget)) then
                            lastTarget = nil
                            if (selection) then
                                hevent.setLastDamage(selection, nil)
                            end
                        end
                        if (lastTarget ~= nil) then
                            local ml = math.floor(hunit.getMaxLife(lastTarget)) or 0
                            local cl = math.floor(hunit.getCurLife(lastTarget)) or 0
                            if (ml > 0 and cl > 0) then
                                local HPUnit = math.min(options.target_hp_unit, ml)
                                data.target_ava = hunit.getAvatar(lastTarget)
                                local tr = math.ceil(cl / HPUnit)
                                if (tr > 0) then
                                    data.target_tl = "等级" .. cj.GetUnitLevel(lastTarget) .. " " .. hunit.getName(lastTarget) .. "      " .. cl .. "/" .. ml
                                    data.target_tr = ""
                                    data.target_val1 = nil
                                    data.target_val2 = tr % (#targetHPColors + 1)
                                    if (demoCache.target_val2_prev ~= data.target_val2) then
                                        demoCache.target_val_prev = nil
                                    end
                                    demoCache.target_val2_prev = data.target_val2
                                    if (tr > 1) then
                                        data.target_tr = "X " .. tr
                                        if (data.target_val2 == 0) then
                                            data.target_val1 = #targetHPColors
                                        else
                                            data.target_val1 = data.target_val2 - 1
                                        end
                                    end
                                end
                                data.target_val = (cl % HPUnit) / HPUnit
                                if (hunit.isPunishing(lastTarget)) then
                                    data.target_pv = target_width * hattribute.get(lastTarget, "punish_current") / hattribute.get(lastTarget, "punish")
                                else
                                    data.target_pv = 0
                                end
                            else
                                lastTarget = nil
                            end
                        end
                    end
                    if (show == false) then
                        hcache.set(enumPlayer, CONST_CACHE.PLAYER_SELECTION, nil)
                    end
                end
                if (cj.GetLocalPlayer() == enumPlayer) then
                    if (show == true) then
                        hdzui.frameSetText(demoCache.hp, data.hp)
                        hdzui.frameSetText(demoCache.mp, data.mp)
                        hjapi.DzFrameSetTexture(demoCache.bar_hp, data.bar_hp_texture, false)
                        if (data.bar_hp_e > 0) then
                            hdzui.frameSize(demoCache.bar_hp_e, px.hp.w * data.bar_hp_e, px.hp.h)
                        end
                        if (data.bar_mp_e > 0) then
                            hdzui.frameSize(demoCache.bar_mp_e, px.mp.w * data.bar_mp_e, px.mp.h)
                        end
                        hdzui.frameSetText(demoCache.life_back, data.life_back)
                        hdzui.frameSetText(demoCache.mana_back, data.mana_back)
                        hjapi.DzFrameSetTexture(demoCache.sign, data.sign)
                        hdzui.frameSetText(demoCache.unit_name, data.unit_name)
                        hdzui.frameSetText(demoCache.attack, data.attack)
                        hdzui.frameSetText(demoCache.attack_speed, data.attack_speed)
                        hdzui.frameSetText(demoCache.attack_range, data.attack_range)
                        hdzui.frameSetText(demoCache.defend, data.defend)
                        hdzui.frameSetText(demoCache.damage_reduce, data.damage_reduce)
                        hdzui.frameSetText(demoCache.move, data.move)
                        if (isHero) then
                            hdzui.frameSetText(demoCache.str, data.str)
                            hdzui.frameSetText(demoCache.str_plus, data.str_plus)
                            hdzui.frameSetText(demoCache.agi, data.agi)
                            hdzui.frameSetText(demoCache.agi_plus, data.agi_plus)
                            hdzui.frameSetText(demoCache.int, data.int)
                            hdzui.frameSetText(demoCache.int_plus, data.int_plus)
                        end
                        if (isPeriod) then
                            hdzui.frameSetText(demoCache.period_val, hcolor.mixed(data.period_val, "26BD08"))
                            if (data.period_bar > 0) then
                                hdzui.frameSize(demoCache.bar_period, data.period_bar, 0.002)
                            else
                                isBarPeriod = false
                            end
                        elseif (isHero) then
                            hdzui.frameSetText(demoCache.exp_val, hcolor.mixed(data.exp_val, "3096FC"))
                            if (data.exp_bar > 0) then
                                hdzui.frameSize(demoCache.bar_exp, data.exp_bar, 0.002)
                            else
                                isBarExp = false
                            end
                        end
                        if (isOpenPunish) then
                            hdzui.frameSetText(demoCache.punish_oppose, data.punish_oppose)
                            if (his.punish(selection)) then
                                hdzui.frameSetText(demoCache.punish, hcolor.mixed("僵住", "FC362E"))
                                hdzui.frameSetText(demoCache.punish_val, hcolor.mixed(data.punish_val, "FC362E"))
                            else
                                if (data.punish_danger) then
                                    hdzui.frameSetText(demoCache.punish, hcolor.mixed("硬直", "FC362E"))
                                    hdzui.frameSetText(demoCache.punish_val, hcolor.mixed(data.punish_val, "FC362E"))
                                else
                                    hdzui.frameSetText(demoCache.punish, hcolor.mixed("硬直", "FFCB2D"))
                                    hdzui.frameSetText(demoCache.punish_val, hcolor.mixed(data.punish_val, "FFCB2D"))
                                end
                            end
                            if (data.punish_bar > 0) then
                                hdzui.frameSize(demoCache.bar_punish, data.punish_bar, 0.002)
                                if (data.punish_danger) then
                                    hjapi.DzFrameSetTexture(demoCache.bar_punish, "hLua\\ui\\bar_red.tga", false)
                                else
                                    hjapi.DzFrameSetTexture(demoCache.bar_punish, "hLua\\ui\\bar_yellow.tga", false)
                                end
                            else
                                isBarPunish = false
                            end
                        end
                    end
                    for i, f in ipairs(demoCache.itemSlotBlock) do
                        hjapi.DzFrameShow(f, not (show and (cj.UnitItemInSlot(selection, i - 1) ~= nil)))
                    end
                    for _, f in ipairs(demoCache.skillSlotBlock) do
                        hjapi.DzFrameShow(f, not show)
                    end
                    hjapi.DzFrameShow(demoCache.bar_hp_e, show and data.bar_hp_e > 0)
                    hjapi.DzFrameShow(demoCache.bar_mp_e, show and data.bar_mp_e > 0)
                    hjapi.DzFrameShow(demoCache.bar_hp, show)
                    hjapi.DzFrameShow(demoCache.bar_mp, show)
                    hjapi.DzFrameShow(demoCache.hp, show)
                    hjapi.DzFrameShow(demoCache.mp, show)
                    hjapi.DzFrameShow(demoCache.life_back, show)
                    hjapi.DzFrameShow(demoCache.mana_back, show)
                    hjapi.DzFrameShow(demoCache.info_attr, show and (isHero == false))
                    hjapi.DzFrameShow(demoCache.info_attr_hero, show and isHero)
                    hjapi.DzFrameShow(demoCache.sign, show)
                    hjapi.DzFrameShow(demoCache.unit_name, show)
                    hjapi.DzFrameShow(demoCache.attack, show)
                    hjapi.DzFrameShow(demoCache.attack_speed, show)
                    hjapi.DzFrameShow(demoCache.attack_range, show)
                    hjapi.DzFrameShow(demoCache.defend, show)
                    hjapi.DzFrameShow(demoCache.damage_reduce, show)
                    hjapi.DzFrameShow(demoCache.move, show)
                    hjapi.DzFrameShow(demoCache.str, show and isHero)
                    hjapi.DzFrameShow(demoCache.str_plus, show and isHero)
                    hjapi.DzFrameShow(demoCache.agi, show and isHero)
                    hjapi.DzFrameShow(demoCache.agi_plus, show and isHero)
                    hjapi.DzFrameShow(demoCache.int, show and isHero)
                    hjapi.DzFrameShow(demoCache.int_plus, show and isHero)
                    hjapi.DzFrameShow(demoCache.period, show and isPeriod)
                    hjapi.DzFrameShow(demoCache.period_val, show and isPeriod)
                    hjapi.DzFrameShow(demoCache.exp, show and (not isPeriod) and isHero)
                    hjapi.DzFrameShow(demoCache.exp_val, show and (not isPeriod) and isHero)
                    hjapi.DzFrameShow(demoCache.exp_ratio, show and (not isPeriod) and isHero)
                    hjapi.DzFrameShow(demoCache.punish, show and isOpenPunish)
                    hjapi.DzFrameShow(demoCache.punish_val, show and isOpenPunish)
                    hjapi.DzFrameShow(demoCache.punish_oppose, show and isOpenPunish)
                    hjapi.DzFrameShow(demoCache.bar_e1, show and isBarE1)
                    hjapi.DzFrameShow(demoCache.bar_e2, show and isBarE2)
                    hjapi.DzFrameShow(demoCache.bar_period, show and isBarPeriod)
                    hjapi.DzFrameShow(demoCache.bar_exp, show and (not isPeriod) and isBarExp)
                    hjapi.DzFrameShow(demoCache.bar_punish, show and isBarPunish)
                    if (lastTarget ~= nil) then
                        hjapi.DzFrameSetTexture(demoCache.target_ava, data.target_ava)
                        hdzui.frameSetText(demoCache.target_tl, data.target_tl)
                        hdzui.frameSetText(demoCache.target_tr, data.target_tr)
                        local cur = data.target_val * target_width
                        local next = cur
                        local step = target_width / 100
                        if (demoCache.target_val_prev ~= nil) then
                            if (cur < demoCache.target_val_prev and (demoCache.target_val_prev - cur) > step) then
                                next = demoCache.target_val_prev - step
                            elseif (cur > demoCache.target_val_prev and (cur - demoCache.target_val_prev) > step) then
                                next = demoCache.target_val_prev + step
                            end
                        end
                        demoCache.target_val_prev = next
                        hdzui.frameSize(demoCache.target_val2, next, 0)
                        if (data.target_val1 ~= nil) then
                            hjapi.DzFrameSetTexture(demoCache.target_val1, targetHPColors[data.target_val1])
                        end
                        if (data.target_pv > 0) then
                            hdzui.frameSize(demoCache.target_pv, data.target_pv, 0)
                        end
                        hjapi.DzFrameSetTexture(demoCache.target_val2, targetHPColors[data.target_val2])
                        hjapi.DzFrameShow(demoCache.target, true)
                        hjapi.DzFrameShow(demoCache.target_ava, true)
                        hjapi.DzFrameShow(demoCache.target_tl, true)
                        hjapi.DzFrameShow(demoCache.target_tr, true)
                        hjapi.DzFrameShow(demoCache.target_val1, data.target_val1 ~= nil)
                        hjapi.DzFrameShow(demoCache.target_val2, true)
                        hjapi.DzFrameShow(demoCache.target_pv, data.target_pv > 0)
                    else
                        hjapi.DzFrameShow(demoCache.target, false)
                        hjapi.DzFrameShow(demoCache.target_ava, false)
                        hjapi.DzFrameShow(demoCache.target_tl, false)
                        hjapi.DzFrameShow(demoCache.target_tr, false)
                        hjapi.DzFrameShow(demoCache.target_val1, false)
                        hjapi.DzFrameShow(demoCache.target_val2, false)
                        hjapi.DzFrameShow(demoCache.target_pv, false)
                    end
                    for _, bk in ipairs(moreBtns) do
                        hjapi.DzFrameShow(demoCache["btn_" .. bk], show)
                    end
                end
            end)
        end
        -- 上方目标血条
        demoCache.target = hdzui.frameTag("BACKDROP", "bg_bar_target", demoCache.game)
        hdzui.frameSize(demoCache.target, 0.24, 0.03)
        hdzui.framePoint(demoCache.target, demoCache.game, FRAME_ALIGN_CENTER, FRAME_ALIGN_TOP, 0, -0.04)
        demoCache.target_ava = hdzui.frameTag("BACKDROP", "bg_bar_avatar", demoCache.game)
        hdzui.frameSize(demoCache.target_ava, 0.02, 0.023)
        hdzui.framePoint(demoCache.target_ava, demoCache.target, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0.002, 0)
        demoCache.target_val1 = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.target)
        hdzui.frameSize(demoCache.target_val1, target_width, 0.023)
        hdzui.framePoint(demoCache.target_val1, demoCache.target, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0.0236, 0)
        demoCache.target_val2 = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.target)
        hdzui.frameSize(demoCache.target_val2, target_width, 0.023)
        hdzui.framePoint(demoCache.target_val2, demoCache.target, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0.0236, 0)
        demoCache.target_pv = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.target_pv, "hLua\\ui\\bar_yellow.tga", false)
        hdzui.frameSize(demoCache.target_pv, target_width, 0.002)
        hdzui.framePoint(demoCache.target_pv, demoCache.target, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0.0236, -0.017)
        demoCache.target_tl = hdzui.frameTag("TEXT", "txt_12l", demoCache.game)
        hdzui.framePoint(demoCache.target_tl, demoCache.target, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0.025, 0)
        demoCache.target_tr = hdzui.frameTag("TEXT", "txt_12r", demoCache.game)
        hdzui.framePoint(demoCache.target_tr, demoCache.target, FRAME_ALIGN_RIGHT, FRAME_ALIGN_RIGHT, -0.006, 0)
        -- 黄金
        demoCache.gold = hdzui.frameTag("TEXT", "txt_12l", demoCache.main)
        hdzui.framePoint(demoCache.gold, demoCache.main, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT_TOP, px.resource.x + 0.02, px.resource.y - 0.010)
        hdzui.frameSize(demoCache.gold, 0.056, 0.02)
        -- 黄金率
        demoCache.gold_ratio = hdzui.frameTag("TEXT", "txt_12l", demoCache.main)
        hdzui.framePoint(demoCache.gold_ratio, demoCache.gold, FRAME_ALIGN_LEFT, FRAME_ALIGN_RIGHT, 0, 0)
        hdzui.frameSize(demoCache.gold_ratio, 0.08, 0.02)
        -- 木头
        demoCache.lumber = hdzui.frameTag("TEXT", "txt_12l", demoCache.main)
        hdzui.framePoint(demoCache.lumber, demoCache.main, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT_TOP, px.resource.x + 0.02, px.resource.y - 0.030)
        hdzui.frameSize(demoCache.lumber, 0.056, 0.02)
        -- 木头率
        demoCache.lumber_ratio = hdzui.frameTag("TEXT", "txt_12l", demoCache.main)
        hdzui.framePoint(demoCache.lumber_ratio, demoCache.lumber, FRAME_ALIGN_LEFT, FRAME_ALIGN_RIGHT, 0, 0)
        -- 售卖率
        demoCache.sell_ratio = hdzui.frameTag("TEXT", "txt_8l", demoCache.main)
        hdzui.framePoint(demoCache.sell_ratio, demoCache.main, FRAME_ALIGN_CENTER, FRAME_ALIGN_LEFT_TOP, px.sell.x + 0.033, px.sell.y - 0.006)
        -- 单位标志
        demoCache.sign = hdzui.frame("bg_sign", demoCache.main)
        hdzui.frameSize(demoCache.sign, 0.012, 0.016)
        hdzui.framePoint(demoCache.sign, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.name.x + 0.0024, px.name.y + 0.001)
        -- 单位名称
        demoCache.unit_name = hdzui.frameTag("TEXT", "txt_10c", demoCache.main)
        hdzui.framePoint(demoCache.unit_name, demoCache.main, FRAME_ALIGN_CENTER, FRAME_ALIGN_LEFT_TOP, px.name.x + 0.0425, px.name.y - 0.007)
        -- HP条
        demoCache.bar_hp = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hdzui.frameSize(demoCache.bar_hp, px.hp.w, px.hp.h)
        hdzui.framePoint(demoCache.bar_hp, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.hp.x, px.hp.y)
        -- MP条
        demoCache.bar_mp = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_mp, "hLua\\ui\\bar_blue.tga", false)
        hdzui.frameSize(demoCache.bar_mp, px.mp.w, px.mp.h)
        hdzui.framePoint(demoCache.bar_mp, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.mp.x, px.mp.y)
        -- HP条[空]
        demoCache.bar_hp_e = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_hp_e, "ReplaceableTextures\\TeamColor\\TeamColor12.blp", false)
        hdzui.frameSize(demoCache.bar_hp_e, 0, px.hp.h)
        hdzui.framePoint(demoCache.bar_hp_e, demoCache.bar_hp, FRAME_ALIGN_RIGHT, FRAME_ALIGN_RIGHT, 0, 0)
        -- MP条[空]
        demoCache.bar_mp_e = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_mp_e, "ReplaceableTextures\\TeamColor\\TeamColor12.blp", false)
        hdzui.frameSize(demoCache.bar_mp_e, 0, px.mp.h)
        hdzui.framePoint(demoCache.bar_mp_e, demoCache.bar_mp, FRAME_ALIGN_RIGHT, FRAME_ALIGN_RIGHT, 0, 0)
        -- 生命
        demoCache.hp = hdzui.frameTag("TEXT", "txt_10c", demoCache.main)
        hdzui.framePoint(demoCache.hp, demoCache.bar_hp, FRAME_ALIGN_CENTER, FRAME_ALIGN_CENTER, 0, 0)
        -- 魔法
        demoCache.mp = hdzui.frameTag("TEXT", "txt_10c", demoCache.main)
        hdzui.framePoint(demoCache.mp, demoCache.bar_mp, FRAME_ALIGN_CENTER, FRAME_ALIGN_CENTER, 0, 0)
        -- 生命恢复
        demoCache.life_back = hdzui.frameTag("TEXT", "txt_8r", demoCache.main)
        hdzui.framePoint(demoCache.life_back, demoCache.bar_hp, FRAME_ALIGN_RIGHT, FRAME_ALIGN_RIGHT, -0.002, 0)
        -- 魔法恢复
        demoCache.mana_back = hdzui.frameTag("TEXT", "txt_8r", demoCache.main)
        hdzui.framePoint(demoCache.mana_back, demoCache.bar_mp, FRAME_ALIGN_RIGHT, FRAME_ALIGN_RIGHT, -0.002, 0)
        -- 信息面板
        demoCache.info_attr = hdzui.frame("bg_info_attr", demoCache.main)
        hdzui.frameSize(demoCache.info_attr, px.info.w, px.info.h)
        hdzui.framePoint(demoCache.info_attr, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.info.x, px.info.y)
        demoCache.info_attr_hero = hdzui.frame("bg_info_attr_hero", demoCache.main)
        hdzui.frameSize(demoCache.info_attr_hero, px.info.w, px.info.h)
        hdzui.framePoint(demoCache.info_attr_hero, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.info.x, px.info.y)
        -- 条:存在周期[字]
        demoCache.period = hdzui.frameTag("TEXT", "txt_8r", demoCache.main)
        hdzui.frameSetText(demoCache.period, hcolor.mixed("存在", "4BE943"))
        hdzui.framePoint(demoCache.period, demoCache.info_attr, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_LEFT_TOP, 0.005, 0.028)
        -- 条:经验[字]
        demoCache.exp = hdzui.frameTag("TEXT", "txt_8r", demoCache.main)
        hdzui.frameSetText(demoCache.exp, hcolor.mixed("经验", "3096FC"))
        hdzui.framePoint(demoCache.exp, demoCache.period, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, 0, 0)
        -- 条:硬直[字]
        demoCache.punish = hdzui.frameTag("TEXT", "txt_8r", demoCache.main)
        hdzui.framePoint(demoCache.punish, demoCache.exp, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, 0, -0.011)
        -- 条:空1
        demoCache.bar_e1 = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_e1, "ReplaceableTextures\\TeamColor\\TeamColor12.blp", false)
        hdzui.frameSize(demoCache.bar_e1, bar_width, 0.002)
        hdzui.framePoint(demoCache.bar_e1, demoCache.period, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_RIGHT_BOTTOM, 0.003, 0)
        -- 条:空2
        demoCache.bar_e2 = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_e2, "ReplaceableTextures\\TeamColor\\TeamColor12.blp", false)
        hdzui.frameSize(demoCache.bar_e2, bar_width, 0.002)
        hdzui.framePoint(demoCache.bar_e2, demoCache.punish, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_RIGHT_BOTTOM, 0.003, 0)
        -- 条:存在周期
        demoCache.bar_period = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_period, "hLua\\ui\\bar_green.tga", false)
        hdzui.frameSize(demoCache.bar_period, bar_width, 0.002)
        hdzui.framePoint(demoCache.bar_period, demoCache.bar_e1, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0, 0)
        -- 条:经验
        demoCache.bar_exp = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_exp, "hLua\\ui\\bar_blue2.tga", false)
        hdzui.frameSize(demoCache.bar_exp, bar_width, 0.002)
        hdzui.framePoint(demoCache.bar_exp, demoCache.bar_e1, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0, 0)
        -- 条:存在周期[值]
        demoCache.period_val = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.period_val, demoCache.bar_e1, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_LEFT_TOP, 0.002, 0.001)
        -- 条:经验[值]
        demoCache.exp_val = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.exp_val, demoCache.bar_e1, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_LEFT_TOP, 0.002, 0.001)
        -- 条:硬直[值]
        demoCache.punish_val = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.punish_val, demoCache.bar_e2, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_LEFT_TOP, 0.002, 0.001)
        -- 条:经验率[值]
        demoCache.exp_ratio = hdzui.frameTag("TEXT", "txt_6l", demoCache.main)
        hdzui.framePoint(demoCache.exp_ratio, demoCache.bar_e1, FRAME_ALIGN_RIGHT_BOTTOM, FRAME_ALIGN_RIGHT_TOP, 0, 0.001)
        -- 条:硬直抵抗率[值]
        demoCache.punish_oppose = hdzui.frameTag("TEXT", "txt_6l", demoCache.main)
        hdzui.framePoint(demoCache.punish_oppose, demoCache.bar_e2, FRAME_ALIGN_RIGHT_BOTTOM, FRAME_ALIGN_RIGHT_TOP, 0, 0.001)
        -- 条:硬直
        demoCache.bar_punish = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hdzui.frameSize(demoCache.bar_punish, bar_width, 0.002)
        hdzui.framePoint(demoCache.bar_punish, demoCache.bar_e2, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0, 0)
        local attr_y = -0.005
        -- 属性:攻击
        demoCache.attack = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.attack, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.info.x + 0.011, px.info.y - 0.004)
        -- 属性:攻击速度
        demoCache.attack_speed = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.attack_speed, demoCache.attack, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:攻击范围
        demoCache.attack_range = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.attack_range, demoCache.attack_speed, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:护甲
        demoCache.defend = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.defend, demoCache.attack_range, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:减伤
        demoCache.damage_reduce = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.damage_reduce, demoCache.defend, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:移动
        demoCache.move = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.move, demoCache.damage_reduce, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:力量
        demoCache.str = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.str, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.info.x + 0.066, px.info.y - 0.004)
        -- 属性:力量成长
        demoCache.str_plus = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.str_plus, demoCache.str, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:敏捷
        demoCache.agi = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.agi, demoCache.str_plus, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:敏捷成长
        demoCache.agi_plus = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.agi_plus, demoCache.agi, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:智力
        demoCache.int = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.int, demoCache.agi_plus, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:智力成长
        demoCache.int_plus = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.int_plus, demoCache.int, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 右侧展开属性
        demoCache.more_tip = hdzui.frameTag("BACKDROP", "bg_tooltip", demoCache.game)
        hdzui.framePoint(demoCache.more_tip, demoCache.info_attr, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_RIGHT_BOTTOM, 0.001, 0.004)
        hdzui.frameSize(demoCache.more_tip, 0.1, 0.1)
        hdzui.frameToggle(demoCache.more_tip, false)
        demoCache.more_txt = hdzui.frameTag("TEXT", "txt_10l", demoCache.game)
        hdzui.framePoint(demoCache.more_txt, demoCache.more_tip, FRAME_ALIGN_CENTER, FRAME_ALIGN_CENTER, 0, 0)
        hdzui.frameToggle(demoCache.more_txt, false)
        cg.hLuaDemoMoreTip = demoCache.more_tip
        cg.hLuaDemoMoreTxt = demoCache.more_txt
        for i, b in ipairs(moreBtns) do
            local bk = "btn_" .. b
            local x = 0
            local y = 0
            if (i <= 4) then
                x = -0.010
                y = -0.006 - (i - 1) * 0.014
            else
                x = 0
                y = -0.006 - (i - 5) * 0.014
            end
            demoCache[bk] = hdzui.frameTag("BUTTON", bk, demoCache.game)
            hdzui.framePoint(demoCache[bk], demoCache.info_attr, FRAME_ALIGN_RIGHT_TOP, FRAME_ALIGN_RIGHT_TOP, x, y)
            hdzui.frameSize(demoCache[bk], 0.010, 0.012)
            hdzui.frameToggle(demoCache[bk], false)
            hplayer.forEach(function(enumPlayer, idx)
                cj.SaveInteger(cg.hLuaDemoHash, demoCache[bk], idx, i)
                hdzui.onMouse(demoCache[bk], MOUSE_ORDER_ENTER, enumPlayer, "hLuaDemoMoreEnter")
                hdzui.onMouse(demoCache[bk], MOUSE_ORDER_LEAVE, enumPlayer, "hLuaDemoMoreLeave")
            end)
        end
        -- UI展示
        demoCache.update()
        demoCache.updateTimer = htime.setInterval(0.1, function(_)
            demoCache.update()
        end)
    end
}