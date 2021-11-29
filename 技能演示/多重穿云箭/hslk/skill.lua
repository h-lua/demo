
local skill = {
    {
        Name = "穿云箭",
        Art = "ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp",
        DataB = { 2 },
        Hotkey = "Q",
        DataF = { "channel" },
        _onSkillEffect = _onSkillEffect(function(evtData)
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local xy = math.polarProjection(x,y,2000,math.getDegBetweenXY(x,y,evtData.targetX,evtData.targetY))
            local onlyOne = {}
            hskill.missile({
                missile = "Abilities\\Weapons\\HarpyMissile\\HarpyMissile.mdl",
                scale = 1, --虚拟箭矢的模型缩放
                hover = 0.00, --虚拟箭矢的初始离地高度
                speed = 2000,
                sourceUnit = u,
                targetX = xy.x,
                targetY = xy.y,
                onMove = function(unit,_, x, y)
                    local g = hgroup.createByXY(x, y, 100, function(filterUnit)
                        return his.enemy(unit, filterUnit) and his.alive(filterUnit)
                    end)
                    hgroup.forEach(g, function(enumUnit, _)
                        --不重复伤害
                        if (onlyOne[enumUnit] == nil) then
                            onlyOne[enumUnit] = 1
                            hskill.damage({
                                sourceUnit = unit, --伤害来源(可选)
                                targetUnit = enumUnit, --目标单位
                                damage = 100, --实际伤害
                                damageSrc = CONST_DAMAGE_SRC.skill,
                                damageType = { CONST_DAMAGE_TYPE.fire }
                            })
                        end
                    end)
                    g = nil
                    return true
                end
            })
        end)
    },
    {
        Name = "多重穿云箭",
        Art = "ReplaceableTextures\\CommandButtons\\BTNDeathPact.blp",
        DataB = { 2 },
        Hotkey = "W",
        DataF = { "charm" },
        _onSkillEffect = _onSkillEffect(function(evtData)
            local u = evtData.triggerUnit
            local x = hunit.x(u)
            local y = hunit.y(u)
            local facing = math.getDegBetweenXY(x, y, evtData.targetX, evtData.targetY)
            local firstDeg = facing + (15 * (3 - 1) * 0.5)

            for i = 1, 3 do
                local angle = firstDeg - 15 * (i - 1)
                local txy = math.polarProjection(x, y, 2000, angle)
                local onlyOne = {}
                hskill.missile({
                    missile = "Abilities\\Weapons\\HarpyMissile\\HarpyMissile.mdl", --[必须]虚拟箭矢的特效
                    animateSpeed = 1.00, --虚拟箭矢的动画速度
                    scale = 1, --虚拟箭矢的模型缩放
                    hover = 0.00, --虚拟箭矢的初始离地高度
                    speed = 2000, --每秒冲击的距离（可选的，默认1秒500px)
                    acceleration = 0, --冲击加速度（可选的，每个周期[0.02秒]都会增加一次)
                    height = 0, --飞跃高度（可选的，默认0)
                    shake = 0, --摇摆振幅程度度[0.00~1.00|random]（可选的，默认0)
                    sourceUnit = u, --[必须]伤害来源
                    targetX = txy.x, --冲击的目标x坐标（可选的，对点冲击）比targetUnit优先级高
                    targetY = txy.y, --冲击的目标y坐标
                    onMove = function(unit,_, x, y)
                        local g = hgroup.createByXY(x, y, 100, function(filterUnit)
                            return his.enemy(unit, filterUnit) and his.alive(filterUnit)
                        end)
                        hgroup.forEach(g, function(enumUnit, _)
                            --不重复伤害
                            if (onlyOne[enumUnit] == nil) then
                                onlyOne[enumUnit] = 1
                                hskill.damage({
                                    sourceUnit = unit, --伤害来源(可选)
                                    targetUnit = enumUnit, --目标单位
                                    damage = 100, --实际伤害
                                    damageSrc = CONST_DAMAGE_SRC.skill,
                                    damageType = { CONST_DAMAGE_TYPE.fire }
                                })
                            end
                        end)

                        g = nil
                        return true
                    end
                })
            end
        end)
    }
}

for _, v in pairs(skill) do
    v._parent = "ANcl"
    v.DataA = { 0 }
    v.EffectArt = ""
    v.TargetArt = ""
    v.CasterArt = ""
    v.Cool = { 1 }
    v.Cost = { 0 }
    v.DataD = { 0 }
    v.DataC = { 1 }
    v.Rng = { 1000 }
    v.targs = { "enemies" }
    v.DataE = { 0 }
    hslk_ability(v)
end