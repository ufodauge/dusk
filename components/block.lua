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
---@field color    ColorComponent
---@field position PositionComponent
---@field size     SizeComponent
---@field body     love.Body
---@field fixture  love.Fixture
local BlockComponent = setmetatable({}, { __index = Component })


---@param world love.World
function BlockComponent:createPhysicsObject(world)
    local body    = lp.newBody(
        world,
        self.position.x + self.size.w / 2,
        self.position.y + self.size.h / 2,
        'static')
    local shape   = lp.newRectangleShape(
        self.size.w,
        self.size.h)
    local fixture = lp.newFixture(body, shape)

    fixture:setRestitution(RESISTITUTION)

    self.fixture = fixture
    self.body    = body
end


---@param context Context
function BlockComponent:onAdd(context)
    self.color    = context:get('color')
    self.position = context:get('position')
    self.size     = context:get('size')
end


function BlockComponent:delete()
    self.fixture:destroy()
    self.body:destroy()
end


---@return BlockComponent
function BlockComponent.new(name)
    local obj = Component.new(name)

    obj.color    = nil
    obj.position = nil
    obj.size     = nil

    obj.fixture = nil
    obj.body    = nil

    local mt = getmetatable(obj)
    mt.__index = BlockComponent
    return setmetatable(obj, mt)
end


return BlockComponent
