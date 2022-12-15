---@class RGBA
---@field [1] number
---@field [2] number
---@field [3] number
---@field [4] number


local Component = require('class.component')

---@class ColorComponent : Component
---@field color_table RGBA
local ColorComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function ColorComponent:update(dt, context)

end


---@param context Context
function ColorComponent:draw(context)

end


---@param context Context?
function ColorComponent:onAdd(context)

end


function ColorComponent:delete()

end


---@param color_table RGBA
---@return Component
function ColorComponent.new(name, color_table)
    local obj = Component.new(name)

    obj.color_table = color_table

    local mt = getmetatable(obj)
    mt.__index = ColorComponent
    return setmetatable(obj, mt)
end


return ColorComponent
