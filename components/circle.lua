--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics


local Component = require('class.component')


---@class CircleComponent : Component
---@field color    ColorComponent
---@field position PositionComponent
---@field radius   RadiusComponent
local CircleComponent = setmetatable({}, { __index = Component })


---@param dt number
---@param context Context
function CircleComponent:update(dt, context)
end


---@param context Context
function CircleComponent:draw(context)
    lg.setColor(self.color.color_table)
    lg.circle('fill',
        self.position.x, self.position.y,
        self.radius.r)
end


---@param context Context
function CircleComponent:onAdd(context)
    self.color    = context:get('color')
    self.position = context:get('position')
    self.radius   = context:get('radius')
end


function CircleComponent:delete()

end


---@param name string
---@return CircleComponent|Component
function CircleComponent.new(name)
    local obj = Component.new(name)

    obj.color    = nil
    obj.position = nil
    obj.radius   = nil

    local mt = getmetatable(obj)
    mt.__index = CircleComponent
    return setmetatable(obj, mt)
end


return CircleComponent
