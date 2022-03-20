-- 设定玩家
hplayer.qty_max = 7 -- 最大玩家数
hplayer.convert_ratio = 1000000 -- 换算比率，100金 -> 1木

-- 设定玩家支持的默认命令
hcmd.conf({ "-gg", "-apm", "-random", "-repick", "-d" }, { 1 })

-- 设定敌军
henemy.set("怪物", PLAYER_COLOR_BLACK, { 8, 9, 10, 11 })

--- 设定获得黄金木头特效
hevent.onPlayerResourceChange(function(evtData)
    if (evtData.triggerUnit ~= nil and evtData.value > 0) then
        local u = evtData.triggerUnit
        local val = math.floor(evtData.value)
        if (evtData.type == 'gold') then
            htextTag.style(htextTag.create2Unit(u, "+" .. val .. " 万担金", 6, "ffcc00", 1, 1.70, 60.00), "toggle", 0, 0.20)
            hsound.voice2Unit(SOUND.voice_ReceiveGold, 100, u)
        elseif (evtData.type == 'lumber') then
            htextTag.style(htextTag.create2Unit(u, "+" .. val .. " 精选木", 7, "80ff80", 1, 1.70, 60.00), "toggle", 0, 0.20)
            hsound.voice2Unit(SOUND.voice_BundleOfLumber, 100, u)
        end
    end
end)

hevent_default_actions.hero.reborn = function(u, rebornSec)
    local p = hunit.getOwner(u)
    if (game.rebornQty <= 0) then
        echo(hcolor.red(hplayer.getName(p)) .. "的英雄不幸死亡了，他离开了我们")
        hplayer.defeat(p, "冒险失败")
        return
    end
    game.rebornQty = game.rebornQty - 1
    echo(hcolor.green(hplayer.getName(p)) .. "的英雄死亡了，" .. hcolor.yellow(rebornSec) .. '秒后复活')
    -- 中途心跳声
    local heartBeatTimer = htime.setInterval(1.8, function(_)
        hsound.voice2Player(SOUND.voice_heart_beat, p)
    end)
    htime.setTimeout(rebornSec, function(heartTimer)
        heartTimer.destroy()
        heartBeatTimer.destroy()
    end)
    local x = hunit.x(u)
    local y = hunit.y(u)
    if (rebornSec > 0) then
        htexture.mark(htexture.DEFAULT_MARKS.DREAM, rebornSec, p, 255, 0, 0)
        local ghost = hunit.create({
            register = false,
            whichPlayer = hplayer.player_passive,
            id = hunit.getId(u),
            x = x,
            y = y,
            facing = 270,
            height = 40,
            modelScale = 0.9,
            opacity = 0.6,
            isShadow = true,
            isInvulnerable = true,
            during = rebornSec,
        })
        hunit.setColor(ghost, hplayer.index(p))
        hunit.create({
            register = false,
            whichPlayer = p,
            id = HL_ID.hero_death_token,
            x = x,
            y = y,
            opacity = 0.8,
            isShadow = true,
            isInvulnerable = true,
            during = rebornSec,
            timeScale = 10 / rebornSec,
        })
    end
    hhero.reborn(u, rebornSec, 1, x, y)
end

--- 英雄被选择
hevent.onPickHero(function(evtPickData)
    local newHero = evtPickData.triggerUnit
    local owner = hunit.getOwner(newHero)
    echo(hcolor.green(hplayer.getName(owner)) .. "的英雄灵魂成为了" .. hcolor.yellow("<" .. hunit.getName(newHero) .. ">"))
    local heroId = hunit.getId(newHero)
    local heroSlk = hslk.i2v(heroId)
    -- 镜头
    hcamera.toUnit(owner, 0, newHero)
    -- 初始属性
    hattr.set(newHero, 0, {
        reborn = "=5",
        weight = "=3",
        punish = "=1000",
        punish_current = "=1000"
    })
    -- 特性、技能、天赋
    if (heroSlk ~= nil) then
        local feature = heroSlk._feature
        if (feature ~= nil) then
            feature = "特性 - " .. feature
            hskill.add(newHero, hslk.n2i(feature))
        end
        hskill.add(newHero, hslk.n2i("武 - 封印"))
        hskill.add(newHero, hslk.n2i("御 - 封印"))
        hskill.add(newHero, hslk.n2i("速 - 封印"))
        hskill.add(newHero, hslk.n2i("奇 - 封印"))
    end
    --- 升级
    hevent.onLevelUp(newHero, function(evtData)
        local primary = hhero.getPrimary(evtData.triggerUnit)
        print("primary", primary)
    end)
    --- 经验收获
    hevent.onDamage(newHero, function(evtData)
        local exp = math.floor(evtData.damage * 0.1)
        haward.forUnitExp(evtData.triggerUnit, exp)
    end)
    -- dz奖励
    local mapLv = hdzapi.mapLevel(owner)
    if (mapLv > 9) then
        hitem.create({
            id = hslk.n2i("初始月钥-Max"),
            charges = 1,
            whichUnit = newHero,
        })
    else
        hitem.create({
            id = hslk.n2i("初始月钥-Lv" .. mapLv),
            charges = 1,
            whichUnit = newHero,
        })
    end
    local prestige = hplayer.getPrestige(owner)
    hitem.create({
        id = hslk.n2i("诀尊阳钥[" .. prestige .. "专享]"),
        charges = 1,
        whichUnit = newHero,
    })
end)

-- 映射属性
hattr.setRelation({
    primary = 1,
    str = {
        life = 16,
        life_back = 0.03,
        aim = 0.003
    },
    agi = {
        attack_speed = 0.01,
        avoid = 0.003
    },
    int = {
        mana = 8,
        mana_back = 0.02
    }
})