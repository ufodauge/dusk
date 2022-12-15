local Component = require('class.component')

---@class TemplateComponent : Component
local TemplateComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function TemplateComponent:update(dt, context)

end


---@param context Context
function TemplateComponent:draw(context)

end


---@param context Context
function TemplateComponent:onAdd(context)

end


function TemplateComponent:delete()

end


---@return Component
function TemplateComponent.new(name)
    local obj = Component.new(name)

    local mt = getmetatable(obj)
    mt.__index = TemplateComponent
    return setmetatable(obj, mt)
end


return TemplateComponent
