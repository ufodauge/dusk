local Component = require('class.component')

---@class LightingComponent : Component
---@field position PositionComponent
---@field color    ColorComponent
---@field radius   RadiusComponent
---@field light    any
---@field world    any
---@field mul      number
local LightingComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function LightingComponent:update(dt, context)
    self.light:setPosition(self.position.x, self.position.y)
    self.light:setColor(self.color.r, self.color.g, self.color.b)
end


---@param context Context
function LightingComponent:onAdd(context)
    self.position = context:get('position')
    self.color    = context:get('color')
    self.radius   = context:get('radius')
end


function LightingComponent:delete()
    self.world:remove(self.light)
end


function LightingComponent:setLightWorld(world)
    self.world = world
    self.light = world:newLight(
        self.position.x, self.position.y,
        self.color.r, self.color.g, self.color.b,
        self.radius.r * self.mul)
end


---@return Component
function LightingComponent.new(name, mul)
    local obj = Component.new(name)

    obj.position = nil
    obj.color    = nil
    obj.radius   = nil

    obj.light = nil
    obj.world = nil

    obj.mul = mul or 1

    local mt = getmetatable(obj)
    mt.__index = LightingComponent
    return setmetatable(obj, mt)
end


return LightingComponent
