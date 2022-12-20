local Component = require('class.component')

---@class ShadowComponent : Component
---@field position      PositionComponent
---@field size          SizeComponent
---@field radius        RadiusComponent
---@field shadow        any
---@field world         any
local ShadowComponent = setmetatable({}, { __index = Component })


function ShadowComponent:update(dt, context)
    if self.size then
        self.shadow:setPosition(
            self.position.x + self.size.w / 2,
            self.position.y + self.size.h / 2)
    elseif self.radius then
        self.shadow:setPosition(
            self.position.x,
            self.position.y)
    end

    self.shadow:setAlpha(self.color.a)
end


---@param context Context
function ShadowComponent:onAdd(context)
    self.position = context:get('position')
    self.size     = context:get('size')
    self.radius   = context:get('radius')
    self.color    = context:get('color')
end


function ShadowComponent:delete()
    self.world:remove(self.shadow)
end


function ShadowComponent:setLightWorld(world)
    self.world = world
    if self.size then
        self.shadow = world:newRectangle(
            self.position.x + self.size.w / 2,
            self.position.y + self.size.h / 2,
            self.size.w, self.size.h)
    elseif self.radius then
        self.shadow = world:newCircle(
            self.position.x,
            self.position.y,
            self.radius.r)
    else
        error('unknown type?')
    end
end


---@return Component
function ShadowComponent.new(name)
    local obj = Component.new(name)

    obj.position = nil
    obj.size     = nil
    obj.radius   = nil
    obj.color    = nil

    obj.shadow = nil
    obj.world  = nil

    local mt = getmetatable(obj)
    mt.__index = ShadowComponent
    return setmetatable(obj, mt)
end


return ShadowComponent
