onMapDestructableDestroy = function()
    hevent.onMapDestructableDestroy(function(evtData)
        if (math.random(1, 10) == 5) then
            return
        end
        local dest = evtData.triggerDestructable
        local destId = string.id2char(cj.GetDestructableTypeId(dest))
        if (destId == 'LTba') then
            -- 路障，给10木材
            hitem.fleeting(
                HL_ID.item_fleeting.lumber,
                cj.GetDestructableX(dest),
                cj.GetDestructableY(dest),
                20,
                function(fleetingData)
                    if (his.deleted(fleetingData.centerUnit) == true) then
                        return
                    end
                    local p = hunit.getOwner(fleetingData.enterUnit)
                    if (his.allyPlayer(fleetingData.enterUnit, game.ALLY_PLAYER) and his.playing(p) and his.computer(p) == false) then
                        hunit.del(fleetingData.centerUnit)
                        haward.forUnitLumber(fleetingData.enterUnit, math.random(5, 15))
                    end
                end
            )
        elseif (destId == 'LTcr') then
            -- 木箱，给黄金
            hitem.fleeting(
                HL_ID.item_fleeting.gold,
                cj.GetDestructableX(dest),
                cj.GetDestructableY(dest),
                20,
                function(fleetingData)
                    if (his.deleted(fleetingData.centerUnit) == true) then
                        return
                    end
                    local p = hunit.getOwner(fleetingData.enterUnit)
                    if (his.allyPlayer(fleetingData.enterUnit, game.ALLY_PLAYER) and his.playing(p) and his.computer(p) == false) then
                        hunit.del(fleetingData.centerUnit)
                        haward.forUnitGold(fleetingData.enterUnit, math.random(20, 90))
                    end
                end
            )
        elseif (destId == 'LTbs' or destId == 'LTbr' or destId == 'LTbx') then
            -- 木桶，给天赋书
            local typeIds = hslk.typeIds({ "gift_weapon", "gift_defend", "gift_speed", "gift_tao" })
            local bookId = table.random(typeIds)
            hitem.create({
                id = bookId,
                charges = 1,
                x = cj.GetDestructableX(dest),
                y = cj.GetDestructableY(dest),
                during = 60,
            })
        end
    end)
end