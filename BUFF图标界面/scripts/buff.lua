--- buff系统
---buff是一种状态，可被创建和删除
---当buff被删除时，将会
hbuff = {
    UNIQUE_KEY = 0,
    DEFAULT_CONST_BUFF = '_h_lua',
}

---@private
hbuff.uniqueKey = function()
    hbuff.UNIQUE_KEY = hbuff.UNIQUE_KEY + 1
    return hbuff.UNIQUE_KEY
end

--- 统计group buff的个数
---@private
hbuff.count = function(handleUnit, key)
    if (handleUnit == nil) then
        return 0
    end
    if (handleUnit == nil or key == nil) then
        return 0
    end
    if (hunit.isDestroyed(handleUnit)) then
        return 0
    end
    if (false == hcache.exist(handleUnit)) then
        return 0
    end
    local buffHandle = hcache.get(handleUnit, BUFF_KEY, {})
    if (buffHandle[key] == nil) then
        return 0
    end
    return #buffHandle[key]._idx
end

--- 创建一个buff概念物
--- 成功创建时会返回一个key，用于删除buff
--- 失败会返回nil
---@param during number > 0
---@param handleUnit userdata
---@param key string|'global' buff集合key，用于自主分类和搜索
---@param diff number 差额值
---@param purpose function 目的期望的操作
---@param rollback function 回到原来状态的操作
---@return string|nil
hbuff.create = function(during, handleUnit, key, diff, purpose, rollback)
    if (handleUnit == nil or purpose == nil or rollback == nil) then
        return
    end
    during = during or 0
    if (during <= 0) then
        during = -1
    end
    if (hunit.isDestroyed(handleUnit)) then
        return
    end
    if (false == hcache.exist(handleUnit)) then
        return
    end
    key = key or hbuff.DEFAULT_CONST_BUFF
    purpose()
    local buffHandle = hcache.get(handleUnit, BUFF_KEY)
    if (buffHandle == nil) then
        buffHandle = {}
        hcache.set(handleUnit, BUFF_KEY, buffHandle)
    end
    if (buffHandle[key] == nil) then
        buffHandle[key] = {}
    end
    if (buffHandle[key]._idx == nil) then
        buffHandle[key]._idx = {}
    end
    local uk = hbuff.uniqueKey()
    buffHandle[key][uk] = { purpose = purpose, rollback = rollback, diff = diff, times = nil }
    table.insert(buffHandle[key]._idx, uk)
    if (during > 0) then
        buffHandle[key][uk].times = htime.setTimeout(during, function(curTimer)
            curTimer.destroy()
            if (hunit.isDestroyed(handleUnit)) then
                return
            end
            if (buffHandle ~= nil and buffHandle[key] ~= nil) then
                if (buffHandle[key]._idx ~= nil) then
                    table.delete(buffHandle[key]._idx, uk)
                end
                if (buffHandle[key][uk] ~= nil) then
                    rollback()
                    buffHandle[key][uk] = nil
                end
            end
        end)
    end
    return string.implode('|', { key, uk })
end

--- 使一个buff强制执行一次purpose
--- buff被删除时会回到原来的状态
---@param handleUnit userdata
---@param buffKey string 由 key|uniqueKey 组成,如果没有uniqueKey则清空所有key下的buff
hbuff.purpose = function(handleUnit, buffKey)
    if (handleUnit == nil or buffKey == nil) then
        return
    end
    if (hunit.isDestroyed(handleUnit)) then
        return
    end
    if (false == hcache.exist(handleUnit)) then
        return
    end
    local ebk = string.explode('|', buffKey)
    local key = ebk[1] or nil
    local uk = math.floor(ebk[2] or 0)
    if (key == nil or uk == 0) then
        return
    end
    local buffHandle = hcache.get(handleUnit, BUFF_KEY, {})
    if (buffHandle[key] ~= nil and buffHandle[key][uk] ~= nil) then
        buffHandle[key][uk].purpose()
    end
end

--- 删除一个buff
--- buff被删除时会回到原来的状态
---@param handleUnit userdata
---@param buffKey string 由 key|uniqueKey 组成,如果没有uniqueKey则清空所有key下的buff
hbuff.delete = function(handleUnit, buffKey)
    if (handleUnit == nil or buffKey == nil) then
        return
    end
    if (hunit.isDestroyed(handleUnit)) then
        return
    end
    if (false == hcache.exist(handleUnit)) then
        return
    end
    local ebk = string.explode('|', buffKey)
    local key = ebk[1] or nil
    local uk = ebk[2] or nil
    if (key == nil) then
        return
    end
    local buffHandle = hcache.get(handleUnit, BUFF_KEY, {})
    if (buffHandle._idx ~= nil) then
        if (uk == nil) then
            -- 删除group下所有buff
            for _, _uk in ipairs(buffHandle._idx) do
                if (buffHandle[key][_uk] ~= nil) then
                    buffHandle[key][_uk].rollback() --rollback
                end
            end
            buffHandle[key] = nil
        else
            -- 删除uk指向buff
            uk = math.floor(uk)
            if (buffHandle[key][uk] ~= nil) then
                buffHandle[key][uk].rollback() --rollback
                buffHandle[key][uk] = nil
                table.delete(buffHandle[key]._idx, uk)
            end
        end
    end
end