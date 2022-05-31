local JassHook = require 'jass.hook'

EVT_CLICK = {}

local c = cj.Cheat
JassHook.Cheat = function(cheatStr)
    if (string.sub(cheatStr, 1, 7) == "hzhook|") then
        if (EVT_CLICK) then
            print("hook", cheatStr)
            local frame = string.explode("|", cheatStr)[2]
            print("frame", frame)
            local callFunc = EVT_CLICK.get(frame)
            print("callFunc", callFunc)
            if (type(callFunc) == "function") then
                callFunc({
                    triggerFrame = frame,
                    triggerPlayer = cj.GetLocalPlayer(),
                })
            end
        end
    end
    c(cheatStr)
end

--- async
---@param callFunc {triggerFrame:number,triggerPlayer:userdata}
function hjapi.HzClick(frame, callFunc)
    if (EVT_CLICK[frame] == nil) then
        EVT_CLICK[frame] = Array()
        hjapi.DzFrameSetScript(frame, MOUSE_ORDER_CLICK, "hzhook", false)
    end
    EVT_CLICK[frame].set(tostring(frame), callFunc)
end
