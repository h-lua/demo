SETUP = function()
    -- 设定玩家
    hplayer.qty_max = 2 -- 最大玩家数
    hplayer.convert_ratio = 1000000 -- 换算比率，100金 -> 1木

    -- 设定玩家支持的默认命令
    hcmd.conf({ "-gg", "-apm", "-apc", "-random", "-repick", "-d" }, { 1 })

    -- 设定敌军
    henemy.set("怪物", nil, { 2 }, false)

    cj.FogEnable(false)
    cj.FogMaskEnable(false)

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
