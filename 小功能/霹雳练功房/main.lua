--- Generated by h-lua-cli(https://github.com/hunzsig-warcraft3/h-lua-sdk)

require "h-lua" -- h-lua库
require "scripts.alias" -- alias h-lua库别称（参考）
require "scripts.setup" -- setup 游戏准备
require "scripts.ui" -- UI

-- h-lua main function 主函数入口
-- The game starts here 游戏从main函数开始运行
function main()

    SETUP()
    UI()

    local me = hunit.create({
        whichPlayer = hplayer.players[1],
        id = hslk.n2i("天选勇者"),
        x = 0,
        y = 0,
        isOpenSlot = true,
    })

    -- x y range qty
    local conf = {
        { -1800, 0, 500, 5, "5星刷怪房" },
        { -200, 0, 800, 10, "10星刷怪房" },
        { 2200, 0, 1200, 20, "20星刷怪房" },
    }

    local rooms = {}
    local dialogOptions = {
        title = "秘籍修炼",
        buttons = {}
    }
    for k, v in ipairs(conf) do
        cj.SetTerrainType(v[1], v[2], string.char2id("Ybtl"), -1, math.floor(v[3] / 128), 0)
        local r = hrect.create(v[1], v[2], v[3], v[3], v[5])
        table.insert(rooms, r)
        table.insert(dialogOptions.buttons, { value = k, label = v[5] })
        local z = 40
        hlightning.xyz2xyz(hlightning.type.shan_dian_lian_zhu, hrect.getMinX(r), hrect.getMinY(r), z, hrect.getMinX(r), hrect.getMaxY(r), z, -1)
        hlightning.xyz2xyz(hlightning.type.shan_dian_lian_zhu, hrect.getMinX(r), hrect.getMaxY(r), z, hrect.getMaxX(r), hrect.getMaxY(r), z, -1)
        hlightning.xyz2xyz(hlightning.type.shan_dian_lian_zhu, hrect.getMaxX(r), hrect.getMaxY(r), z, hrect.getMaxX(r), hrect.getMinY(r), z, -1)
        hlightning.xyz2xyz(hlightning.type.shan_dian_lian_zhu, hrect.getMaxX(r), hrect.getMinY(r), z, hrect.getMinX(r), hrect.getMinY(r), z, -1)
    end

    local it = hitem.create({
        id = hslk.n2i("练功秘籍"),
        x = 100,
        y = 0,
    })

    hevent.onItemUsed(me, function(evtData)
        if (evtData.triggerItem == it) then
            hdialog.create(hunit.getOwner(evtData.triggerUnit), dialogOptions, function(btnIdx)
                local dur = 20
                local r = rooms[btnIdx]
                local x = hrect.getX(r)
                local y = hrect.getY(r)
                echo("选择了：" .. hrect.getName(r) .. ",时间" .. dur .. "秒")
                hunit.portal(evtData.triggerUnit, x, y)
                hcamera.toXY(hunit.getOwner(evtData.triggerUnit), 0, x, y)
                local z = 125
                hlightning.xyz2xyz(hlightning.type.si_wang_zhi_zhi, hrect.getMinX(r), hrect.getMinY(r), z, hrect.getMinX(r), hrect.getMaxY(r), z, dur)
                hlightning.xyz2xyz(hlightning.type.si_wang_zhi_zhi, hrect.getMinX(r), hrect.getMaxY(r), z, hrect.getMaxX(r), hrect.getMaxY(r), z, dur)
                hlightning.xyz2xyz(hlightning.type.si_wang_zhi_zhi, hrect.getMaxX(r), hrect.getMaxY(r), z, hrect.getMaxX(r), hrect.getMinY(r), z, dur)
                hlightning.xyz2xyz(hlightning.type.si_wang_zhi_zhi, hrect.getMaxX(r), hrect.getMinY(r), z, hrect.getMinX(r), hrect.getMinY(r), z, dur)
                hrect.lock({
                    type = "square",
                    during = dur - 1,
                    lockRect = r,
                })
                local monsterQty = conf[btnIdx][4]
                local mi = 0
                local boring = true
                local cMon
                local curMons
                local onMonDead = function(ed)
                    hgroup.removeUnit(curMons, ed.triggerUnit)
                    if (ed.killUnit) then
                        hunit.addExp(ed.killUnit, 100, true)
                    end
                    if (hgroup.isEmpty(curMons)) then
                        curMons = nil
                        if (boring == true) then
                            cMon()
                        end
                    end
                end
                cMon = function()
                    mi = monsterQty
                    curMons = henemy.create({
                        id = hslk.n2i("被刷小怪"),
                        qty = monsterQty,
                        x = x,
                        y = y,
                        attr = {
                            life = "=" .. 1000 * btnIdx,
                            defend = "=" .. 2 * btnIdx,
                            move = "=" .. 125 * btnIdx,
                        }
                    })
                    for _, e in ipairs(curMons) do
                        hevent.onDead(e, onMonDead)
                    end
                end
                -- start
                cMon()
                -- out
                htime.setTimeout(dur, function()
                    boring = false
                    if (curMons ~= nil) then
                        hgroup.forEach(curMons, function(enumUnit)
                            hunit.del(enumUnit)
                        end)
                    end
                    echo("修炼结束")
                    hunit.portal(evtData.triggerUnit, 0, 0)
                    hcamera.toXY(hunit.getOwner(evtData.triggerUnit), 0, 0, 0)
                end)
            end)
        end
    end)

end