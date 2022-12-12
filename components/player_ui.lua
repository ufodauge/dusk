local Component = require('class.component')

---@class PlayerUiComponent : Component
local PlayerUiComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function PlayerUiComponent:update(dt, context)

end


---@param context Context
function PlayerUiComponent:draw(context)

end


function PlayerUiComponent:delete()

end


---@return Component
function PlayerUiComponent.new()
    local obj = Component.new()

    local mt = getmetatable(obj)
    mt.__index = PlayerUiComponent
    return setmetatable(obj, mt)
end


return PlayerUiComponent
