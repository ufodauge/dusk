local Component = require('class.component')

---@class PositionComponent : Component
---@field x number
---@field y number
local PositionComponent = setmetatable({}, { __index = Component })


---@return Component
function PositionComponent.new(name, x, y)
    local obj = Component.new(name)

    obj.x = x
    obj.y = y

    local mt = getmetatable(obj)
    mt.__index = PositionComponent
    return setmetatable(obj, mt)
end


return PositionComponent
