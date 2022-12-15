local Component = require('class.component')

---@class LightingComponent : Component
---@field position PositionComponent
---@field color    ColorComponent
---@field radius   RadiusComponent
---@field light    any
---@field world    any
local LightingComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function LightingComponent:update(dt, context)
    self.light:setPosition(self.position.x, self.position.y)
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
        self.color.color_table[1],
        self.color.color_table[2],
        self.color.color_table[3],
        self.radius.r)
end


---@return Component
function LightingComponent.new(name)
    local obj = Component.new(name)

    obj.position = nil
    obj.color    = nil
    obj.radius   = nil

    obj.light = nil
    obj.world = nil
    
    local mt = getmetatable(obj)
    mt.__index = LightingComponent
    return setmetatable(obj, mt)
end


return LightingComponent