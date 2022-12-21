--------------------------------------------------------------
-- require
--------------------------------------------------------------
local QuartInOut = require('lib.easing.quart').io
local LuiDebug = require('lib.luidebug'):getInstance()


local Component = require('class.component')

---@class MovingPlatformComponent : Component
---@field block     BlockComponent
---@field position  PositionComponent
---@field size      SizeComponent
---@field default_x number
---@field default_y number
---@field target_x  number
---@field target_y  number
---@field dx        number
---@field dy        number
---@field rep       boolean
---@field duration  number
---@field time      number
---@field direction 1|-1
local MovingPlatformComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function MovingPlatformComponent:update(dt, context)
    self.time = (self.time + dt) % self.duration
    self.direction = self.time < self.duration / 2
        and 1
        or -1

    local x, y = 0, 0
    if self.direction == 1 then
        local v = QuartInOut(self.time / (self.duration / 2))
        x = self.default_x + v * self.dx
        y = self.default_y + v * self.dy
    else
        local v = QuartInOut((self.time - (self.duration / 2)) / (self.duration / 2))
        x = self.target_x - v * self.dx
        y = self.target_y - v * self.dy
    end

    self.block.body:setPosition(x, y)
    self.position.x = x - self.size.w / 2
    self.position.y = y - self.size.h / 2
end


---@param context Context
function MovingPlatformComponent:onAdd(context)
    self.block    = context:get('block') --[[@as BlockComponent]]
    self.position = context:get('position') --[[@as PositionComponent]]
    self.size     = context:get('size') --[[@as SizeComponent]]

    self.default_x, self.default_y = self.block.body:getPosition()
    self.target_x, self.target_y = self.default_x + self.dx, self.default_y + self.dy
end


function MovingPlatformComponent:delete()

end


---@return MovingPlatformComponent
function MovingPlatformComponent.new(name, dx, dy, duration, rep)
    local self = Component.new(name)

    self.block    = nil
    self.position = nil

    self.dx       = dx
    self.dy       = dy
    self.duration = duration or 2
    self.rep      = rep or true

    self.time      = 0
    self.direction = 1

    local mt = getmetatable(self)
    mt.__index = MovingPlatformComponent
    return setmetatable(self, mt)
end


return MovingPlatformComponent
