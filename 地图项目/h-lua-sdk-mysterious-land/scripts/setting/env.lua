-- env岛屿环境
islands = {
    {
        name = "初始之地",
        rect = hrect.create(-6100, -8745, 2304, 1228, "初始之地"),
        env = nil,
        bgm = nil,
        allowWeather = {
            { weather = "time" },
        },
    },
    {
        name = "内山小湾",
        rect = hrect.create(-3580, -8702, 2048, 2048, "内山小湾"),
        env = nil,
        bgm = nil,
        allowWeather = {
            { weather = "time" },
            { weather = hweather.rain },
        },
    },
    {
        name = "篝火洞府",
        rect = hrect.create(-770, -8446, 2560, 2432, "篝火洞府"),
        env = "ruins",
        bgm = SOUND.bgm_stage3,
        allowWeather = {
            { weather = hweather.rain },
            { weather = hweather.wind },
        },
    },
    {
        name = "迷惑之森",
        rect = hrect.create(5385, -7171, 7930, 5100, "迷惑之森"),
        env = "summer",
        bgm = SOUND.bgm_stage4,
        allowWeather = {
            { weather = "time" },
            { weather = hweather.rain },
            { weather = hweather.rainstorm },
        },
    },
    {
        name = "斑斓海",
        rect = hrect.create(-5896, -2830, 4608, 4608, "斑斓海"),
        env = "sea",
        bgm = nil,
        allowWeather = {
            { weather = hweather.rainstorm },
            { weather = hweather.mistwhite },
            { weather = hweather.snow },
        },
    },
    {
        name = "斑斓海2",
        rect = hrect.create(-4096, -4096, 4096, 3584, "斑斓海2"),
        env = "sea",
        bgm = nil,
        allowWeather = {
            { weather = hweather.rain },
            { weather = hweather.rainstorm },
            { weather = hweather.mistwhite },
        },
    },
    {
        name = "金钟之城",
        rect = hrect.create(-6655, 5633, 5000, 7100, "金钟之城"),
        env = nil,
        bgm = SOUND.bgm_stage6,
        allowWeather = {
            { weather = "time" },
        },
    },
    {
        name = "雪原",
        rect = hrect.create(-773, 2300, 5632, 5632, "雪原"),
        env = "winter",
        bgm = SOUND.bgm_stage7,
        allowWeather = {
            { weather = hweather.mistwhite },
            { weather = hweather.snow },
            { weather = hweather.snowstorm },
        },
    },
    {
        name = "雪原2",
        rect = hrect.create(-773, 2300, 4096, 6144, "雪原2"),
        env = "winterDeep",
        bgm = SOUND.bgm_stage7,
        allowWeather = {
            { weather = hweather.mistwhite },
            { weather = hweather.snow },
            { weather = hweather.snowstorm },
        },
    },
    {
        name = "枯死地",
        rect = hrect.create(6660, 1434, 4700, 4700, "枯死地"),
        env = "dark",
        bgm = "nil",
        allowWeather = {
            { weather = hweather.mistgreen },
            { weather = hweather.mistblue },
            { weather = hweather.shield },
        },
    },
    {
        name = "火蛇山",
        rect = hrect.create(3467, 7168, 10240, 3584, "火蛇山"),
        env = "fire",
        bgm = SOUND.bgm_stage9,
        allowWeather = {
            { weather = hweather.mistred },
        },
    },
}
-- 自动天气
autoWeather = function(obj)
    local during = math.random(120, 300)
    if (#obj.allowWeather > 0) then
        local which = obj.allowWeather[math.random(1, #obj.allowWeather)]
        local weather = which.weather
        if (weather == "time") then
            if (htime.isDay()) then
                during = (18 - cj.GetFloatGameState(GAME_STATE_TIME_OF_DAY)) * 20
                weather = hweather.sun
            else
                if (cj.GetFloatGameState(GAME_STATE_TIME_OF_DAY) < 6.00) then
                    during = (6 - cj.GetFloatGameState(GAME_STATE_TIME_OF_DAY)) * 20
                else
                    during = (24 - cj.GetFloatGameState(GAME_STATE_TIME_OF_DAY)) * 20
                end
                weather = hweather.moon
            end
        end
        game.island[obj.name] = weather
        hweather.create({
            whichRect = obj.rect,
            type = weather,
            during = during
        })
        -- 音效
        if (weather == hweather.sun) then
            hsound.voice2Rect(SOUND.voice_rect_sun, obj.rect, during - 1)
        elseif (weather == hweather.moon) then
            hsound.voice2Rect(SOUND.voice_rect_moon, obj.rect, during - 1)
        elseif (weather == hweather.wind or weather == hweather.windstorm) then
            hsound.voice2Rect(SOUND.voice_rect_wind, obj.rect, during - 1)
        elseif (weather == hweather.rainstorm) then
            hsound.voice2Rect(SOUND.voice_rect_rainstorm, obj.rect, during - 1)
        end
        local dur = 0
        htime.setInterval(4, function(t)
            dur = dur + 4
            if (dur >= during) then
                t.destroy()
                autoWeather(obj)
                return
            end
            if (weather == hweather.sun) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit) and his.playing(hunit.getOwner(filterUnit))
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 4) == 1) then
                        httg.style(
                            httg.create2Unit(enumUnit, "阳光回照", 10, "FFD700", 1, 2, 50),
                            'scale', 0, 0.05
                        )
                        heffect.bindUnit(
                            "Abilities\\Spells\\NightElf\\Rejuvenation\\RejuvenationTarget.mdl",
                            enumUnit, "origin", 5
                        )
                        hattr.set(enumUnit, 5, {
                            life_back = "+" .. math.floor(50 - game.diff * 0.5),
                        })
                    end
                end, true)
            elseif (weather == hweather.moon) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit) and his.playing(hunit.getOwner(filterUnit))
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 4) == 1) then
                        httg.style(
                            httg.create2Unit(enumUnit, "月光护佑", 10, "00BFFF", 1, 2, 50),
                            'scale', 0, 0.05
                        )
                        heffect.bindUnit(
                            "Abilities\\Spells\\Items\\ClarityPotion\\ClarityTarget.mdl",
                            enumUnit, "origin", 5
                        )
                        hattr.set(enumUnit, 5, {
                            mana_back = "+" .. (60 - 2 * game.diff),
                        })
                    end
                end, true)
            elseif (weather == hweather.rain) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit)
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 3) == 1) then
                        httg.style(
                            httg.create2Unit(enumUnit, "雨水浸透", 10, "87CEFA", 1, 2, 50),
                            'scale', 0, 0.05
                        )
                        heffect.bindUnit(
                            "Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl",
                            enumUnit, "origin", 5
                        )
                        hattr.set(enumUnit, 5, {
                            move = "-" .. (20 + game.diff),
                            defend_green = "-" .. (1 + game.diff),
                        })
                    end
                end, true)
            elseif (weather == hweather.rainstorm) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit)
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 3) == 1) then
                        httg.style(
                            httg.create2Unit(enumUnit, "大雨蹉跎", 10, "4682B4", 1, 2, 50),
                            'scale', 0, 0.05
                        )
                        heffect.bindUnit(
                            "Abilities\\Spells\\Other\\AcidBomb\\BottleImpact.mdl",
                            enumUnit, "origin", 7
                        )
                        hattr.set(enumUnit, 7, {
                            attack_speed = "-" .. (10 + game.diff),
                            move = "-" .. (30 + game.diff),
                            defend_green = "-" .. (3 + game.diff),
                        })
                    end
                end, true)
                -- 雷暴
                for i = 1, (4 + game.diff) do
                    htime.setTimeout(i * 0.1, function(ti)
                        ti.destroy()
                        local x = math.random(hrect.getMinX(obj.rect), hrect.getMaxX(obj.rect))
                        local y = math.random(hrect.getMinY(obj.rect), hrect.getMaxY(obj.rect))
                        local radius = 120 + 10 * game.diff
                        htexture.alertCircle(radius * 2, x, y, 2)
                        htime.setTimeout(2, function(tl)
                            tl.destroy()
                            heffect.toXY("Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl", x, y)
                            local g2 = hgroup.createByXY(x, y, radius, function(filterUnit)
                                return his.hero(filterUnit) and his.alive(filterUnit)
                            end)
                            hgroup.forEach(g2, function(enumUnit)
                                hskill.swim({
                                    whichUnit = enumUnit,
                                    damage = (0.35 + 0.05 * game.diff) * hunit.getCurLife(enumUnit),
                                    during = 2 + 0.3 * game.diff,
                                    odds = 100,
                                    effect = "Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl",
                                    damageSrc = CONST_DAMAGE_SRC.unknown,
                                    damageType = { CONST_DAMAGE_TYPE.thunder }
                                })
                                local duri = 7
                                heffect.bindUnit(
                                    "Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl",
                                    enumUnit, "origin", duri
                                )
                                hattr.set(enumUnit, duri, {
                                    attack_speed = "-" .. (20 + game.diff),
                                    move = "-" .. (100 + game.diff),
                                })
                                htexture.mark(htexture.DEFAULT_MARKS.DIAGONAL_SLASH, duri, hunit.getOwner(enumUnit), 0, 0, 255)
                                hsound.voice2Player(SOUND.voice_thunder, hunit.getOwner(enumUnit))
                            end, true)
                        end)
                    end)
                end
            elseif (weather == hweather.snow) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit)
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 3) == 1) then
                        httg.style(
                            httg.create2Unit(enumUnit, "飘雪冻结", 10, "F0FFFF", 1, 2, 50),
                            'scale', 0, 0.05
                        )
                        heffect.toUnit("Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl", enumUnit)
                        heffect.bindUnit(
                            "Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorDamage.mdl",
                            enumUnit, "origin", 12
                        )
                        hattr.set(enumUnit, 12, {
                            attack_speed = "-" .. (4 + game.diff),
                            move = "-" .. (15 + game.diff),
                        })
                    end
                end, true)
            elseif (weather == hweather.snowstorm) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit)
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 2) == 1) then
                        httg.style(
                            httg.create2Unit(enumUnit, "雪崩", 10, "F0FFFF", 1, 2, 50),
                            'scale', 0, 0.05
                        )
                        heffect.toUnit("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", enumUnit)
                        heffect.bindUnit(
                            "Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorDamage.mdl",
                            enumUnit, "origin", 12
                        )
                        hattr.set(enumUnit, 12, {
                            attack_speed = "-" .. (6 + game.diff),
                            move = "-" .. (18 + game.diff),
                            defend_green = "-" .. game.diff,
                        })
                    end
                end, true)
            elseif (weather == hweather.wind) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit)
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 3) == 1) then
                        httg.style(
                            httg.create2Unit(enumUnit, "大风吹刮", 10, "7FFFAA", 1, 2, 50),
                            'scale', 0, 0.05
                        )
                        heffect.toUnit("Abilities\\Spells\\Other\\Tornado\\TornadoElementalSmall.mdl", enumUnit, 1)
                        hskill.crackFly({
                            whichUnit = enumUnit,
                            damage = 0,
                            odds = 100,
                            distance = 0,
                            high = 100,
                            during = 1.0,
                        })
                        hattr.set(enumUnit, 2.5, {
                            move = "-" .. (30 + game.diff),
                        })
                        hsound.voice2Player(SOUND.voice_wind, hunit.getOwner(enumUnit))
                    end
                end, true)
            elseif (weather == hweather.windstorm) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit)
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 3) == 1) then
                        httg.style(
                            httg.create2Unit(enumUnit, "狂风割裂", 10, "00FA9A", 1, 2, 50),
                            'scale', 0, 0.05
                        )
                        heffect.toUnit("Abilities\\Spells\\NightElf\\Cyclone\\CycloneTarget.mdl", enumUnit, 1)
                        hskill.crackFly({
                            whichUnit = enumUnit,
                            damage = 0,
                            odds = 100,
                            distance = 0,
                            high = 200,
                            during = 1.4,
                        })
                        hattr.set(enumUnit, 2.5, {
                            move = "-" .. (50 + game.diff),
                        })
                        hsound.voice2Player(SOUND.voice_wind, hunit.getOwner(enumUnit))
                    end
                end, true)
            elseif (weather == hweather.mistwhite) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    local owner = hunit.getOwner(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit) and (true ~= his.marking(owner))
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 3) == 1) then
                        httg.style(
                            httg.create2Unit(enumUnit, "白雾蔽目", 10, "F5FFFA", 1, 2, 50),
                            'scale', 0, 0.05
                        )
                        local duri = 7
                        heffect.bindUnit("Abilities\\Spells\\Undead\\Cripple\\CrippleTarget.mdl", enumUnit, "head", duri)
                        hattr.set(enumUnit, duri, {
                            sight = "-" .. (300 + 75 * game.diff),
                        })
                        htexture.mark(htexture.DEFAULT_MARKS.DREAM, duri, hunit.getOwner(enumUnit), 255, 255, 255)
                    end
                end, true)
            elseif (weather == hweather.mistred) then
                -- 陨石
                for i = 1, (3 + game.diff) do
                    htime.setTimeout(i * 0.1, function(ti)
                        ti.destroy()
                        local x = math.random(hrect.getMinX(obj.rect), hrect.getMaxX(obj.rect))
                        local y = math.random(hrect.getMinY(obj.rect), hrect.getMaxY(obj.rect))
                        local radius = 180 + 10 * game.diff
                        htexture.alertCircle(radius * 2, x, y, 2)
                        heffect.toXY("Units\\Demon\\Infernal\\InfernalBirth.mdl", x, y)
                        htime.setTimeout(0.8, function(tl)
                            tl.destroy()
                            local g2 = hgroup.createByXY(x, y, radius, function(filterUnit)
                                return his.hero(filterUnit) and his.alive(filterUnit)
                            end)
                            hgroup.forEach(g2, function(enumUnit)
                                hskill.swim({
                                    whichUnit = enumUnit,
                                    damage = (0.5 + 0.1 * game.diff) * hunit.getCurLife(enumUnit),
                                    during = 1.6 + 0.2 * game.diff,
                                    odds = 100,
                                    effect = "Abilities\\Spells\\Other\\Volcano\\VolcanoDeath.mdl",
                                    damageSrc = CONST_DAMAGE_SRC.unknown,
                                    damageType = { CONST_DAMAGE_TYPE.fire, CONST_DAMAGE_TYPE.real }
                                })
                            end, true)
                        end)
                    end)
                end
                -- 火焰灼烧
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    local owner = hunit.getOwner(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit) and (true ~= his.marking(owner))
                end)
                hgroup.forEach(g, function(enumUnit)
                    httg.style(
                        httg.create2Unit(enumUnit, "山火焚身", 10, "FF6347", 1, 2, 50),
                        'scale', 0, 0.05
                    )
                    heffect.bindUnit("Environment\\LargeBuildingFire\\LargeBuildingFire0.mdl", enumUnit, "origin", 7)
                    local burn = 300 * game.diff
                    local oppose = hattr.get(enumUnit, "natural_fire_oppose")
                    burn = math.round(burn * (1 - oppose * 0.01))
                    if (burn > 0) then
                        hskill.damageStep({
                            whichUnit = enumUnit, --受伤单位（必须有）
                            frequency = 0.25, --伤害频率（必须有）
                            times = 5, --伤害次数（必须有）
                            effect = "", --特效（可选）
                            damage = burn, --单次伤害（大于0）
                            sourceUnit = nil, --伤害来源单位（可选）
                            damageSrc = CONST_DAMAGE_SRC.unknown,
                            damageType = { CONST_DAMAGE_TYPE.fire },
                        })
                    end
                end, true)
            elseif (weather == hweather.mistgreen) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit)
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 3) == 1) then
                        httg.style(
                            httg.create2Unit(enumUnit, "毒雾侵蚀", 10, "7FFF00", 1, 2, 50),
                            'scale', 0, 0.05
                        )
                        heffect.bindUnit("Abilities\\Spells\\Human\\Banish\\BanishTarget.mdl", enumUnit, "origin", 7)
                        local poison = 500 * game.diff
                        local oppose = hattr.get(enumUnit, "natural_poison_oppose")
                        poison = math.round(poison * (1 - oppose * 0.01))
                        if (poison > 0) then
                            hattr.set(enumUnit, 5, {
                                life_back = "-" .. poison,
                            })
                        end
                    end
                end, true)
            elseif (weather == hweather.mistblue) then
                local g = hgroup.createByRect(obj.rect, function(filterUnit)
                    return his.hero(filterUnit) and his.alive(filterUnit)
                end)
                hgroup.forEach(g, function(enumUnit)
                    if (math.random(1, 3) == 1) then
                        hskill.swim({
                            whichUnit = enumUnit,
                            damage = 50 * game.diff,
                            during = 1.0 + 0.25 * game.diff,
                            odds = 100,
                            effect = "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl",
                            damageSrc = CONST_DAMAGE_SRC.unknown,
                            damageType = { CONST_DAMAGE_TYPE.dark }
                        })
                    end
                    httg.style(
                        httg.create2Unit(enumUnit, "迷惑蓝烟", 10, "4169E1", 1, 2, 50),
                        'scale', 0, 0.05
                    )
                end, true)
            elseif (weather == hweather.shield) then
                -- 紫光爆炸
                for i = 1, (6 + game.diff) do
                    htime.setTimeout(i * 0.3, function(ti)
                        ti.destroy()
                        local x = math.random(hrect.getMinX(obj.rect), hrect.getMaxX(obj.rect))
                        local y = math.random(hrect.getMinY(obj.rect), hrect.getMaxY(obj.rect))
                        local radius = 150 + 10 * game.diff
                        htexture.alertCircle(radius * 2, x, y, 2)
                        htime.setTimeout(2, function(tl)
                            tl.destroy()
                            heffect.toXY("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", x, y)
                            local g2 = hgroup.createByXY(x, y, radius, function(filterUnit)
                                return his.hero(filterUnit) and his.alive(filterUnit)
                            end)
                            hgroup.forEach(g2, function(enumUnit)
                                hskill.swim({
                                    whichUnit = enumUnit,
                                    damage = (0.4 + 0.05 * game.diff) * hunit.getMaxLife(enumUnit),
                                    during = 2 + 0.3 * game.diff,
                                    odds = 100,
                                    effect = "Abilities\\Spells\\NightElf\\shadowstrike\\shadowstrike.mdl",
                                    damageSrc = CONST_DAMAGE_SRC.unknown,
                                    damageType = { CONST_DAMAGE_TYPE.thunder }
                                })
                                heffect.bindUnit(
                                    "Abilities\\Spells\\Orc\\Purge\\PurgeBuffTarget.mdl",
                                    enumUnit, "origin", 7
                                )
                                hattr.set(enumUnit, 7, {
                                    defend_green = "-" .. (5 + 2 * game.diff),
                                })
                                hsound.voice2Player(SOUND.voice_ghost, hunit.getOwner(enumUnit))
                            end, true)
                        end)
                    end)
                end
            end
        end)
    end
end

for _, v in ipairs(islands) do
    -- 随机装饰
    if (v.env ~= nil) then
        henv.random(v.rect, v.env, false, false)
    end
    -- 天气
    htime.setTimeout(math.random(20, 30), function(t)
        t.destroy()
        autoWeather(v)
    end)
    -- 海域
    if (v.name == "斑斓海" or v.name == "斑斓海2") then
        hsound.voice2Rect(SOUND.voice_rect_sea, v.rect)
    end
end