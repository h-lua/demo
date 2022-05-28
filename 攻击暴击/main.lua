--- Generated by h-lua(https://github.com/h-lua/h-lua)

require "h-lua" -- h-lua库
require "scripts.alias" -- alias h-lua库别称（参考）
require "scripts.setup" -- setup 游戏准备
require "scripts.damaging" -- 暴击设定
require "scripts.eventReaction" -- 暴击反应
require "scripts.ui" -- UI

-- h-lua main function 主函数入口
-- The game starts here 游戏从main函数开始运行
function main()

    SETUP()
    UI()

    print("hello world!")
    echo("你好，世界！")

    hitem.create({
        id = hslk.n2i("物理学圣剑"),
        x = 100,
        y = 0,
    })

    hunit.create({
        whichPlayer = hplayer.players[1],
        id = hslk.n2i("剑圣"),
        x = 0,
        y = 0,
        isOpenSlot = true,
    })

    henemy.create({
        id = hslk.n2i("被刀的菜菜"),
        x = math.random(-500, 500),
        y = math.random(-500, 500),
        attr = {
            move = "-522",
        }
    })

end