---@param evtData noteOnUnitHPSuckAttackData
hevent.reaction(CONST_EVENT.hpSuckAttack, function(evtData)
    heffect.attach("Abilities\\Spells\\Human\\Heal\\HealTarget.mdl", evtData.triggerUnit, "origin", 0.5, 1)
end)

---@param evtData noteOnUnitMPSuckAttackData
hevent.reaction(CONST_EVENT.mpSuckAttack, function(evtData)
    heffect.attach("Abilities\\Spells\\Items\\AIma\\AImaTarget.mdl", evtData.triggerUnit, "origin", 0.5, 1)
end)