--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local NODE_RADIUS = 2
local PHYSICS_POLYGONS = require("data.constants").PHYSICS_POLYGONS

--------------------------------------------------------------
-- require
--------------------------------------------------------------
local Blob = require('lib.blob')
local LuiDebug = require('lib.luidebug'):getInstance()


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics


local Component = require('class.component')

---@class BlobComponent : Component
---@field x number
---@field y number
---@field r number
---@field blob Blob
local BlobComponent = setmetatable({}, { __index = Component })


---@param dt number
---@param context Context
function BlobComponent:update(dt, context)
    self.blob:update()
end


---@param context Context
function BlobComponent:draw(context)
    lg.setColor(self.color)
    self.blob:draw()
    -- lg.setColor(self.color)
    -- self.blob:draw('line')

    if LuiDebug:getFlag(PHYSICS_POLYGONS) then
        self.blob:drawDebug()
    end
end


---@param context Context
function BlobComponent:onAdd(context)
    local color = context:get('color') --[[@as ColorComponent]]
    if color then
        self.color = color.color_table
    end
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


---@param world love.World
function BlobComponent:createPhysicsObject(world)
    self.blob = Blob.new(world, self.x, self.y, self.r, NODE_RADIUS)
end


---@return BlobComponent
function BlobComponent.new(x, y, r)
    local obj = Component.new()

    obj.x, obj.y = x, y
    obj.r = r
    obj.color = { 1, 1, 1, 1 }

    local mt = getmetatable(obj)
    mt.__index = BlobComponent
    return setmetatable(obj, mt)
end


return BlobComponent
