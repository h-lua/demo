local alertExclamation = c2i(hslk.n2i("叹号警示圈")) --- 警示圈模型!
local alertX = c2i(hslk.n2i("叉号警示圈")) --- 警示圈模型X
local alertLimiter = {}

--- 创建一个警示圈
---@param diameter number 直径范围(px)
---@param x number 坐标X
---@param y number 坐标Y
---@param duration number 持续时间，警示圈不允许永久存在，duration默认为3秒
---@param token number 马甲单位ID,默认叹号！马甲单位原始直径应为128px（刚好一小格）
---@param color number 警示圈马甲单位的颜色,仅支持玩家队伍色，参考 blizzard:^PLAYER_COLOR_?
function alertCircle(diameter, x, y, duration, token, color)
    if (diameter == nil or diameter < 64 or token == nil or type(token) ~= "number") then
        return
    end
    duration = duration or 3
    if (duration <= 0) then
        duration = 3
    end
    local modelScale = hslk.i2v(token, "slk", "modelScale")
    if (modelScale == nil) then
        return
    end
    if (#alertLimiter >= 7) then
        local first = alertLimiter[1]
        table.remove(alertLimiter, 1)
        first.timer.destroy()
        cj.RemoveUnit(first.unit)
        return
    end
    color = color or PLAYER_COLOR_RED
    modelScale = math.round(math.round(modelScale, 3) * (diameter / 128), 2)
    local tmp = {}
    tmp.unit = cj.CreateUnit(cj.Player(PLAYER_NEUTRAL_PASSIVE), token, x, y, 270)
    cj.SetUnitColor(tmp.unit, color)
    cj.SetUnitScale(tmp.unit, modelScale, modelScale, modelScale)
    tmp.timer = htime.setTimeout(duration, function()
        for k, v in ipairs(alertLimiter) do
            if (v.unit == tmp.unit) then
                table.remove(alertLimiter, k)
                break
            end
        end
        cj.RemoveUnit(tmp.unit)
    end)
    table.insert(alertLimiter, tmp)
end

--- 创建一个系统默认叹号警示圈（最多3个）
--- 马甲默认叹号！单位原始直径应为128px（刚好一小格）
---@param diameter number 直径范围(px)
---@param x number 坐标X
---@param y number 坐标Y
---@param duration number 持续时间，警示圈不允许永久存在，duration默认为3秒
---@param color number 警示圈马甲单位的颜色,仅支持玩家队伍色，参考 blizzard:^PLAYER_COLOR_?
function alertCircleExclamation(diameter, x, y, duration, color)
    alertCircle(diameter, x, y, duration, alertExclamation, color)
end

--- 创建一个系统默认X号警示圈（最多3个）
--- 马甲默认X号！单位原始直径应为128px（刚好一小格）
---@param diameter number 直径范围(px)
---@param x number 坐标X
---@param y number 坐标Y
---@param duration number 持续时间，警示圈不允许永久存在，duration默认为3秒
---@param color number 警示圈马甲单位的颜色,仅支持玩家队伍色，参考 blizzard:^PLAYER_COLOR_?
function alertCircleX(diameter, x, y, duration, color)
    alertCircle(diameter, x, y, duration, alertX, color)
end