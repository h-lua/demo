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
    ---@param options pilotUIDEMO
    run = function(options)
        options = options or {}
        options.target_hp_unit = options.target_hp_unit or 5000
        options.hp_y = options.hp_y or 0.0038
        options.mp_y = options.mp_y or 0.0038
        --
        cj.FogMaskEnable(false)
        hdzui.loadToc("UI\\frame.toc")
        local width = 3200
        local height = 640
        local size_x = 0.8
        local size_y = height / width * size_x
        local _x = function(num)
            return num / width * size_x
        end
        local _y = function(num)
            return -(num - (1024 - height)) / height * size_y
        end
        local pxIt = 125
        local pxItx = 10.5
        local pxIty = 8.5
        local pxSk = 150
        local pxSkx = 14
        local pxSky = 10
        local px = {
            minMap = { w = _x(388), h = _x(388), x = _x(376.1892), y = _y(618.6245) },
            minMapBtn = {
                { w = _x(57.3751), h = _x(49.0004), x = _x(296.3765), y = _y(624.8737) },
                { w = _x(57.3751), h = _x(49.0004), x = _x(296.3765), y = _y(687.1362) },
                { w = _x(57.3751), h = _x(49.0004), x = _x(296.3765), y = _y(748.2268) },
                { w = _x(57.3751), h = _x(49.0004), x = _x(296.3765), y = _y(809.3958) },
                { w = _x(51.9997), h = _x(48.2053), x = _x(299.3033), y = _y(888) },
            },
            portrait = { w = _x(371.2194), h = _x(372.1813), x = _x(786.1427), y = _y(577.6204) },
            hp = { w = _x(238.11), h = _x(35.6226000000), x = _x(873.17), y = _y(925.0998) },
            mp = { w = _x(238.11), h = _x(35.6226000000), x = _x(873.17), y = _y(976.0349) },
            info = { w = _x(757.7399), h = _x(469.1952), x = _x(1183.6135), y = _y(553.8748) },
            sell = { w = _x(264.8083), h = _x(48.071), x = _x(1987.4771), y = _y(559.8199) },
            resource = { w = _x(640.4091), h = _x(47.9624), x = _x(2282.46), y = _y(487.3246) },
            item = {
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990), y = _y(617) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990 + (pxIt + pxItx)), y = _y(617) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990), y = _y(617 + (pxIt + pxIty)) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990 + (pxIt + pxItx)), y = _y(617 + (pxIt + pxIty)) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990), y = _y(617 + (pxIt + pxIty) * 2) },
                { w = _x(pxIt), h = _x(pxIt), x = _x(1990 + (pxIt + pxItx)), y = _y(617 + (pxIt + pxIty) * 2) },
            },
            skill = {
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281), y = _y(540) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx)), y = _y(540) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 2), y = _y(540) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 3), y = _y(540) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281), y = _y(540 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx)), y = _y(540 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 2), y = _y(540 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 3), y = _y(540 + (pxSk + pxSky)) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281), y = _y(540 + (pxSk + pxSky) * 2) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx)), y = _y(540 + (pxSk + pxSky) * 2) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 2), y = _y(540 + (pxSk + pxSky) * 2) },
                { w = _x(pxSk), h = _x(pxSk), x = _x(2281 + (pxSk + pxSkx) * 3), y = _y(540 + (pxSk + pxSky) * 2) },
            },
        }
        --
        demoCache.game = hdzui.origin.game()
        -- 设置
        local txt = {
            { "F8", "F8  空闲信使" },
            { "F9", "F9  帮助" },
            { "F10", "F10 菜单" },
            { "F11", "F11 盟友" },
            { "F12", "F12 消息" },
        }
        for i, t in ipairs(txt) do
            demoCache[t[1]] = hdzui.frameTag("TEXT", "txt_10l", demoCache.game)
            hdzui.frameSize(demoCache[t[1]], 0.06, 0.016)
            hdzui.framePoint(demoCache[t[1]], demoCache.game, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_RIGHT_BOTTOM, -0.052, 0.088 - (i - 1) * 0.016)
            hdzui.frameSetText(demoCache[t[1]], t[2])
        end
        -- 底部命令区
        demoCache.main = hdzui.frame("main", demoCache.game)
        hjapi.DzFrameSetAlpha(demoCache.main, 240)
        hdzui.frameSize(demoCache.main, size_x, size_x * (height / width))
        hdzui.framePoint(demoCache.main, demoCache.game, FRAME_ALIGN_BOTTOM, FRAME_ALIGN_BOTTOM, 0, 0)
        --- 系统消息框
        demoCache.unitMessage = hdzui.origin.unitMessage()
        hdzui.frameSize(demoCache.unitMessage, 0.2, 0.1)
        hdzui.framePoint(demoCache.unitMessage, demoCache.main, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_LEFT_TOP, px.minMapBtn[1].x - 0.01, -0.018)
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
        hdzui.frameSize(demoCache.chatMessage, 0.21, 0.2)
        hdzui.framePoint(demoCache.chatMessage, demoCache.main, FRAME_ALIGN_BOTTOM, FRAME_ALIGN_TOP, 0, 0.014)
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
        hdzui.framePoint(demoCache.tooltip, demoCache.itemSlot[1], FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_LEFT_TOP, -0.002, 0.06)
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
        --- 英雄栏
        demoCache.hero = hdzui.origin.hero()
        local hx = px.info.x - 0.002
        local d = 0.024
        for _, h in ipairs(demoCache.hero) do
            hdzui.frameSize(h.avatar, d, d)
            hdzui.framePoint(h.avatar, demoCache.main, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_LEFT_TOP, hx, -0.016)
            hdzui.frameSize(h.hp, d - 0.002, d * 0.06)
            hdzui.framePoint(h.hp, h.avatar, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0.001, 0)
            hdzui.frameSize(h.mp, d - 0.002, d * 0.06)
            hdzui.framePoint(h.mp, h.hp, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
            hx = hx + d + 0.002
        end
        -- 预留多余单位按钮2个

        -- 条:长度
        local bar_len = 0.074
        local moreBtns = { "more_x_tras", "more_x_oppose", "more_e_attack", "more_e_append", "more_e_oppose" }
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
                    hdzui.frameSetText(demoCache.exp_ratio, hcolor.mixed("经验率:" .. hplayer.getExpRatio(enumPlayer) .. "%", "78B5E4"))
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
                local primary
                local isStr = false
                local isAgi = false
                local isInt = false
                local selection
                local data = {}
                local lastTarget
                if (his.playing(enumPlayer)) then
                    selection = hplayer.getSelection(enumPlayer)
                    lastTarget = hevent.getPlayerLastDamageTarget(enumPlayer)
                    if (selection ~= nil) then
                        local attr = hattribute.get(selection)
                        if (attr ~= nil and his.alive(selection) and false == his.deleted(selection)) then
                            show = true
                            isHero = his.hero(selection)
                            primary = hhero.getPrimary(selection)
                            isStr = (primary == "STR")
                            isAgi = (primary == "AGI")
                            isInt = (primary == "INT")
                            isPeriod = hunit.getPeriod(selection) > 0
                            isOpenPunish = hunit.isPunishing(selection)
                            isBarE1 = isPeriod or isHero
                            isBarE2 = isOpenPunish
                            isBarExp = isHero
                            isBarPeriod = isPeriod
                            isBarPunish = isOpenPunish
                            -- 生命
                            local hpc = math.floor(hunit.getCurLife(selection))
                            local hpm = math.floor(hunit.getMaxLife(selection))
                            if (hpm == 0 or hpc > hpm * 0.85) then
                                data.hp = hcolor.mixed(hpc, "32CD32") .. "/" .. hpm
                            elseif (hpc > hpm * 0.60) then
                                data.hp = hcolor.mixed(hpc, "7FFF00") .. "/" .. hpm
                            elseif (hpc > hpm * 0.45) then
                                data.hp = hcolor.mixed(hpc, "ADFF2F") .. "/" .. hpm
                            elseif (hpc > hpm * 0.25) then
                                data.hp = hcolor.mixed(hpc, "FFFF00") .. "/" .. hpm
                            else
                                data.hp = hcolor.red(hpc) .. "/" .. hpm
                            end
                            -- 魔法
                            local mpc = math.floor(hunit.getCurMana(selection))
                            local mpm = math.floor(hunit.getMaxMana(selection))
                            if (mpm == 0 or mpc > mpm * 0.6) then
                                data.mp = hcolor.mixed(mpc, "1E90FF") .. "/" .. mpm
                            elseif (mpc > mpm * 0.3) then
                                data.mp = hcolor.mixed(mpc, "87CEFA") .. "/" .. mpm
                            else
                                data.mp = hcolor.red(mpc) .. "/" .. mpm
                            end
                            -- 治疗加成
                            local cure = 1 + 0.01 * (attr.cure or 0)
                            -- 生命恢复
                            local life_back = math.round(attr.life_back * cure, 1)
                            if (life_back > hattr.CURE_FLOOR) then
                                data.life_back = hcolor.mixed("+" .. math.numberFormat(life_back, 1), "32CD32")
                            elseif (life_back < -hattr.CURE_FLOOR) then
                                data.life_back = hcolor.red(math.numberFormat(life_back, 1))
                            else
                                data.life_back = "+0.00"
                            end
                            -- 魔法恢复
                            local mana_back = math.round(attr.mana_back * cure, 1)
                            if (mana_back > hattr.CURE_FLOOR) then
                                data.mana_back = hcolor.mixed("+" .. math.numberFormat(mana_back, 1), "1E90FF")
                            elseif (mana_back < -hattr.CURE_FLOOR) then
                                data.mana_back = hcolor.red(math.numberFormat(mana_back, 1))
                            else
                                data.mana_back = "+0.00"
                            end
                            -- 名称
                            data.unit_name = hunit.getName(selection)
                            data.hero_name = hhero.getProperName(selection)
                            if (data.hero_name ~= "") then
                                data.hero_name = "·" .. data.hero_name
                            end
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
                            data.reborn = attrBuilder(
                                "复活", "不能", attr.reborn < 0,
                                { "reborn" }, false,
                                math.round(attr.reborn, 1), "秒"
                            )
                            local weapsOn = hslk.i2v(hunit.getId(selection), "slk", "weapsOn") or "0"
                            local can_attack = ("0" ~= weapsOn)
                            data.attack = attrBuilder(
                                "攻击", "无", not can_attack,
                                { "attack_white", "attack_green" }, true,
                                math.numberFormat(attr.attack_sides[1], 1) .. "~" .. math.numberFormat(attr.attack_sides[2], 1), "")
                            data.attack_speed = attrBuilder(
                                "攻速", "无", not can_attack,
                                { "attack_speed" }, true,
                                math.round(attr.attack_space, 1), "秒")
                            if (attr.attack_speed > 0) then
                                data.attack_speed = data.attack_speed .. hcolor.grey("(+" .. math.floor(attr.attack_speed) .. "%)")
                            elseif (attr.attack_speed < 0) then
                                data.attack_speed = data.attack_speed .. hcolor.redLight("(" .. math.floor(attr.attack_speed) .. "%)")
                            end
                            data.attack_range = attrBuilder(
                                "攻击范围", "无", not can_attack,
                                { "attack_range" }, true,
                                math.floor(attr.attack_range), "")
                            data.knocking_extent = attrBuilder(
                                "暴击加成", "无", not can_attack,
                                { "knocking_extent" }, true,
                                math.round(attr.knocking_extent, 2), "%")
                            data.knocking_odds = attrBuilder(
                                "暴击几率", "无", not can_attack,
                                { "knocking_odds" }, true,
                                math.round(attr.knocking_odds, 2), "%")
                            data.hemophagia = attrBuilder(
                                "攻击吸血", "无", not can_attack,
                                { "hemophagia" }, true,
                                math.round(attr.hemophagia, 2), "%")
                            data.hemophagia_skill = attrBuilder(
                                "技能吸血", "无", false,
                                { "hemophagia_skill" }, true,
                                math.round(attr.hemophagia_skill, 2), "%")
                            data.weight = attrBuilder(
                                "负重", "无", false == his.hasSlot(selection),
                                { "weight" }, true,
                                math.floor(attr.weight_current) .. "/" .. math.floor(attr.weight), "Kg")
                            data.move = attrBuilder(
                                "移动", "无", false,
                                { "move" }, true,
                                math.floor(attr.move), "")
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
                            data.cure = attrBuilder(
                                "治疗加成", "无", false,
                                { "cure" }, true,
                                math.round(attr.cure, 2), "%")
                            data.avoid = attrBuilder(
                                "回避几率", "无", false,
                                { "avoid" }, true,
                                math.round(attr.avoid, 2), "%")
                            data.aim = attrBuilder(
                                "命中加成", "无", false,
                                { "aim" }, true,
                                math.round(attr.aim, 2), "%")
                            data.damage_extent = attrBuilder(
                                "伤害增幅", "无", false,
                                { "damage_extent" }, true,
                                math.round(attr.damage_extent, 2), "%")
                            data.damage_rebound = attrBuilder(
                                "反弹伤害", "无", false,
                                { "damage_rebound" }, true,
                                math.round(attr.damage_rebound, 2), "%")
                            data.sight_day = attrBuilder(
                                "白天视野", "无", false,
                                { "sight" }, true,
                                math.floor(attr.sight_day), "")
                            data.sight_night = attrBuilder(
                                "黑夜视野", "无", false,
                                { "sight" }, true,
                                math.floor(attr.sight_night), "")
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
                            local e_attack = 0
                            local e_append = 0
                            local e_oppose = 0
                            for _, v in ipairs(CONST_ENCHANT) do
                                if ((attr["e_" .. v.value .. "_attack"] or 0) > 0.1) then
                                    e_attack = e_attack + 1
                                end
                                if ((attr["e_" .. v.value .. "_append"] or 0) > 0.1) then
                                    e_append = e_append + 1
                                end
                                if ((attr["e_" .. v.value .. "_oppose"] or 0) > 0.1) then
                                    e_oppose = e_oppose + 1
                                end
                            end
                            data.e_attack = hcolor.mixed("附魔攻击", "D3B3FF") .. ":" .. e_attack .. "种"
                            data.e_append = hcolor.mixed("附魔附着", "D3B3FF") .. ":"
                            if (e_append > 0) then
                                data.e_append = data.e_append .. hcolor.red(e_append .. "种")
                            else
                                data.e_append = data.e_append .. e_append .. "种"
                            end
                            data.e_oppose = hcolor.mixed("附魔抗性", "D3B3FF") .. ":"
                            if (e_oppose > 0) then
                                data.e_oppose = data.e_oppose .. hcolor.green(e_oppose .. "种")
                            else
                                data.e_oppose = data.e_oppose .. e_oppose .. "种"
                            end
                            if (isPeriod) then
                                local pr = hunit.getPeriodRemain(selection)
                                local p = hunit.getPeriod(selection)
                                data.period_bar = bar_len * pr / p
                                data.period_val = pr .. "秒"
                            elseif (isHero) then
                                local lv = hhero.getCurLevel(selection)
                                local e = hhero.getExp(selection)
                                local en = hhero.getExpNeed(lv + 1)
                                data.exp_bar = bar_len * e / en
                                data.exp_val = "Lv" .. lv .. "   " .. math.min(e, en) .. "/" .. en
                            end
                            if (isOpenPunish) then
                                data.punish_bar = bar_len * attr.punish_current / attr.punish
                                data.punish_val = math.floor(math.max(0, attr.punish_current)) .. "/" .. math.floor(attr.punish)
                            end
                        end
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
                            elseif (i == 2) then
                                --more_x_oppose
                                offsetLen = 0.01
                                sIn("受伤无敌几率：" .. math.round(attr.invincible, 2) .. "%")
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
                            elseif (i == 3) then
                                --more_e_attack
                                offsetLen = -0.01
                                for _, v in ipairs(CONST_ENCHANT) do
                                    sIn(v.label .. "攻击：" .. math.floor(attr["e_" .. v.value .. "_attack"]) .. "级，"
                                        .. "伤害加成：" .. math.floor(attr["e_" .. v.value]) .. "%", v.color)
                                end
                            elseif (i == 4) then
                                --more_e_append
                                offsetLen = 0.02
                                for _, v in ipairs(CONST_ENCHANT) do
                                    sIn(v.label .. "附着：" .. math.floor(attr["e_" .. v.value .. "_append"]) .. "层", v.color)
                                end
                            elseif (i == 5) then
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
                                    data.target_val2 = (tr - 1) % 10
                                    if (demoCache.target_val2_prev ~= data.target_val2) then
                                        demoCache.target_val_prev = nil
                                    end
                                    demoCache.target_val2_prev = data.target_val2
                                    if (tr > 1) then
                                        data.target_tr = "X " .. tr
                                        if (data.target_val2 == 0) then
                                            data.target_val1 = 9
                                        else
                                            data.target_val1 = data.target_val2 - 1
                                        end
                                    end
                                end
                                data.target_val = (cl % HPUnit) / HPUnit
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
                        hdzui.frameSetText(demoCache.life_back, data.life_back)
                        hdzui.frameSetText(demoCache.mana_back, data.mana_back)
                        hdzui.frameSetText(demoCache.unit_name, data.unit_name)
                        hdzui.frameSetText(demoCache.hero_name, data.hero_name)
                        hdzui.frameSetText(demoCache.reborn, data.reborn)
                        hdzui.frameSetText(demoCache.attack, data.attack)
                        hdzui.frameSetText(demoCache.attack_speed, data.attack_speed)
                        hdzui.frameSetText(demoCache.attack_range, data.attack_range)
                        hdzui.frameSetText(demoCache.knocking_extent, data.knocking_extent)
                        hdzui.frameSetText(demoCache.knocking_odds, data.knocking_odds)
                        hdzui.frameSetText(demoCache.hemophagia, data.hemophagia)
                        hdzui.frameSetText(demoCache.hemophagia_skill, data.hemophagia_skill)
                        hdzui.frameSetText(demoCache.weight, data.weight)
                        hdzui.frameSetText(demoCache.move, data.move)
                        hdzui.frameSetText(demoCache.defend, data.defend)
                        hdzui.frameSetText(demoCache.damage_reduce, data.damage_reduce)
                        hdzui.frameSetText(demoCache.cure, data.cure)
                        hdzui.frameSetText(demoCache.avoid, data.avoid)
                        hdzui.frameSetText(demoCache.aim, data.aim)
                        hdzui.frameSetText(demoCache.damage_extent, data.damage_extent)
                        hdzui.frameSetText(demoCache.damage_rebound, data.damage_rebound)
                        hdzui.frameSetText(demoCache.sight_day, data.sight_day)
                        hdzui.frameSetText(demoCache.sight_night, data.sight_night)
                        if (isHero) then
                            hdzui.frameSetText(demoCache.str, data.str)
                            hdzui.frameSetText(demoCache.str_plus, data.str_plus)
                            hdzui.frameSetText(demoCache.agi, data.agi)
                            hdzui.frameSetText(demoCache.agi_plus, data.agi_plus)
                            hdzui.frameSetText(demoCache.int, data.int)
                            hdzui.frameSetText(demoCache.int_plus, data.int_plus)
                        end
                        hdzui.frameSetText(demoCache.e_attack, data.e_attack)
                        hdzui.frameSetText(demoCache.e_append, data.e_append)
                        hdzui.frameSetText(demoCache.e_oppose, data.e_oppose)
                        if (isPeriod) then
                            hdzui.frameSetText(demoCache.period_val, hcolor.mixed(data.period_val, "26BD08"))
                            if (data.period_bar > 0) then
                                hdzui.frameSize(demoCache.bar_period, data.period_bar, 0.002)
                            else
                                isBarPeriod = false
                            end
                        elseif (isHero) then
                            hdzui.frameSetText(demoCache.exp_val, hcolor.mixed(data.exp_val, "78B5E4"))
                            if (data.exp_bar > 0) then
                                hdzui.frameSize(demoCache.bar_exp, data.exp_bar, 0.002)
                            else
                                isBarExp = false
                            end
                        end
                        if (isOpenPunish) then
                            if (his.punish(selection)) then
                                hdzui.frameSetText(demoCache.punish, hcolor.red("僵住"))
                                hdzui.frameSetText(demoCache.punish_val, hcolor.red(data.punish_val))
                            else
                                hdzui.frameSetText(demoCache.punish, hcolor.mixed("硬直", "FFFF00"))
                                hdzui.frameSetText(demoCache.punish_val, hcolor.mixed(data.punish_val, "FFFF00"))
                            end
                            if (data.punish_bar > 0) then
                                hdzui.frameSize(demoCache.bar_punish, data.punish_bar, 0.002)
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
                    hjapi.DzFrameShow(demoCache.hp, show)
                    hjapi.DzFrameShow(demoCache.mp, show)
                    hjapi.DzFrameShow(demoCache.life_back, show)
                    hjapi.DzFrameShow(demoCache.mana_back, show)
                    hjapi.DzFrameShow(demoCache.info_attr, show and (isHero == false))
                    hjapi.DzFrameShow(demoCache.info_attr_hero, show and isHero)
                    hjapi.DzFrameShow(demoCache.sign_str, show and isHero and isStr)
                    hjapi.DzFrameShow(demoCache.sign_agi, show and isHero and isAgi)
                    hjapi.DzFrameShow(demoCache.sign_int, show and isHero and isInt)
                    hjapi.DzFrameShow(demoCache.sign_nor, show and (isHero == false))
                    hjapi.DzFrameShow(demoCache.unit_name, show)
                    hjapi.DzFrameShow(demoCache.hero_name, show)
                    hjapi.DzFrameShow(demoCache.reborn, show)
                    hjapi.DzFrameShow(demoCache.attack, show)
                    hjapi.DzFrameShow(demoCache.attack_speed, show)
                    hjapi.DzFrameShow(demoCache.attack_range, show)
                    hjapi.DzFrameShow(demoCache.knocking_extent, show)
                    hjapi.DzFrameShow(demoCache.knocking_odds, show)
                    hjapi.DzFrameShow(demoCache.hemophagia, show)
                    hjapi.DzFrameShow(demoCache.hemophagia_skill, show)
                    hjapi.DzFrameShow(demoCache.weight, show)
                    hjapi.DzFrameShow(demoCache.move, show)
                    hjapi.DzFrameShow(demoCache.defend, show)
                    hjapi.DzFrameShow(demoCache.damage_reduce, show)
                    hjapi.DzFrameShow(demoCache.cure, show)
                    hjapi.DzFrameShow(demoCache.avoid, show)
                    hjapi.DzFrameShow(demoCache.aim, show)
                    hjapi.DzFrameShow(demoCache.damage_extent, show)
                    hjapi.DzFrameShow(demoCache.damage_rebound, show)
                    hjapi.DzFrameShow(demoCache.sight_day, show)
                    hjapi.DzFrameShow(demoCache.sight_night, show)
                    hjapi.DzFrameShow(demoCache.str, show and isHero)
                    hjapi.DzFrameShow(demoCache.str_plus, show and isHero)
                    hjapi.DzFrameShow(demoCache.agi, show and isHero)
                    hjapi.DzFrameShow(demoCache.agi_plus, show and isHero)
                    hjapi.DzFrameShow(demoCache.int, show and isHero)
                    hjapi.DzFrameShow(demoCache.int_plus, show and isHero)
                    hjapi.DzFrameShow(demoCache.e_attack, show)
                    hjapi.DzFrameShow(demoCache.e_append, show)
                    hjapi.DzFrameShow(demoCache.e_oppose, show)
                    hjapi.DzFrameShow(demoCache.period, show and isPeriod)
                    hjapi.DzFrameShow(demoCache.period_val, show and isPeriod)
                    hjapi.DzFrameShow(demoCache.exp, show and (not isPeriod) and isHero)
                    hjapi.DzFrameShow(demoCache.exp_val, show and (not isPeriod) and isHero)
                    hjapi.DzFrameShow(demoCache.exp_ratio, show and (not isPeriod) and isHero)
                    hjapi.DzFrameShow(demoCache.punish, show and isOpenPunish)
                    hjapi.DzFrameShow(demoCache.punish_val, show and isOpenPunish)
                    hjapi.DzFrameShow(demoCache.bar_e1, show and isBarE1)
                    hjapi.DzFrameShow(demoCache.bar_e2, show and isBarE2)
                    hjapi.DzFrameShow(demoCache.bar_period, show and isBarPeriod)
                    hjapi.DzFrameShow(demoCache.bar_exp, show and (not isPeriod) and isBarExp)
                    hjapi.DzFrameShow(demoCache.bar_punish, show and isBarPunish)
                    if (lastTarget ~= nil) then
                        hjapi.DzFrameSetTexture(demoCache.target_ava, data.target_ava)
                        hdzui.frameSetText(demoCache.target_tl, data.target_tl)
                        hdzui.frameSetText(demoCache.target_tr, data.target_tr)
                        local cur = data.target_val * 0.2126
                        local next = cur
                        local step = 0.2126 / 10
                        if (demoCache.target_val_prev ~= nil) then
                            if (cur < demoCache.target_val_prev and (demoCache.target_val_prev - cur) > step) then
                                next = demoCache.target_val_prev - step
                            elseif (cur > demoCache.target_val_prev and (cur - demoCache.target_val_prev) > step) then
                                next = demoCache.target_val_prev + step
                            end
                        end
                        demoCache.target_val_prev = next
                        hdzui.frameSize(demoCache.target_val2, next, 0.022)
                        hjapi.DzFrameSetAlpha(demoCache.target_val2, 400 * next / 0.2126)
                        if (data.target_val1 ~= nil) then
                            hjapi.DzFrameSetTexture(demoCache.target_val1, "ReplaceableTextures\\TeamColor\\TeamColor0" .. data.target_val1 .. ".blp")
                        end
                        hjapi.DzFrameSetTexture(demoCache.target_val2, "ReplaceableTextures\\TeamColor\\TeamColor0" .. data.target_val2 .. ".blp")
                        hjapi.DzFrameShow(demoCache.target, true)
                        hjapi.DzFrameShow(demoCache.target_ava, true)
                        hjapi.DzFrameShow(demoCache.target_tl, true)
                        hjapi.DzFrameShow(demoCache.target_tr, true)
                        hjapi.DzFrameShow(demoCache.target_val1, data.target_val1 ~= nil)
                        hjapi.DzFrameShow(demoCache.target_val2, true)
                    else
                        hjapi.DzFrameShow(demoCache.target, false)
                        hjapi.DzFrameShow(demoCache.target_ava, false)
                        hjapi.DzFrameShow(demoCache.target_tl, false)
                        hjapi.DzFrameShow(demoCache.target_tr, false)
                        hjapi.DzFrameShow(demoCache.target_val1, false)
                        hjapi.DzFrameShow(demoCache.target_val2, false)
                    end
                    local btns = { "btn_more_x_tras", "btn_more_x_oppose", "btn_more_e_attack", "btn_more_e_append", "btn_more_e_oppose" }
                    for _, bk in ipairs(btns) do
                        hjapi.DzFrameShow(demoCache[bk], show)
                    end
                end
            end)
        end
        -- 黄金
        demoCache.gold = hdzui.frameTag("TEXT", "txt_10l", demoCache.main)
        hdzui.framePoint(demoCache.gold, demoCache.main, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT_TOP, px.resource.x + 0.014, px.resource.y - 0.0055)
        hdzui.frameSize(demoCache.gold, 0.05, 0.02)
        -- 黄金率
        demoCache.gold_ratio = hdzui.frameTag("TEXT", "txt_8l", demoCache.main)
        hdzui.framePoint(demoCache.gold_ratio, demoCache.gold, FRAME_ALIGN_LEFT, FRAME_ALIGN_RIGHT, 0, 0)
        hdzui.frameSize(demoCache.gold_ratio, 0.08, 0.02)
        -- 木头
        demoCache.lumber = hdzui.frameTag("TEXT", "txt_10l", demoCache.main)
        hdzui.framePoint(demoCache.lumber, demoCache.main, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT_TOP, px.resource.x + 0.096, px.resource.y - 0.0055)
        hdzui.frameSize(demoCache.lumber, 0.05, 0.02)
        -- 木头率
        demoCache.lumber_ratio = hdzui.frameTag("TEXT", "txt_8l", demoCache.main)
        hdzui.framePoint(demoCache.lumber_ratio, demoCache.lumber, FRAME_ALIGN_LEFT, FRAME_ALIGN_RIGHT, 0, 0)
        -- 售卖率
        demoCache.sell_ratio = hdzui.frameTag("TEXT", "txt_8l", demoCache.main)
        hdzui.framePoint(demoCache.sell_ratio, demoCache.main, FRAME_ALIGN_CENTER, FRAME_ALIGN_LEFT_TOP, px.sell.x + 0.033, px.sell.y - 0.006)
        -- 生命
        demoCache.hp = hdzui.frameTag("TEXT", "txt_8l", demoCache.main)
        hdzui.framePoint(demoCache.hp, demoCache.main, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT_TOP, px.hp.x, px.hp.y - options.hp_y)
        hdzui.frameSize(demoCache.hp, px.hp.w * 0.7, px.hp.h)
        -- 魔法
        demoCache.mp = hdzui.frameTag("TEXT", "txt_8l", demoCache.main)
        hdzui.framePoint(demoCache.mp, demoCache.main, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT_TOP, px.mp.x, px.mp.y - options.mp_y)
        hdzui.frameSize(demoCache.mp, px.hp.w * 0.7, px.hp.h)
        -- 生命恢复
        demoCache.life_back = hdzui.frameTag("TEXT", "txt_8r", demoCache.main)
        hdzui.framePoint(demoCache.life_back, demoCache.main, FRAME_ALIGN_CENTER, FRAME_ALIGN_LEFT_TOP, px.hp.x + 0.055, px.hp.y - options.hp_y)
        hdzui.frameSize(demoCache.life_back, px.hp.w * 0.3, px.hp.h)
        -- 魔法恢复
        demoCache.mana_back = hdzui.frameTag("TEXT", "txt_8r", demoCache.main)
        hdzui.framePoint(demoCache.mana_back, demoCache.main, FRAME_ALIGN_CENTER, FRAME_ALIGN_LEFT_TOP, px.mp.x + 0.055, px.mp.y - options.mp_y)
        hdzui.frameSize(demoCache.mana_back, px.hp.w * 0.3, px.hp.h)
        -- 信息面板
        demoCache.info_attr = hdzui.frame("bg_info_attr", demoCache.main)
        hdzui.frameSize(demoCache.info_attr, px.info.w, px.info.h)
        hdzui.framePoint(demoCache.info_attr, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.info.x, px.info.y)
        demoCache.info_attr_hero = hdzui.frame("bg_info_attr_hero", demoCache.main)
        hdzui.frameSize(demoCache.info_attr_hero, px.info.w, px.info.h)
        hdzui.framePoint(demoCache.info_attr_hero, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.info.x, px.info.y)
        -- 单位标志
        demoCache.sign_str = hdzui.frame("bg_sign_str", demoCache.main)
        demoCache.sign_agi = hdzui.frame("bg_sign_agi", demoCache.main)
        demoCache.sign_int = hdzui.frame("bg_sign_int", demoCache.main)
        demoCache.sign_nor = hdzui.frame("bg_sign_nor", demoCache.main)
        hdzui.frameSize(demoCache.sign_str, 0.014, 0.018)
        hdzui.frameSize(demoCache.sign_agi, 0.014, 0.018)
        hdzui.frameSize(demoCache.sign_int, 0.014, 0.018)
        hdzui.frameSize(demoCache.sign_nor, 0.014, 0.018)
        hdzui.framePoint(demoCache.sign_str, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, px.info.x + 0.0035, px.info.y - 0.006)
        hdzui.framePoint(demoCache.sign_agi, demoCache.sign_str, FRAME_ALIGN_CENTER, FRAME_ALIGN_CENTER, 0, 0)
        hdzui.framePoint(demoCache.sign_int, demoCache.sign_str, FRAME_ALIGN_CENTER, FRAME_ALIGN_CENTER, 0, 0)
        hdzui.framePoint(demoCache.sign_nor, demoCache.sign_str, FRAME_ALIGN_CENTER, FRAME_ALIGN_CENTER, 0, 0)
        -- 单位名称
        demoCache.unit_name = hdzui.frameTag("TEXT", "txt_10l", demoCache.main)
        hdzui.framePoint(demoCache.unit_name, demoCache.main, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT_TOP, px.info.x + 0.018, px.info.y - 0.01)
        -- 英雄名称
        demoCache.hero_name = hdzui.frameTag("TEXT", "txt_10l", demoCache.main)
        hdzui.framePoint(demoCache.hero_name, demoCache.unit_name, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_RIGHT_TOP, 0, 0)
        -- 条:存在周期[字]
        demoCache.period = hdzui.frameTag("TEXT", "txt_76r", demoCache.main)
        hdzui.frameSetText(demoCache.period, hcolor.mixed("存在", "26BD08"))
        hdzui.framePoint(demoCache.period, demoCache.main, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_TOP, -0.024, -0.048)
        -- 条:存在周期[值]
        demoCache.period_val = hdzui.frameTag("TEXT", "txt_6l", demoCache.main)
        hdzui.framePoint(demoCache.period_val, demoCache.period, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_RIGHT_TOP, 0.002, 0.002)
        -- 条:经验[字]
        demoCache.exp = hdzui.frameTag("TEXT", "txt_76r", demoCache.main)
        hdzui.frameSetText(demoCache.exp, hcolor.mixed("经验", "78B5E4"))
        hdzui.framePoint(demoCache.exp, demoCache.period, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, 0, 0)
        -- 条:经验[值]
        demoCache.exp_val = hdzui.frameTag("TEXT", "txt_6l", demoCache.main)
        hdzui.framePoint(demoCache.exp_val, demoCache.exp, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_RIGHT_TOP, 0.002, 0.002)
        -- 条:硬直[字]
        demoCache.punish = hdzui.frameTag("TEXT", "txt_76r", demoCache.main)
        hdzui.frameSetText(demoCache.punish, hcolor.mixed("硬直", "FFFF00"))
        hdzui.framePoint(demoCache.punish, demoCache.exp, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_TOP, 0, -0.012)
        -- 条:硬直[值]
        demoCache.punish_val = hdzui.frameTag("TEXT", "txt_6l", demoCache.main)
        hdzui.framePoint(demoCache.punish_val, demoCache.punish, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_RIGHT_TOP, 0.002, 0.002)
        -- 条:空1
        demoCache.bar_e1 = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_e1, "ReplaceableTextures\\TeamColor\\TeamColor08.blp", false)
        hdzui.frameSize(demoCache.bar_e1, bar_len, 0.002)
        hdzui.framePoint(demoCache.bar_e1, demoCache.period, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_RIGHT_BOTTOM, 0.002, 0)
        -- 条:空2
        demoCache.bar_e2 = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_e2, "ReplaceableTextures\\TeamColor\\TeamColor08.blp", false)
        hdzui.frameSize(demoCache.bar_e2, bar_len, 0.002)
        hdzui.framePoint(demoCache.bar_e2, demoCache.punish, FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_RIGHT_BOTTOM, 0.002, 0)
        -- 条:存在周期
        demoCache.bar_period = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_period, "ReplaceableTextures\\TeamColor\\TeamColor06.blp", false)
        hdzui.frameSize(demoCache.bar_period, bar_len, 0.002)
        hdzui.framePoint(demoCache.bar_period, demoCache.bar_e1, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0, 0)
        -- 条:经验
        demoCache.bar_exp = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_exp, "ReplaceableTextures\\TeamColor\\TeamColor09.blp", false)
        hdzui.frameSize(demoCache.bar_exp, bar_len, 0.002)
        hdzui.framePoint(demoCache.bar_exp, demoCache.bar_e1, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0, 0)
        -- 条:经验率
        demoCache.exp_ratio = hdzui.frameTag("TEXT", "txt_6l", demoCache.main)
        hdzui.framePoint(demoCache.exp_ratio, demoCache.bar_e1, FRAME_ALIGN_RIGHT_BOTTOM, FRAME_ALIGN_RIGHT_TOP, 0, 0.002)
        -- 条:硬直
        demoCache.bar_punish = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.main)
        hjapi.DzFrameSetTexture(demoCache.bar_punish, "ReplaceableTextures\\TeamColor\\TeamColor04.blp", false)
        hdzui.frameSize(demoCache.bar_punish, bar_len, 0.002)
        hdzui.framePoint(demoCache.bar_punish, demoCache.bar_e2, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0, 0)
        -- 属性:复活
        demoCache.reborn = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.reborn, demoCache.unit_name, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, -0.004)
        local attr_y = -0.005
        -- 属性:攻击
        demoCache.attack = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.attack, demoCache.reborn, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:攻击速度
        demoCache.attack_speed = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.attack_speed, demoCache.attack, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:攻击范围
        demoCache.attack_range = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.attack_range, demoCache.attack_speed, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:暴击加成
        demoCache.knocking_extent = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.knocking_extent, demoCache.attack_range, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:暴击几率
        demoCache.knocking_odds = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.knocking_odds, demoCache.knocking_extent, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:攻击吸血
        demoCache.hemophagia = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.hemophagia, demoCache.knocking_odds, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:技能吸血
        demoCache.hemophagia_skill = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.hemophagia_skill, demoCache.hemophagia, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:负重
        demoCache.weight = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.weight, demoCache.hemophagia_skill, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:移动
        demoCache.move = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.move, demoCache.weight, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:护甲
        demoCache.defend = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.defend, demoCache.reborn, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0.062, attr_y)
        -- 属性:减伤
        demoCache.damage_reduce = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.damage_reduce, demoCache.defend, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:治疗
        demoCache.cure = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.cure, demoCache.damage_reduce, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:回避
        demoCache.avoid = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.avoid, demoCache.cure, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:命中
        demoCache.aim = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.aim, demoCache.avoid, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:增伤
        demoCache.damage_extent = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.damage_extent, demoCache.aim, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:反伤
        demoCache.damage_rebound = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.damage_rebound, demoCache.damage_extent, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:白天视野
        demoCache.sight_day = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.sight_day, demoCache.damage_rebound, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, attr_y)
        -- 属性:夜晚视野
        demoCache.sight_night = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.sight_night, demoCache.sight_day, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:力量
        demoCache.str = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.str, demoCache.reborn, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0.120, attr_y)
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
        -- 属性:附魔攻击
        demoCache.e_attack = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.e_attack, demoCache.reborn, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0.120, -0.064)
        -- 属性:附魔附着
        demoCache.e_append = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.e_append, demoCache.e_attack, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 属性:附魔抗性
        demoCache.e_oppose = hdzui.frameTag("TEXT", "txt_76l", demoCache.main)
        hdzui.framePoint(demoCache.e_oppose, demoCache.e_append, FRAME_ALIGN_LEFT_TOP, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        -- 上方目标血条
        demoCache.target = hdzui.frameTag("BACKDROP", "bg_bar_target", demoCache.game)
        hdzui.frameSize(demoCache.target, 0.24, 0.03)
        hdzui.framePoint(demoCache.target, demoCache.game, FRAME_ALIGN_CENTER, FRAME_ALIGN_TOP, 0, -0.04)
        demoCache.target_ava = hdzui.frameTag("BACKDROP", "bg_bar_avatar", demoCache.game)
        hdzui.frameSize(demoCache.target_ava, 0.02, 0.023)
        hdzui.framePoint(demoCache.target_ava, demoCache.target, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0.002, 0)
        demoCache.target_val1 = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.target)
        hdzui.frameSize(demoCache.target_val1, 0.2126, 0.022)
        hdzui.framePoint(demoCache.target_val1, demoCache.target, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0.0236, 0)
        demoCache.target_val2 = hdzui.frameTag("BACKDROP", "bg_bar", demoCache.target)
        hdzui.frameSize(demoCache.target_val2, 0.2126, 0.022)
        hdzui.framePoint(demoCache.target_val2, demoCache.target, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0.0236, 0)
        demoCache.target_tl = hdzui.frameTag("TEXT", "txt_12l", demoCache.game)
        hdzui.framePoint(demoCache.target_tl, demoCache.target, FRAME_ALIGN_LEFT, FRAME_ALIGN_LEFT, 0.025, 0)
        demoCache.target_tr = hdzui.frameTag("TEXT", "txt_12r", demoCache.game)
        hdzui.framePoint(demoCache.target_tr, demoCache.target, FRAME_ALIGN_RIGHT, FRAME_ALIGN_RIGHT, -0.006, 0)
        -- 右侧展开属性
        demoCache.more_tip = hdzui.frameTag("BACKDROP", "bg_tooltip", hdzui.origin.game())
        hdzui.framePoint(demoCache.more_tip, hdzui.origin.game(), FRAME_ALIGN_LEFT_BOTTOM, FRAME_ALIGN_BOTTOM, 0.088, 0.002)
        hdzui.frameSize(demoCache.more_tip, 0.1, 0.1)
        hdzui.frameToggle(demoCache.more_tip, false)
        demoCache.more_txt = hdzui.frameTag("TEXT", "txt_10l", hdzui.origin.game())
        hdzui.framePoint(demoCache.more_txt, demoCache.more_tip, FRAME_ALIGN_CENTER, FRAME_ALIGN_CENTER, 0, 0)
        hdzui.frameToggle(demoCache.more_txt, false)
        cg.hLuaDemoMoreTip = demoCache.more_tip
        cg.hLuaDemoMoreTxt = demoCache.more_txt
        for i, b in ipairs(moreBtns) do
            local bk = "btn_" .. b
            demoCache[bk] = hdzui.frameTag("BUTTON", bk, hdzui.origin.game())
            hdzui.framePoint(demoCache[bk], demoCache.main, FRAME_ALIGN_LEFT, FRAME_ALIGN_CENTER, 0.074, -(i - 1) * 0.015)
            hdzui.frameSize(demoCache[bk], 0.010, 0.012)
            hplayer.forEach(function(enumPlayer, idx)
                cj.SaveInteger(cg.hLuaDemoHash, demoCache[bk], idx, i)
                hdzui.onMouse(demoCache[bk], MOUSE_ORDER_ENTER, "hLuaDemoMoreEnter", enumPlayer)
                hdzui.onMouse(demoCache[bk], MOUSE_ORDER_LEAVE, "hLuaDemoMoreLeave", enumPlayer)
            end)
        end
        -- UI展示
        demoCache.update()
        demoCache.updateTimer = htime.setInterval(0.1, function(_)
            demoCache.update()
        end)
    end
}