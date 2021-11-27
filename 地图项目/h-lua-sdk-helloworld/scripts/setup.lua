SETUP = function()
    -- 设定玩家
    hplayer.qty_max = 2 -- 最大玩家数
    hplayer.convert_ratio = 1000000 -- 换算比率，100金 -> 1木

    -- 设定玩家支持的默认命令
    hcmd.conf({ "-gg", "-apm", "-apc", "-random", "-repick", "-d" }, { 1 })

    -- 设定敌军
    henemy.set("怪物", nil, { 2 }, false)

    -- 调试自动去除迷雾
    henv.setFogStatus(DEBUGGING == false, DEBUGGING == false)

    --- 设定获得黄金木头特效
    hevent.onPlayerResourceChange(function(evtData)
        if (evtData.triggerUnit ~= nil and evtData.value > 0) then
            local u = evtData.triggerUnit
            local val = math.floor(evtData.value)
            if (evtData.type == 'gold') then
                htextTag.model({ msg = "+" .. val .. "金", whichUnit = u, red = 255, green = 215, blue = 0 })
                hsound.voice2Unit(JassGlobals.gg_snd_ReceiveGold, 100, u)
            elseif (evtData.type == 'lumber') then
                htextTag.model({ msg = "+" .. val .. "木", whichUnit = u, red = 34, green = 139, blue = 34 })
                hsound.voice2Unit(JassGlobals.gg_snd_BundleOfLumber, 100, u)
            end
        end
    end)

    --- 经验获取
    onExp = function(u)
        hevent.onExp(u, function(evtData)
            htextTag.model({ msg = "+" .. evtData.value .. " 经验", whichUnit = u, red = 50, green = 50, blue = 251 })
        end)
    end

    -- 配置一个双火爆破附魔环境
    henchant.enableAppend(true) -- 先启用附魔附着
    henchant.setAppendAttachEffect('fire', {
        { attach = 'origin', effect = 'Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl' },
        { attach = 'left hand', effect = 'Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl' },
        { attach = 'right hand', effect = 'Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl' },
        { attach = 'head', effect = 'Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireDamage.mdl' },
    })
    henchant.setEnvReaction('fire', 'water', function(evtData)
        htextTag.model({ msg = "水爆 -" .. evtData.level, whichUnit = evtData.targetUnit, red = 0, green = 245, blue = 255 })
        hunit.setRGBA(evtData.targetUnit, math.random(55, 255), 0, 0, nil, 0.5)
        if (math.random(1, 10) == 5) then
            hskill.damageRange({
                radius = 100,
                frequency = 0.25,
                times = 3,
                effectSingle = "Abilities\\Spells\\Other\\Monsoon\\MonsoonBoltTarget.mdl",
                filter = function(filterUnit)
                    return his.enemy(evtData.sourceUnit, filterUnit) and his.alive(filterUnit)
                end,
                x = hunit.x(evtData.targetUnit),
                y = hunit.y(evtData.targetUnit),
                damage = 666,
                sourceUnit = evtData.sourceUnit,
                damageSrc = CONST_DAMAGE_SRC.skill,
                damageType = { CONST_DAMAGE_TYPE.thunder }
            })
        end
    end)

    -- 映射属性
    hattribute.setRelation({
        primary = 0,
        str = nil,
        agi = nil,
        int = {
            mana = 5,
            mana_back = 0.1,
        },
    })
end
