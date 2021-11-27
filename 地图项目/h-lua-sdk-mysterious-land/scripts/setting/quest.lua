-- 游戏任务（左边）
gameQuestPoint = 0
gameQuests = {
    state1 = nil, state2 = nil,
    state3 = nil, state4 = nil,
    state5 = nil, state6 = nil,
    state7 = nil, state8 = nil,
    state9 = nil, state10 = nil
}
gameQuestFlash = function(tit)
    echo(hcolor.green("#发现了新的事件：<" .. tit .. ">"))
    hquest.flash()
end
gameQuestComplete = function(quest, point)
    hquest.setCompleted(quest)
    point = point or 0
    gameQuestPoint = gameQuestPoint + point
end
gameQuestEvent = {
    state1 = function()
        local tit = "[主线]土匪 x 秘地傀儡"
        gameQuests.state1 = hquest.create(
            {
                title = tit,
                icon = "ReplaceableTextures\\CommandButtons\\BTNArmorGolem.blp",
                content = {
                    "又来到了神奇的秘地，这次一定要得悉最终的奥秘！",
                    "有几个[土匪]在早前先来搜刮财宝了，先把他们干掉吧。",
                    "可能还会有行动缓慢而又强大的守护者[秘地傀儡]",
                    "它被激怒时会渐渐强力反击，请小心",
                    "任务：" .. hcolor.yellow(" - 击败秘地傀儡"),
                    "成功：" .. hcolor.green(" - 秘地傀儡死亡"),
                    "失败：" .. hcolor.red(" - 复活耗光且死亡"),
                },
            }
        )
        gameQuestFlash(tit)
    end,
    state2 = function()
        gameQuestComplete(gameQuests.state1, 1)
        local tit = "[主线]寻找小神木商店"
        gameQuests.state2 = hquest.create(
            {
                title = tit,
                icon = "ReplaceableTextures\\CommandButtons\\BTNMurloc.blp",
                content = {
                    "终于打败了秘地傀儡，门后出现了一大片鱼妖",
                    "虽然鱼妖不强，但是这么多还是挺危险的，先把它们干掉吧~",
                    "任务：" .. hcolor.yellow(" - 到达小神木"),
                    "成功：" .. hcolor.green(" - 到达小神木（小神木后斜坡进入第3关）"),
                    "失败：" .. hcolor.red(" - 复活耗光且死亡"),
                },
            }
        )
        gameQuestFlash(tit)
    end,
    state3 = function()
        gameQuestComplete(gameQuests.state2, 1)
        local tit = "[主线]依靠篝火！勇战洞妖"
        gameQuests.state3 = hquest.create(
            {
                title = tit,
                icon = "ReplaceableTextures\\CommandButtons\\BTNFire.blp",
                content = {
                    "越过鱼妖，进入到了一个低地势山地，有4个山洞",
                    "山洞吹出奇怪的风，让人窒息，肯定是有妖魔在作祟",
                    "虽然可以不管继续前行，但[妖风]威力实在太强，只有在[篝火]旁才能歇息作战",
                    "任务：" .. hcolor.yellow(" - 保护[篝火]并打败洞穴boss"),
                    "成功：" .. hcolor.green(" - 打败洞穴boss"),
                    "失败：" .. hcolor.red(" - 复活耗光且死亡"),
                },
            }
        )
        gameQuestFlash(tit)
    end,
    state4 = function()
        gameQuestComplete(gameQuests.state3, 3)
        local tit = "[主线]寻找入海口"
        gameQuests.state4 = hquest.create(
            {
                title = tit,
                icon = "ReplaceableTextures\\CommandButtons\\BTNSummonWaterElemental.blp",
                content = {
                    "山洞boss真不好对付，是时候进入森林",
                    "森林里有很多敌人和机关，小心应付",
                    "任务：" .. hcolor.yellow(" - 打败森林boss"),
                    "成功：" .. hcolor.green(" - 打败boss后到达入海口"),
                    "失败：" .. hcolor.red(" - 复活耗光且死亡"),
                },
            }
        )
        gameQuestFlash(tit)
    end,
    state5 = function()
        gameQuestComplete(gameQuests.state4, 6)
        local tit = "[主线]大海探索"
        gameQuests.state5 = hquest.create(
            {
                title = tit,
                icon = "ReplaceableTextures\\CommandButtons\\BTNHumanDestroyer.blp",
                content = {
                    "来到一片广阔无垠的大海，探索吧~",
                    "大海天气变幻莫测，注意适应气候的变化",
                    "任务：" .. hcolor.yellow(" - 海中探秘"),
                    "成功：" .. hcolor.green(" - 打败所有大海boss"),
                    "失败：" .. hcolor.red(" - 复活耗光且死亡"),
                },
            }
        )
        gameQuestFlash(tit)
    end,
    state6 = function()
        gameQuestComplete(gameQuests.state5, 7)
        local tit = "[主线]神秘之城"
        gameQuests.state6 = hquest.create(
            {
                title = tit,
                icon = "ReplaceableTextures\\CommandButtons\\BTNCastle.blp",
                content = {
                    "没想到大海西岸竟然有一大座城市，城市的人都很友好",
                    "在这个城市休息一下，购入一些物资吧！",
                    "任务：" .. hcolor.yellow(" - 保护神秘城市"),
                    "成功：" .. hcolor.green(" - 保护神秘城市国王成功"),
                    "失败：" .. hcolor.red(" - 城市国王死亡；复活耗光且死亡"),
                },
            }
        )
        gameQuestFlash(tit)
    end,
    state7 = function()
        gameQuestComplete(gameQuests.state6, 4)
        local tit = "[主线]茫茫雪原"
        gameQuests.state7 = hquest.create(
            {
                title = tit,
                icon = "ReplaceableTextures\\CommandButtons\\BTNHumanDestroyer.blp",
                content = {
                    "来到一片广阔无垠的大海，探索吧~",
                    "大海天气变幻莫测，注意适应气候的变化",
                    "任务：" .. hcolor.yellow(" - 海中探秘"),
                    "成功：" .. hcolor.green(" - 打败所有大海boss"),
                    "失败：" .. hcolor.red(" - 复活耗光且死亡"),
                },
            }
        )
        gameQuestFlash(tit)
    end,
    state8 = function()
        gameQuestComplete(gameQuests.state7, 9)
        local tit = "[主线]枯死之地"
        gameQuests.state8 = hquest.create(
            {
                title = tit,
                icon = "ReplaceableTextures\\CommandButtons\\BTNAnimateDead.blp",
                content = {
                    "来到一片广阔无垠的大海，探索吧~",
                    "大海天气变幻莫测，注意适应气候的变化",
                    "任务：" .. hcolor.yellow(" - 海中探秘"),
                    "成功：" .. hcolor.green(" - 打败所有大海boss"),
                    "失败：" .. hcolor.red(" - 复活耗光且死亡"),
                },
            }
        )
        gameQuestFlash(tit)
    end,
    state9 = function()
        gameQuestComplete(gameQuests.state8, 13)
        local tit = "[主线]火海决战"
        gameQuests.state9 = hquest.create(
            {
                title = tit,
                icon = "ReplaceableTextures\\CommandButtons\\BTNWallOfFire.blp",
                content = {
                    "枯地的尽头有座桥，桥后是一片大火山山地",
                    "火海中一直有山火焚烧，非常难受，注意抵抗火焰",
                    "任务：" .. hcolor.yellow(" - 破灭火海"),
                    "成功：" .. hcolor.green(" - 寻找到火海中的宝藏"),
                    "失败：" .. hcolor.red(" - 复活耗光且死亡"),
                },
            }
        )
        gameQuestFlash(tit)
    end,
    state10 = function()
        gameQuestComplete(gameQuests.state9, 20)
        local tit = "[主线]探奇宝藏"
        gameQuests.state10 = hquest.create(
            {
                title = tit,
                icon = "ReplaceableTextures\\CommandButtons\\BTNWallOfFire.blp",
                content = {
                    "枯地的尽头有座桥，桥后是一片大火山山地",
                    "火海中一直有山火焚烧，非常难受，注意抵抗火焰",
                    "任务：" .. hcolor.yellow(" - 破灭火海"),
                    "成功：" .. hcolor.green(" - 寻找到火海中的宝藏"),
                    "失败：" .. hcolor.red(" - 复活耗光且死亡"),
                },
            }
        )
        gameQuestFlash(tit)
    end,
}