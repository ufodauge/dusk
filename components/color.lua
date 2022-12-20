--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics


---@class RGBA
---@field [1] number
---@field [2] number
---@field [3] number
---@field [4] number


local Component = require('class.component')

---@class ColorComponent : Component
---@field r           number
---@field g           number
---@field b           number
---@field a           number
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


function ColorComponent:setColor()
    lg.setColor(self.r, self.g, self.b, self.a)
end


function ColorComponent:delete()

end


---@param color_table RGBA
---@return Component
function ColorComponent.new(name, color_table)
    local obj = Component.new(name)

    obj.r = color_table[1]
    obj.g = color_table[2]
    obj.b = color_table[3]
    obj.a = color_table[4]

    local mt = getmetatable(obj)
    mt.__index = ColorComponent
    return setmetatable(obj, mt)
end


return ColorComponent
