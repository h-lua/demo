--- Generated by h-lua(https://github.com/h-lua/h-lua)

require "h-lua" -- h-lua库
require "scripts.alias" -- alias h-lua库别称（参考）
require "scripts.setup" -- setup 游戏准备
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

    local u = hunit.create({
        whichPlayer = hplayer.players[1],
        id = hslk.n2i("天选勇者"),
        x = 0,
        y = 0,
        isOpenSlot = true,
    })

    htime.setTimeout(5, function()
        print("删除扎根，效果持续")
        hskill.destroy(u, hslk.n2i("新扎根"), 0)
    end)

    for _ = 1, 10 do
        henemy.create({
            id = hslk.n2i("受苦之民"),
            x = math.random(-500, 500),
            y = math.random(-500, 500),
            attr = {
                move = "=0",
            }
        })
    end

end