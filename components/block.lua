--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lp = love.physics
local lg = love.graphics


--------------------------------------------------------------
-- constant
--------------------------------------------------------------
local RESISTITUTION = 0.8


local Component = require('class.component')

---@class BlockComponent : Component
---@field x number
---@field y number
---@field w number
---@field h number
local BlockComponent = setmetatable({}, { __index = Component })

function BlockComponent:update(dt)
    -- self.x, self.y = self.fixture:getBody():getPosition()
end


function BlockComponent:draw()
    lg.setColor(0.1, 0.25, 0.5, 1)
    lg.rectangle('fill', self.x, self.y, self.w, self.h)
    lg.setColor(1, 1, 1, 1)
end


---@param world love.World
function BlockComponent:createPhysicsObject(world)
    local body    = lp.newBody(world, self.x + self.w / 2, self.y + self.h / 2, 'static')
    local shape   = lp.newRectangleShape(self.w, self.h)
    local fixture = lp.newFixture(body, shape)

    fixture:setRestitution(RESISTITUTION)

    self.fixture = fixture
    self.body    = body
end


function BlockComponent:delete()
    self.fixture:destroy()
    self.body:destroy()
end


---@return BlockComponent
function BlockComponent.new(x, y, w, h)
    local obj = Component.new()

    obj.x, obj.y = x, y
    obj.w, obj.h = w, h

    local mt = getmetatable(obj)
    mt.__index = BlockComponent
    return setmetatable(obj, mt)
end


return BlockComponent
