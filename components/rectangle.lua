--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics


local Component = require('class.component')


---@class RectangleComponent : Component
---@field color    ColorComponent
---@field position PositionComponent
---@field size     SizeComponent
local RectangleComponent = setmetatable({}, { __index = Component })


---@param dt number
---@param context Context
function RectangleComponent:update(dt, context)
end


---@param context Context
function RectangleComponent:draw(context)
    lg.setColor(self.color.color_table)
    lg.rectangle('fill',
        self.position.x, self.position.y,
        self.size.w, self.size.h)
end


---@param context Context
function RectangleComponent:onAdd(context)
    self.color    = context:get('color')
    self.position = context:get('position')
    self.size     = context:get('size')
end


function RectangleComponent:delete()

end


---@param name string
---@return RectangleComponent|Component
function RectangleComponent.new(name)
    local obj = Component.new(name)

    obj.color    = nil
    obj.position = nil
    obj.size     = nil

    local mt = getmetatable(obj)
    mt.__index = RectangleComponent
    return setmetatable(obj, mt)
end


return RectangleComponent
