monsterEliteAutoCount = 0
monsterElite = {
    -- 七灵 1
    {
        time = 120, -- 多少时间才有可能生成
        desc = "七灵东湾",
        loc = { 1787, -1538 },
        mon = { "大龙龟" },
        level = 1,
    },
    {
        time = 120, -- 多少时间才有可能生成
        desc = "七灵北湾",
        loc = { 1600, 1600 },
        mon = { "大龙龟" },
        level = 1,
    },
    -- 斑斓海 2-5
    {
        time = 120, -- 多少时间才有可能生成
        desc = "斑斓海入海口",
        loc = { -2400, -3875 },
        mon = { "大龙龟" },
        level = 2,
    },
    --{
    --    time = 120, -- 多少时间才有可能生成
    --    desc = "秘潭湖中央",
    --    loc = { -75, -7655 },
    --    mon = { "小鱼妖", "蟹妖", "小虾妖" },
    --    level = 1,
    --},
}

-- 自动生成精英怪
autoMonsterElite = function(delay)
    htime.setTimeout(delay, function(curTimer)
        curTimer.destroy()
        if (monsterEliteAutoCount > 20) then
            autoMonsterElite(30)
            return
        end
        local oi = {}
        for mi, m in ipairs(monsterElite) do
            if (m.creating ~= true and htime.count > m.time) then
                table.insert(oi, mi)
            end
        end
        if (#oi > 0) then
            local mi = table.random(oi)
            local m = monsterElite[mi]
            local w = 0
            m.creating = true
            monsterEliteAutoCount = monsterEliteAutoCount + 1
            echo(m.desc .. "出现了精英妖魔")
            cj.PingMinimapEx(m.loc[1], m.loc[2], 3.00, 255, 0, 0, true)
            htime.setInterval(3, function(curTimer2)
                if (w >= 2) then
                    curTimer2.destroy()
                    monsterEliteAutoCount = monsterEliteAutoCount - 1
                    htime.setTimeout(90, function(curTimer3)
                        curTimer3.destroy()
                        m.creating = false
                    end)
                    return
                end
                local g = hgroup.createByXY(m.loc[1], m.loc[2], 600, function(filterUnit)
                    return his.enemyPlayer(filterUnit, game.ALLY_PLAYER) and his.alive(filterUnit) and hunit.getUserData(filterUnit) == mi * 1000
                end)
                if (hgroup.count(g) <= 0) then
                    hgroup.clear(g, true, false)
                    for _ = 1, 3 do
                        local u = henemy.create({
                            id = hslk.n2i("[精英]" .. table.random(m.mon)),
                            x = m.loc[1], --创建坐标X，可选
                            y = m.loc[2], --创建坐标Y，可选
                        })
                        hunit.setUserData(u, mi * 1000, 0)
                        local attr = {
                            life = "=" .. (199 + game.diff) * m.level,
                            attack_white = "=" .. (99 + game.diff) * m.level,
                            defend_green = "=" .. math.floor(m.level * 1.5 + game.diff / 2),
                            damage_reduction = "=" .. m.level + game.diff,
                            avoid = "=" .. m.level + game.diff,
                            aim = "=" .. m.level + game.diff,
                        }
                        hattr.set(u, 0, attr)
                        hevent.onDead(u, onEliteAward)
                        htime.setTimeout(180, function(normalTimer)
                            normalTimer.destroy()
                            if (his.alive(u)) then
                                cj.IssuePointOrder(u, "attack", hunit.x(game.sevenStone), hunit.y(game.sevenStone))
                            end
                        end)
                    end
                    w = w + 1
                end
            end)
        end
        autoMonsterElite(60)
    end)
end

autoMonsterElite(90)