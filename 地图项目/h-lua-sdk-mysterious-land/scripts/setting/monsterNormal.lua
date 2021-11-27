-- 怪物点
monsterNormalAutoCount = 0
monsterNormal = {
    -- 七灵 1-3
    {
        desc = "瀑布渊底被鱼虾妖入侵了",
        loc = { -768, -1648 },
        mon = { "小鱼妖", "蟹妖", "小虾妖" },
        qty = { 3, 5 }, -- min -> max
        level = 1,
    },
    {
        desc = "虎口湾忽然出现了一大片螃蟹",
        loc = { -1500, 840 },
        mon = { "蟹妖" },
        qty = { 10, 15 }, -- min -> max
        level = 1,
    },
    {
        desc = "七峡湾被鱼虾妖入侵了",
        loc = { 676, -1212 },
        mon = { "小鱼妖", "青鱼妖", "蟹妖", "蓝虾妖" },
        qty = { 4, 6 }, -- min -> max
        level = 1,
    },
    {
        desc = "七脚峡被虾妖入侵了",
        loc = { 689, -3000 },
        mon = { "小虾妖", "蓝虾妖", "绿虾妖" },
        qty = { 7, 10 }, -- min -> max
        level = 2,
    },
    {
        desc = "七尖水道被鱼群入侵了",
        loc = { 822, 1866 },
        mon = { "小鱼妖", "青鱼妖", "夜鱼妖" },
        qty = { 7, 10 }, -- min -> max
        level = 3,
    },
    -- 斑斓海 4-7
    {
        desc = "斑斓海的妖魔出现了",
        loc = { -3477, -2710 },
        mon = { "水妖", "蓝虾妖", "夜鱼妖" },
        qty = { 5, 7 }, -- min -> max
        level = 4,
    },
    {
        desc = "斑斓海的妖魔出现了",
        loc = { -5214, -2290 },
        mon = { "水妖", "蓝虾妖", "夜鱼妖" },
        qty = { 5, 7 }, -- min -> max
        level = 4,
    },
    {
        desc = "斑斓海的妖魔出现了",
        loc = { -2379, -3864 },
        mon = { "水妖", "蓝虾妖", "夜鱼妖" },
        qty = { 5, 7 }, -- min -> max
        level = 4,
    },
    {
        desc = "斑斓海的妖魔出现了",
        loc = { -6357, -3944 },
        mon = { "水妖", "海妖" },
        qty = { 5, 7 }, -- min -> max
        level = 5,
    },
    {
        desc = "斑斓海的海妖出现了",
        loc = { -4092, -6072 },
        mon = { "夜鱼妖", "水妖", "海妖" },
        qty = { 5, 7 }, -- min -> max
        level = 5,
    },
    {
        desc = "斑斓海的妖魔出现了",
        loc = { -7151, -2836 },
        mon = { "夜鱼妖", "水妖", "海妖" },
        qty = { 4, 6 }, -- min -> max
        level = 5,
    },
    {
        desc = "斑斓海的海妖出现了",
        loc = { -5474, -7639 },
        mon = { "水妖", "海妖" },
        qty = { 5, 7 }, -- min -> max
        level = 6,
    },
    {
        desc = "斑斓海的海妖出现了",
        loc = { -7748, -6623 },
        mon = { "海妖" },
        qty = { 10, 15 }, -- min -> max
        level = 7,
    },
    -- 秘潭幽林 8-13
    {
        desc = "幽林中衍生了树精",
        loc = { 1500, -5858 },
        mon = { "树精" },
        qty = { 3, 5 }, -- min -> max
        level = 8,
    },
    {
        desc = "幽林中衍生了树精",
        loc = { 1641, -7605 },
        mon = { "树精" },
        qty = { 3, 5 }, -- min -> max
        level = 8,
    },
    {
        desc = "幽谷中灰狼在觅食",
        loc = { -436, -6066 },
        mon = { "灰狼" },
        qty = { 3, 5 }, -- min -> max
        level = 9,
    },
    {
        desc = "一群灰狼在山上警戒",
        loc = { 2220, -6686 },
        mon = { "灰狼" },
        qty = { 10, 12 }, -- min -> max
        level = 10,
    },
    {
        desc = "蜘蛛萌萌的~",
        loc = { 1237, -9175 },
        mon = { "小蜘蛛", "森林蜘蛛" },
        qty = { 6, 8 }, -- min -> max
        level = 10,
    },
    {
        desc = "蜘蛛萌萌的~",
        loc = { -1896, -8935 },
        mon = { "小蜘蛛", "森林蜘蛛" },
        qty = { 7, 9 }, -- min -> max
        level = 11,
    },
    {
        desc = "树魔与豺狼在密谋着奇怪的事情",
        loc = { -1124, -4972 },
        mon = { "树魔狂战士", "树魔猎手", "树魔牧师", "豺狼", "豺狼射手" },
        qty = { 16, 20 }, -- min -> max
        level = 13,
    },
    {
        desc = "秘潭出现了怪人",
        loc = { 1641, -7605 },
        mon = { "丛林怪人" },
        qty = { 2, 3 }, -- min -> max
        level = 13,
    },
    -- 铁环山 14-20
    {
        desc = "铁环山的石头人在投石头",
        loc = { 6637, 2100 },
        mon = { "投石头石头人" },
        qty = { 2, 3 }, -- min -> max
        level = 14,
    },
    {
        desc = "铁环山的石头人在投石头",
        loc = { 7221, 2139 },
        mon = { "投石头石头人" },
        qty = { 2, 3 }, -- min -> max
        level = 14,
    },
    {
        desc = "铁环山的石头人在投石头",
        loc = { 7821, 2197 },
        mon = { "投石头石头人" },
        qty = { 2, 3 }, -- min -> max
        level = 14,
    },
    {
        desc = "铁环山满山石头人",
        loc = { 8854, 1127 },
        mon = { "石头人", "投石头石头人" },
        qty = { 5, 7 }, -- min -> max
        level = 15,
    },
    {
        desc = "铁环山满山石头人",
        loc = { 5968, 1715 },
        mon = { "石头人" },
        qty = { 4, 6 }, -- min -> max
        level = 15,
    },
    {
        desc = "铁环山路出现了拦路的石头人",
        loc = { 7221, 1362 },
        mon = { "石头人" },
        qty = { 4, 6 }, -- min -> max
        level = 16,
    },
    {
        desc = "铁环山路出现了拦路的奥加",
        loc = { 8500, -1495 },
        mon = { "土色奥加", "天色奥加" },
        qty = { 7, 10 }, -- min -> max
        level = 17,
    },
    {
        desc = "铁环平原出现了拦路的奥加",
        loc = { 6814, -1911 },
        mon = { "土色奥加", "天色奥加" },
        qty = { 7, 10 }, -- min -> max
        level = 17,
    },
    {
        desc = "铁环山柱地出现了妖魔",
        loc = { 5379, -660 },
        mon = { "石头人", "土色奥加", "天色奥加" },
        qty = { 7, 10 }, -- min -> max
        level = 18,
    },
    {
        desc = "鹰女妖在铁环山盘旋",
        loc = { 8150, -384 },
        mon = { "鹰女妖" },
        qty = { 3, 4 }, -- min -> max
        level = 19,
    },
    {
        desc = "鹰女妖在铁环山盘旋",
        loc = { 7500, -2100 },
        mon = { "鹰女妖" },
        qty = { 3, 4 }, -- min -> max
        level = 19,
    },
    {
        desc = "大片鹰女妖在铁环山盘旋",
        loc = { 6648, -337 },
        mon = { "鹰女妖" },
        qty = { 8, 12 }, -- min -> max
        level = 20,
    },
    -- 遗迹草原 21-29
    {
        desc = "强盗在遗迹中搜刮",
        loc = { 6040, -4725 },
        mon = { "强盗" },
        qty = { 4, 6 }, -- min -> max
        level = 21,
    },
    {
        desc = "强盗在遗迹中搜刮",
        loc = { 4563, -5589 },
        mon = { "强盗" },
        qty = { 4, 6 }, -- min -> max
        level = 22,
    },
    {
        desc = "强盗在遗迹中搜刮",
        loc = { 5862, -5600 },
        mon = { "强盗" },
        qty = { 7, 11 }, -- min -> max
        level = 23,
    },
    {
        desc = "强盗在遗迹中搜刮",
        loc = { 4949, -6520 },
        mon = { "强盗" },
        qty = { 5, 7 }, -- min -> max
        level = 24,
    },
    {
        desc = "遗迹北边的傀儡动起来了",
        loc = { 5790, -6147 },
        mon = { "遗迹傀儡" },
        qty = { 3, 3 }, -- min -> max
        level = 25,
    },
    {
        desc = "遗迹东边的傀儡动起来了",
        loc = { 8311, -6334 },
        mon = { "遗迹傀儡" },
        qty = { 3, 3 }, -- min -> max
        level = 26,
    },
    {
        desc = "遗迹西边的傀儡动起来了",
        loc = { 5380, -8431 },
        mon = { "遗迹傀儡" },
        qty = { 3, 3 }, -- min -> max
        level = 27,
    },
    {
        desc = "遗迹南边的傀儡动起来了",
        loc = { 7712, -8429 },
        mon = { "遗迹傀儡" },
        qty = { 3, 3 }, -- min -> max
        level = 28,
    },
    {
        desc = "遗迹中央爬满了蝎子",
        loc = { 6719, -7100 },
        mon = { "灰蝎妖", "毒蝎妖" },
        qty = { 9, 13 }, -- min -> max
        level = 29,
    },
    {
        desc = "遗迹中央布爬满了蝎子",
        loc = { 6800, -7200 },
        mon = { "灰蝎妖", "毒蝎妖" },
        qty = { 9, 13 }, -- min -> max
        level = 30,
    },
    -- 冰极雪原 30-50
    {
        desc = "一大波的友善海豹在隐秘的河道栖息",
        loc = { -5530, 8535 },
        mon = { "海豹妖精" },
        qty = { 8, 10 }, -- min -> max
        level = 30,
    },
    {
        desc = "冰海的海豹上岸了",
        loc = { -5524, 6436 },
        mon = { "海豹妖精" },
        qty = { 5, 7 }, -- min -> max
        level = 32,
    },
    {
        desc = "雪原传来了猛熊的咆哮",
        loc = { -5328, 965 },
        mon = { "北极熊" },
        qty = { 2, 4 }, -- min -> max
        level = 33,
    },
    {
        desc = "雪原传来了群熊的咆哮",
        loc = { -6300, 1500 },
        mon = { "北极熊" },
        qty = { 6, 8 }, -- min -> max
        level = 34,
    },
    {
        desc = "大雪中隐匿着怪物",
        loc = { -5048, 3684 },
        mon = { "雪怪" },
        qty = { 5, 7 }, -- min -> max
        level = 35,
    },
    {
        desc = "大雪中隐匿着怪物",
        loc = { -7228, 2685 },
        mon = { "雪怪" },
        qty = { 5, 7 }, -- min -> max
        level = 35,
    },
    {
        desc = "大雪中隐匿着怪物",
        loc = { -8638, 3836 },
        mon = { "雪怪" },
        qty = { 5, 7 }, -- min -> max
        level = 40,
    },
    {
        desc = "大雪中隐匿着怪物",
        loc = { -6959, 5259 },
        mon = { "雪怪" },
        qty = { 5, 7 }, -- min -> max
        level = 45,
    },
    {
        desc = "暴雪堆积的山上，怪物暴走",
        loc = { -7592, 7578 },
        mon = { "雪怪", "北极熊" },
        qty = { 15, 20 }, -- min -> max
        level = 50,
    },
    -- 火蛇岛 51-70
    {
        desc = "烈焰中的妖魔出现在火蛇岛",
        loc = { 402, 4430 },
        mon = { "火蜥蜴", "小火妖" },
        qty = { 5, 7 }, -- min -> max
        level = 51,
    },
    {
        desc = "烈焰中的妖魔出现在火蛇岛",
        loc = { 2078, 2067 },
        mon = { "火蜥蜴", "小火妖", "小火龙" },
        qty = { 5, 7 }, -- min -> max
        level = 54,
    },
    {
        desc = "一大片飞龙从烈火中诞生",
        loc = { 1414, 4873 },
        mon = { "小火龙" },
        qty = { 8, 10 }, -- min -> max
        level = 56,
    },
    {
        desc = "烈焰中的妖魔出现在火蛇岛",
        loc = { 2881, 4730 },
        mon = { "火蜥蜴", "小火妖", "小火龙" },
        qty = { 5, 7 }, -- min -> max
        level = 58,
    },
    {
        desc = "一大片飞龙盘旋在火山",
        loc = { 1670, 7820 },
        mon = { "小火龙" },
        qty = { 7, 9 }, -- min -> max
        level = 60,
    },
    {
        desc = "强大的炎妖焚身而至",
        loc = { 935, 6717 },
        mon = { "小火妖" },
        qty = { 5, 7 }, -- min -> max
        level = 65,
    },
    {
        desc = "地狱火焰衍生妖魔",
        loc = { 2025, 8933 },
        mon = { "地狱火" },
        qty = { 5, 7 }, -- min -> max
        level = 68,
    },
    {
        desc = "地狱火焰衍生妖魔",
        loc = { 3377, 7131 },
        mon = { "地狱火" },
        qty = { 5, 7 }, -- min -> max
        level = 71,
    },
    {
        desc = "地狱火与龙诞生！",
        loc = { 4590, 5575 },
        mon = { "地狱火", "小火龙" },
        qty = { 5, 7 }, -- min -> max
        level = 74,
    },
    -- 枯死岸 75-100
    {
        desc = "骷髅在枯死岛横行",
        loc = { 6300, 8095 },
        mon = { "骷髅兵", "骷髅弓手" },
        qty = { 7, 11 }, -- min -> max
        level = 75,
    },
    {
        desc = "骷髅在枯死岛横行",
        loc = { 7935, 5592 },
        mon = { "骷髅兵", "骷髅弓手" },
        qty = { 7, 11 }, -- min -> max
        level = 77,
    },
    {
        desc = "骷髅在枯死岛横行",
        loc = { 6807, 6741 },
        mon = { "骷髅兵", "骷髅弓手" },
        qty = { 7, 11 }, -- min -> max
        level = 79,
    },
    {
        desc = "骷髅军团在枯死岛出现了！",
        loc = { 7847, 7890 },
        mon = { "骷髅兵", "骷髅弓手", "骷髅巨兵" },
        qty = { 25, 30 }, -- min -> max
        level = 82,
    },
    {
        desc = "恶灵上了树的身！",
        loc = { 5237, 8227 },
        mon = { "堕落树精" },
        qty = { 5, 7 }, -- min -> max
        level = 84,
    },
    {
        desc = "恶灵上了树的身！",
        loc = { 8484, 6250 },
        mon = { "堕落树精" },
        qty = { 5, 7 }, -- min -> max
        level = 86,
    },
    {
        desc = "恶灵上了树的身！",
        loc = { 7905, 5236 },
        mon = { "堕落树精" },
        qty = { 5, 7 }, -- min -> max
        level = 88,
    },
    {
        desc = "丧尸在枯死岛出现了！",
        loc = { 6961, 8430 },
        mon = { "僵尸仔" },
        qty = { 15, 20 }, -- min -> max
        level = 90,
    },
    {
        desc = "极坏丧尸在枯死岛出现了！",
        loc = { 8500, 8500 },
        mon = { "僵尸仔" },
        qty = { 10, 30 }, -- min -> max
        level = 100,
    },
}

-- 自动生成怪物
autoMonsterNormal = function(delay)
    htime.setTimeout(delay, function(curTimer)
        curTimer.destroy()
        if (monsterNormalAutoCount > 40) then
            autoMonsterNormal(10)
            return
        end
        local oi = {}
        for mi, m in ipairs(monsterNormal) do
            if (m.creating ~= true and (htime.min + 1) >= m.level) then
                table.insert(oi, mi)
            end
        end
        if (#oi > 0) then
            local mi = table.random(oi)
            local m = monsterNormal[mi]
            local w = 0
            m.creating = true
            monsterNormalAutoCount = monsterNormalAutoCount + 1
            echo(m.desc)
            cj.PingMinimapEx(m.loc[1], m.loc[2], 3.00, 255, 0, 0, true)
            htime.setInterval(2, function(curTimer2)
                if (w >= 3) then
                    curTimer2.destroy()
                    monsterNormalAutoCount = monsterNormalAutoCount - 1
                    htime.setTimeout(30, function(curTimer3)
                        curTimer3.destroy()
                        m.creating = false
                    end)
                    return
                end
                local g = hgroup.createByXY(m.loc[1], m.loc[2], 400, function(filterUnit)
                    return his.enemyPlayer(filterUnit, game.ALLY_PLAYER) and his.alive(filterUnit) and hunit.getUserData(filterUnit) == mi
                end)
                if (hgroup.count(g) <= 0) then
                    hgroup.clear(g, true, false)
                    local qty = math.random(m.qty[1], m.qty[2])
                    for _ = 1, qty, 1 do
                        local u = henemy.create({
                            id = hslk.n2i("[小怪]" .. table.random(m.mon)),
                            x = m.loc[1], --创建坐标X，可选
                            y = m.loc[2], --创建坐标Y，可选
                        })
                        hunit.setUserData(u, mi, 0)
                        local attr = {
                            life = "=" .. (19 + game.diff) * m.level,
                            attack_white = "=" .. (19 + game.diff) * m.level,
                        }
                        if (m.level >= 5) then
                            attr.defend_green = math.floor((m.level + game.diff) / 3)
                        end
                        if (m.level >= 50) then
                            attr.damage_reduction = math.floor((m.level + game.diff) / 3)
                            attr.avoid = m.level + game.diff - 50
                            attr.aim = m.level + game.diff - 50
                        end
                        hattr.set(u, 0, attr)
                        hevent.onDead(u, onNormalAward)
                    end
                    w = w + 1
                end
            end)
        end
        autoMonsterNormal(10)
    end)
end

autoMonsterNormal(10)