--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local Signal = require('lib.signal')


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local CATEGORY   = require('data.box2d_category')
local EVENT_NAME = require('data.event_name')


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lp = love.physics
local lg = love.graphics
local assets = love.assets

local SE = {
    GOALED = assets.sound.clear
}


local Component = require('class.component')

---@class GoalComponent : Component
---@field world    love.World
---@field body     love.Body
---@field fixture  love.Fixture
---@field goaled   boolean
local GoalComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function GoalComponent:update(dt, context)
    if self.goaled then
        return
    end
    if self.world:getContactCount() == 0 then
        return
    end

    ---@type love.Contact[]
    local contacts = self.world:getContacts()

    for _, contact in ipairs(contacts) do
        local fix_a, fix_b = contact:getFixtures()
        local cat_a = fix_a:getCategory()
        local cat_b = fix_b:getCategory()

        if cat_a == CATEGORY.PLAYER and cat_b == CATEGORY.GOAL or
            cat_b == CATEGORY.PLAYER and cat_a == CATEGORY.GOAL then
            Signal.send(EVENT_NAME.GOALED)
            self.goaled = true
            SE.GOALED:play()
            break
        end
    end
end


---@param context Context
function GoalComponent:draw(context)

end


---@param context Context
function GoalComponent:onAdd(context)
    if context:get('ball') then
        local comp   = context:get('ball') --[[@as BallComponent]]
        self.fixture = comp.fixture
        self.body    = comp.body

        self.fixture:setCategory(CATEGORY.GOAL)
    end
end


---@param world love.World
function GoalComponent:createPhysicsObject(world)
    self.world = world
end


function GoalComponent:delete()
end


---@return Component
function GoalComponent.new(name)
    local obj = Component.new(name)

    obj.fixture = nil
    obj.body    = nil

    obj.goaled = false

    local mt = getmetatable(obj)
    mt.__index = GoalComponent
    return setmetatable(obj, mt)
end


return GoalComponent
