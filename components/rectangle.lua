--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics


local Component = require('class.component')


---@class RectangleComponent : Component
---@field color    ColorComponent
---@field position PositionComponent
---@field size     SizeComponent
---@field rx       number
---@field ry       number
local RectangleComponent = setmetatable({}, { __index = Component })


---@param dt number
---@param context Context
function RectangleComponent:update(dt, context)
end


---@param context Context
function RectangleComponent:draw(context)
    self.color:setColor()
    lg.rectangle('fill',
        self.position.x, self.position.y,
        self.size.w, self.size.h,
        self.rx, self.ry)
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
function RectangleComponent.new(name, rx, ry)
    local self = Component.new(name)

    self.color    = nil
    self.position = nil
    self.size     = nil

    self.rx = rx
    self.ry = ry

    local mt = getmetatable(self)
    mt.__index = RectangleComponent
    return setmetatable(self, mt)
end


return RectangleComponent
