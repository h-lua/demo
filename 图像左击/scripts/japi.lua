local JassHook = require 'jass.hook'

---@type table<string,Array>
EVT_CLICK = {}

local c = cj.Cheat
JassHook.Cheat = function(cheatStr)
    if (string.sub(cheatStr, 1, 7) == "hzhook|") then
        if (EVT_CLICK) then
            print("hook", cheatStr)
            local frame = string.explode("|", cheatStr)[2]
            print("frame", frame)
            local ec = EVT_CLICK[frame]
            if (ec ~= nil) then
                ec.forEach(function(key, value)
                    print("kv=", key, value)
                    if (type(value) == "function") then
                        value({
                            triggerFrame = frame,
                            triggerPlayer = cj.GetLocalPlayer(),
                        })
                    end
                end)
            end
        end
    end
    c(cheatStr)
end

--- async
---@param callFunc {triggerFrame:number,triggerPlayer:userdata}
function hjapi.HzClick(frame, key, callFunc)
    local fk = tostring(frame)
    if (EVT_CLICK[fk] == nil) then
        EVT_CLICK[fk] = Array()
        hjapi.DzFrameSetScript(frame, MOUSE_ORDER_CLICK, "hzhook", false)
    end
    EVT_CLICK[fk].set(key, callFunc)
end
