local items = {
    {
        Name = "医疗石",
        Ubertip = "使用后在10秒内持续恢复共200点生命",
        Art = "ReplaceableTextures\\CommandButtons\\BTNHealthStone.blp",
        goldcost = 0,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "Q",
        perishable = 1,
        _cooldown = 70,
        _remarks = "免费采集到的有医疗效果的石头，吞食令人肚子痛",
        _overlie = 99,
        _weight = 0.1,
        _onItemUsed = _onItemUsed(function(evtData)
            local triggerUnit = evtData.triggerUnit
            heffect.bindUnit(
                "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl",
                triggerUnit, "origin", 10
            )
            hattr.set(triggerUnit, 10, {
                life_back = "+20",
            })
        end)
    },
    {
        Name = "魔法石",
        Ubertip = "使用后在10秒内持续恢复共150点魔法",
        Art = "ReplaceableTextures\\CommandButtons\\BTNManaStone.blp",
        goldcost = 0,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "W",
        perishable = 1,
        _cooldown = 70,
        _remarks = "免费采集到的有智慧的石头，据说只有变态魔法师服用",
        _overlie = 99,
        _weight = 0.1,
        _onItemUsed = _onItemUsed(function(evtData)
            local triggerUnit = evtData.triggerUnit
            heffect.bindUnit(
                "Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl",
                triggerUnit, "origin", 10
            )
            hattr.set(triggerUnit, 10, {
                mana_back = "+15",
            })
        end)
    },
    {
        Name = "医疗剂",
        Ubertip = "使用后在6秒内持续恢复共500点生命",
        Art = "ReplaceableTextures\\CommandButtons\\BTNHealingSalve.blp",
        goldcost = 50,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "E",
        perishable = 1,
        _cooldown = 40,
        _remarks = "轻松制得的医疗药水，奸商卖得并不便宜",
        _overlie = 99,
        _weight = 0.1,
        _onItemUsed = _onItemUsed(function(evtData)
            local triggerUnit = evtData.triggerUnit
            heffect.bindUnit(
                "Abilities\\Spells\\Items\\HealingSalve\\HealingSalveTarget.mdl",
                triggerUnit, "origin", 6
            )
            hattr.set(triggerUnit, 6, {
                life_back = "+83.34",
            })
        end)
    },
    {
        Name = "魔法剂",
        Ubertip = "使用后在6秒内持续恢复共300点魔法",
        Art = "ReplaceableTextures\\CommandButtons\\BTNVialFull.blp",
        goldcost = 50,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "R",
        perishable = 1,
        _cooldown = 40,
        _remarks = "轻松制得的魔法药水，奸商卖得也不便宜",
        _overlie = 99,
        _weight = 0.1,
        _onItemUsed = _onItemUsed(function(evtData)
            local triggerUnit = evtData.triggerUnit
            heffect.bindUnit(
                "Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl",
                triggerUnit, "origin", 6
            )
            hattr.set(triggerUnit, 6, {
                mana_back = "+50",
            })
        end)
    },
    {
        Name = "吸血药水",
        Ubertip = "使用后在35秒内增加20%吸血",
        Art = "ReplaceableTextures\\CommandButtons\\BTNPotionOfVampirism.blp",
        goldcost = 100,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "A",
        perishable = 1,
        _cooldown = 55,
        _remarks = "吸血魔鬼的药水",
        _overlie = 9,
        _weight = 0.1,
        _onItemUsed = _onItemUsed(function(evtData)
            local triggerUnit = evtData.triggerUnit
            hattr.set(triggerUnit, 35, {
                hemophagia = "+20",
            })
        end)
    },
    {
        Name = "完美药水",
        Ubertip = "使用后瞬间恢复所有生命和魔法",
        Art = "ReplaceableTextures\\CommandButtons\\BTNSnazzyPotion.blp",
        goldcost = 996,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "S",
        perishable = 1,
        _cooldown = 60,
        _remarks = "996福报药水",
        _overlie = 9,
        _weight = 0.1,
        _onItemUsed = _onItemUsed(function(evtData)
            heffect.toUnit("Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl", evtData.triggerUnit)
            hunit.setCurLifePercent(evtData.triggerUnit, 100)
            hunit.setCurManaPercent(evtData.triggerUnit, 100)
        end)
    },
    {
        Name = "恢复卷轴",
        Ubertip = "使用后600范围内的友军瞬间恢复300生命",
        Art = "ReplaceableTextures\\CommandButtons\\BTNScrollOfRegenerationGreen.blp",
        goldcost = 300,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "D",
        perishable = 1,
        _cooldown = 90,
        _remarks = "一票保全家",
        _overlie = 3,
        _weight = 0.2,
        _onItemUsed = _onItemUsed(function(evtData)
            local triggerUnit = evtData.triggerUnit
            local g = hgroup.createByUnit(evtData.triggerUnit, 600, function(filterUnit)
                return his.alive(filterUnit) and his.ally(triggerUnit, filterUnit)
            end)
            hgroup.forEach(g, function(enumUnit)
                heffect.toUnit("Abilities\\Spells\\Human\\Heal\\HealTarget.mdl", enumUnit)
                hunit.addCurLife(enumUnit, 300)
            end, true)
        end)
    },
    {
        Name = "加速卷轴",
        Ubertip = "使用后600范围内的友军提升移动力100点，攻速15%，持续30秒",
        Art = "ReplaceableTextures\\CommandButtons\\BTNScrollOfHaste.blp",
        goldcost = 300,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "F",
        perishable = 1,
        _cooldown = 90,
        _remarks = "忍者专用来逃跑的卷轴",
        _overlie = 3,
        _weight = 0.2,
        _onItemUsed = _onItemUsed(function(evtData)
            local triggerUnit = evtData.triggerUnit
            local g = hgroup.createByUnit(evtData.triggerUnit, 600, function(filterUnit)
                return his.alive(filterUnit) and his.ally(triggerUnit, filterUnit)
            end)
            hgroup.forEach(g, function(enumUnit)
                heffect.bindUnit(
                    "Abilities\\Spells\\Items\\AIsp\\SpeedTarget.mdl",
                    enumUnit, "overhead", 30
                )
                hattr.set(enumUnit, 30, {
                    move = "+100",
                    attack_speed = "+15",
                })
            end, true)
        end)
    },
    {
        Name = "枯枝",
        Art = "ReplaceableTextures\\CommandButtons\\BTNNatureTouchGrow.blp",
        goldcost = 250,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "Z",
        _overlie = 1,
        _weight = 0.3,
        _remarks = "树大有枯枝，枯枝997",
        _attr = {
            str_green = "+9",
            agi_green = "+9",
            int_green = "+7",
        }
    },
    {
        Name = "魔法师指环",
        Art = "ReplaceableTextures\\CommandButtons\\BTNRingJadeFalcon.blp",
        goldcost = 250,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "X",
        _remarks = "见习的魔法师都会佩戴的指环",
        _overlie = 1,
        _weight = 0.1,
        _attr = {
            mana = "+100",
            mana_back = "+1.8",
        }
    },
    {
        Name = "守护指环(劣质)",
        Art = "ReplaceableTextures\\CommandButtons\\BTNRingGreen.blp",
        goldcost = 300,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "C",
        _remarks = "精钢制造的指环，不过是劣质产出，效果一般",
        _overlie = 1,
        _weight = 0.2,
        _attr = {
            defend_green = "+4",
            damage_reduction = "+5",
        }
    },
    {
        Name = "铁靴",
        Art = "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp",
        goldcost = 550,
        lumbercost = 0,
        powerup = 0,
        sellable = 1,
        pawnable = 1,
        droppable = 1,
        Hotkey = "V",
        _remarks = "沉重的铁靴，但冒险旅途艰难，有总比没有好",
        _overlie = 1,
        _weight = 0.5,
        _attr = {
            move = "+55",
        }
    },
}

local ids = ""
for _, v in ipairs(items) do
    v.stockRegen = 1
    local id = hslk_item(v)._id
    if (ids == "") then
        ids = id
    else
        ids = ids .. "," .. id
    end
end

hslk_unit({
    _parent = "ngme",
    Name = "小神木商店",
    abilList = "Avul,Apit,Aneu",
    file = "buildings\\nightelf\\ChimaeraRoost\\ChimaeraRoost",
    Art = "ReplaceableTextures\\CommandButtons\\BTNResStone.blp",
    modelScale = 0.70,
    scale = 2.20,
    HP = 100,
    spd = 0,
    sight = 500,
    nsight = 500,
    unitSound = "",
    weapsOn = 0,
    race = "human",
    Sellitems = ids,
})