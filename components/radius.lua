local Component = require('class.component')

---@class RadiusComponent : Component
---@field r number
local RadiusComponent = setmetatable({}, { __index = Component })


---@return Component
function RadiusComponent.new(name, r)
    local obj = Component.new(name)

    obj.r = r

    local mt = getmetatable(obj)
    mt.__index = RadiusComponent
    return setmetatable(obj, mt)
end


return RadiusComponent
