local Component = require('class.component')

---@class SizeComponent : Component
---@field w number
---@field h number
local SizeComponent = setmetatable({}, { __index = Component })


---@return Component
function SizeComponent.new(name, w, h)
    local obj = Component.new(name)

    obj.w = w
    obj.h = h

    local mt = getmetatable(obj)
    mt.__index = SizeComponent
    return setmetatable(obj, mt)
end


return SizeComponent
