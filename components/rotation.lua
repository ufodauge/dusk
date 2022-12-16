local lg = love.graphics

local Component = require('class.component')

---@class RotationComponent : Component
---@field rot number
local RotationComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function RotationComponent:update(dt, context)

end


---@param context Context
function RotationComponent:draw(context)
end


---@param context Context
function RotationComponent:onAdd(context)

end


function RotationComponent:delete()

end


---@return Component
function RotationComponent.new(name, rot)
    local obj = Component.new(name)

    obj.rot = rot

    local mt = getmetatable(obj)
    mt.__index = RotationComponent
    return setmetatable(obj, mt)
end


return RotationComponent
