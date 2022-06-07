JAPI = function()

    local _Refresh = Array()

    --- 异步执行刷新
    ---@param key string
    ---@param callFunc function|nil
    ---@return void
    hjapi.Refresh = function(key, callFunc)
        if (type(callFunc) == "function") then
            _Refresh.set(key, callFunc)
        else
            _Refresh.splice(key)
        end
    end

    --- JAPI Refresh 初始化
    hjapi.DzFrameSetUpdateCallbackByCode(function()
        if (cj.GetLocalPlayer() == cj.GetLocalPlayer()) then --仅作异步提醒
            _Refresh.forEach(function(_, call)
                call()
            end)
        end
    end)

end

