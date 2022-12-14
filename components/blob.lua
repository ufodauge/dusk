--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local NODE_RADIUS = 2
local PHYSICS_POLYGONS = require('data.constants').PHYSICS_POLYGONS
local CATEGORY = require('data.box2d_category')

--------------------------------------------------------------
-- require
--------------------------------------------------------------
local Blob = require('lib.blob')
local LuiDebug = require('lib.luidebug'):getInstance()

--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics
local assets = love.assets


local SE = {
    BOUND = assets.sound['pop-up'] --[[@as love.Source]]
}


local Component = require('class.component')

---@class BlobComponent : Component
---@field color     ColorComponent
---@field position  PositionComponent
---@field radius    RadiusComponent
---@field blob      Blob
---@field _world    love.World
---@field category  integer
---@field fixed     boolean
local BlobComponent = setmetatable({}, { __index = Component })


---@param dt number
---@param context Context
function BlobComponent:update(dt, context)
    self.blob:update()
    self.position.x, self.position.y = self.blob.kernel_body:getPosition()

    -- if self._world:getContactCount() == 0 then
    --     return
    -- end

    -- local contacts = self._world:getContacts()

    -- for _, contact in ipairs(contacts) do
    --     local fix_a, fix_b = contact:getFixtures()
    --     local cat_a = fix_a:getCategory()
    --     local cat_b = fix_b:getCategory()

    --     if cat_a == CATEGORY.PLAYER or cat_b == CATEGORY.PLAYER then
    --         SE.BOUND:play()
    --         break
    --     end
    -- end
end


---@param context Context
function BlobComponent:draw(context)
    self.color:setColor()
    self.blob:draw()

    if LuiDebug:getFlag(PHYSICS_POLYGONS) then
        self.blob:drawDebug()
    end
end


---@param context Context
function BlobComponent:onAdd(context)
    self.color    = context:get('color')
    self.position = context:get('position')
    self.radius   = context:get('radius')
end


function BlobComponent:delete()
    if self.blob then
        self.blob:destroy()
    end
end


---@return number, number
function BlobComponent:getPosition()
    return self.blob.kernel_body:getPosition()
end


---@param ix number
---@param iy number
function BlobComponent:applyLinearImpulse(ix, iy)
    self.blob.kernel_body:applyLinearImpulse(ix, iy)
end


---@param world love.World
function BlobComponent:createPhysicsObject(world)
    self.blob = Blob.new(
        world,
        self.position.x,
        self.position.y,
        self.radius.r - NODE_RADIUS,
        NODE_RADIUS)

    if self.fixed then
        self.blob:fixPosition()
    end

    self._world = world
end


---@param fixed boolean?
---@return BlobComponent
function BlobComponent.new(name, fixed)
    local obj = Component.new(name)

    obj.color    = nil
    obj.position = nil
    obj.raidus   = nil

    obj.blob = nil

    obj.fixed = fixed or false

    local mt = getmetatable(obj)
    mt.__index = BlobComponent
    return setmetatable(obj, mt)
end


return BlobComponent
