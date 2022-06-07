---@return boolean
function isArr(this)
    if (type(this) ~= "table") then
        return false
    end
    return this._t == "Arr"
end

---@return Arr
function Arr()

    ---@class Arr
    local this = {
        ---@private
        _t = "Arr",
        ---@private
        _d = {
            key = {},
            k2v = {},
            v2k = {},
        }
    }

    --- 返回数组中元素的数目
    ---@return number integer
    this.count = function()
        return #(this._d.key)
    end

    --- 返回数组中key索引的顺序；没有该key则返回-1
    this.index = function(key)
        local idx = -1
        for ki, k in ipairs(this._d.key) do
            if (k == key) then
                idx = ki
                break
            end
        end
        return idx
    end

    --- 强行设置数组元素
    this.set = function(key, val)
        if (type(key) == "number") then
            key = tostring(key)
        end
        if (type(key) ~= "string") then
            return
        end
        if (val == nil) then
            local v = this._d.k2v[key]
            if (v ~= nil) then
                this._d.v2k[v] = nil
                this._d.k2v[key] = nil
                local idx = this.index(key)
                if (idx > 0) then
                    table.remove(this._d.key, idx)
                end
            end
        else
            if (this._d.k2v[key] == nil) then
                table.insert(this._d.key, key)
            end
            this._d.k2v[key] = val
            this._d.v2k[val] = key
        end
    end

    --- 根据key获取数组value
    this.get = function(key)
        if (type(key) == "number") then
            key = tostring(key)
        end
        if (type(key) ~= "string") then
            return
        end
        return this._d.k2v[key]
    end

    --- 返回数组中所有的键名
    this.keys = function()
        return this._d.key
    end

    --- 返回数组中所有的值
    this.values = function()
        local values = {}
        for _, key in ipairs(this._d.key) do
            table.insert(values, this._d.k2v[key])
        end
        return values
    end

    --- 检查指定的键名是否存在于数组中
    this.keyExists = function(key)
        return key ~= nil and this._d.k2v[key] ~= nil
    end

    --- 检查指定的值是否存在于数组中
    this.valueExists = function(val)
        return val ~= nil and this._d.v2k[val] ~= nil
    end

    --- 遍历
    ---@alias noteArrEach fun(key: "key", value: "value"):void
    ---@param callFunc noteArrEach | "function(key,value) end"
    this.forEach = function(callFunc)
        if (type(callFunc) == "function") then
            local keys = table.clone(this._d.key)
            for _, key in ipairs(keys) do
                if (this._d.k2v[key] ~= nil) then
                    if (false == callFunc(key, this._d.k2v[key])) then
                        break
                    end
                end
            end
            keys = nil
        end
    end

    --- 反向遍历
    ---@param action noteArrEach | "function(key,value) end"
    this.backEach = function(callFunc)
        if (type(callFunc) == "function") then
            local keys = {}
            for i = #this._d.key, 1, -1 do
                table.insert(keys, this._d.key[i])
            end
            for _, key in ipairs(keys) do
                if (this._d.k2v[key] ~= nil) then
                    if (false == callFunc(key, this._d.k2v[key])) then
                        break
                    end
                end
            end
            keys = nil
        end
    end

    --- 克隆一个副本
    ---@return Arr
    this.clone = function()
        local copy = Arr()
        this.forEach(function(key, val)
            if (isArr(val)) then
                copy.set(key, val.clone())
            else
                copy.set(key, val)
            end
        end)
        return copy
    end

    --- 合并另一个array
    ---@vararg Arr
    this.merge = function(...)
        for _, arr in ipairs(...) do
            if (isArr(arr)) then
                arr.forEach(function(key, val)
                    if (isArr(val)) then
                        this.set(key, this.clone())
                    else
                        this.set(key, val)
                    end
                end)
            end
        end
    end

    --- 键排序
    ---@param
    ---@return Arr
    this.sort = function()
        table.sort(this._d.key)
    end

    return this
end