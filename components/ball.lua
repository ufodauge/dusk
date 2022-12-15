--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local CATEGORY = require('data.box2d_category')


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lp = love.physics
local lg = love.graphics


local Component = require('class.component')

---@class BallComponent : Component
---@field color    ColorComponent
---@field position PositionComponent
---@field radius   RadiusComponent
---@field body     love.Body
---@field fixture  love.Fixture
---@field category  integer
---@field fixed     boolean
local BallComponent = setmetatable({}, { __index = Component })


---@param world love.World
function BallComponent:createPhysicsObject(world)
    local body  = lp.newBody(
        world,
        self.position.x,
        self.position.y,
        'static')
    local shape = lp.newCircleShape(
        self.radius.r)

    local fixture = lp.newFixture(body, shape)

    self.fixture = fixture
    self.body    = body
end


---@param context Context
function BallComponent:onAdd(context)
    self.color    = context:get('color')
    self.position = context:get('position')
    self.radius   = context:get('radius')
end


function BallComponent:delete()
    self.fixture:destroy()
    self.body:destroy()
end


---@return BallComponent
function BallComponent.new(name, fixed)
    local obj = Component.new(name)

    obj.color    = nil
    obj.position = nil
    obj.size     = nil

    obj.fixture = nil
    obj.body    = nil

    obj.fixed = fixed or false

    local mt = getmetatable(obj)
    mt.__index = BallComponent
    return setmetatable(obj, mt)
end


return BallComponent
