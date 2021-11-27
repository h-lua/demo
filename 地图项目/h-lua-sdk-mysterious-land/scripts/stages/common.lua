stage_ttg = function(whichUnit, message)
    htextTag.style(
        htextTag.create2Unit(whichUnit, message, 8, nil, 1, 1, 80),
        nil, 0, 0.08
    )
end

stage_ttg_sk = function(whichUnit, message)
    htextTag.style(
        htextTag.create2Unit(whichUnit, message, 10, "ff3939", 1, stage_holdOn(), 80),
        nil, 0.02, 0.05
    )
end

stage_fleeting = function(deadUnit, gold)
    for _ = 1, (9 + game.diff + hplayer.qty_current) do
        hitem.fleeting(
            HL_ID.item_fleeting.gold,
            hunit.x(deadUnit) + math.random(0, 200),
            hunit.y(deadUnit) + math.random(0, 200),
            30,
            function(fleetingData)
                if (his.deleted(fleetingData.centerUnit) == true) then
                    return
                end
                local p = hunit.getOwner(fleetingData.enterUnit)
                if (his.allyPlayer(fleetingData.enterUnit, game.ALLY_PLAYER) and his.playing(p) and his.computer(p) == false) then
                    hunit.del(fleetingData.centerUnit)
                    haward.forUnitGold(fleetingData.enterUnit, gold)
                end
            end
        )
    end
end

-- 技能hold on
stage_holdOn = function()
    return 3.50 - game.diff * 0.05
end

--[[
    boss技能模拟
]]
stage_spell = function(whichUnit, message, cd, animate, ready, call)
    if (math.random(1, 5) ~= 3) then
        return
    end
    cd = cd or 10
    cd = math.round(cd * ((101 - game.diff) / 100))
    animate = (animate or "attack,spell") .. ",loop"
    if (hattr.get(whichUnit, "move") > 1) then
        hattr.set(whichUnit, 3, { move = "+200" })
    end
    htime.setTimeout(1.75, function(curTimer2)
        curTimer2.destroy()
        local cdIng = hcache.get(whichUnit, message .. cd, false)
        if (cdIng == true) then
            return
        end
        if (cdIng == nil) then
            hcache.set(whichUnit, message .. cd, true)
            htime.setTimeout(cd, function(curTimer)
                curTimer.destroy()
                hcache.set(whichUnit, message .. cd, nil)
            end)
        end
        ready()
        hsound.voice2Unit(SOUND.voice_drum, 80, whichUnit)
        stage_ttg_sk(whichUnit, message)
        hunit.animate(whichUnit, animate)
        hattr.set(whichUnit, stage_holdOn(), {
            damage_reduction = "+99999",
            move = "-522"
        })
        htime.setTimeout(stage_holdOn(), function(curTimer)
            curTimer.destroy()
            if (his.alive(whichUnit)) then
                call()
            end
        end)
    end)
end