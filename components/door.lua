--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics
local sin, cos = math.sin, math.cos


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local CATEGORY               = require('data.box2d_category')
local EVENT_NAME             = require('data.event_name')
local ROTATION_CIRCLE_RADIUS = 5
local PI                     = math.pi


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug   = require('lib.luidebug'):getInstance()
local Controller = require('class.controller'):getInstance()
local Signal     = require('lib.signal')
local Roomy      = require('lib.roomy'):getInstance()
local GameScene  = require('scene.game')
local QuartInOut = require('lib.easing.quart').io
local Coil       = require('lib.coil')


local Component = require('class.component')

---@class DoorComponent : Component
---@field level    integer
---@field color    ColorComponent
---@field position PositionComponent
---@field radius   RadiusComponent
---@field rotation RotationComponent
local DoorComponent = setmetatable({}, { __index = Component })

local current_state = EVENT_NAME.PLAYER_LEAVE_FROM_THE_DOOR
local is_player_closer_the_door = false

---@param dt number
---@param context Context
function DoorComponent:update(dt, context)
    self.time = (self.time + dt / 2) % 1
    self.rotation.rot = QuartInOut(self.time) * PI * 2 - PI / 2

    if self.world:getContactCount() == 0 then
        return
    end

    ---@type love.Contact[]
    local contacts = self.world:getContacts()

    is_player_closer_the_door = false

    local pl_x, pl_y = 0, 0

    for _, contact in ipairs(contacts) do
        local fix_a, fix_b = contact:getFixtures()
        local cat_a = fix_a:getCategory()
        local cat_b = fix_b:getCategory()

        if cat_a == CATEGORY.DOOR and cat_b == CATEGORY.PLAYER and self.fixture == fix_a or
            cat_b == CATEGORY.DOOR and cat_a == CATEGORY.PLAYER and self.fixture == fix_b then

            if Controller:pressed('cancel') then
                Coil.add(function()
                    Signal.send(EVENT_NAME.ENTER_TO_LEVEL, self.level)
                    Coil.wait(2)
                    Roomy:enter(GameScene, self.level)
                end)
            end

            if cat_a == CATEGORY.PLAYER then
                pl_x, pl_y = fix_a:getBody():getPosition()
            else
                pl_x, pl_y = fix_b:getBody():getPosition()
            end

            is_player_closer_the_door = true

            break
        end
    end

    if is_player_closer_the_door and
        current_state == EVENT_NAME.PLAYER_LEAVE_FROM_THE_DOOR then

        current_state = EVENT_NAME.PLAYER_GETS_CLOSER_THE_DOOR
        Signal.send(
            EVENT_NAME.PLAYER_GETS_CLOSER_THE_DOOR,
            self.level)
        Signal.send(
            EVENT_NAME.SEND_PLAYER_POSITION,
            pl_x, pl_y)
    elseif not is_player_closer_the_door and
        current_state == EVENT_NAME.PLAYER_GETS_CLOSER_THE_DOOR then

        current_state = EVENT_NAME.PLAYER_LEAVE_FROM_THE_DOOR
        Signal.send(
            EVENT_NAME.PLAYER_LEAVE_FROM_THE_DOOR)
    end
end


---@param context Context
function DoorComponent:draw(context)
    self.color:setColor()
    lg.circle(
        'fill',
        self.position.x + cos(self.rotation.rot) * self.radius.r * 2,
        self.position.y + sin(self.rotation.rot) * self.radius.r * 2,
        ROTATION_CIRCLE_RADIUS)
end


---@param context Context
function DoorComponent:onAdd(context)
    if context:get('ball') then
        local comp   = context:get('ball') --[[@as BallComponent]]
        self.fixture = comp.fixture
        self.body    = comp.body

        self.fixture:setCategory(CATEGORY.DOOR)
        self.fixture:setSensor(true)
    end

    self.color    = context:get('color')
    self.radius   = context:get('radius')
    self.position = context:get('position')
    self.rotation = context:get('rotation')
end


---@param world love.World
function DoorComponent:createPhysicsObject(world)
    self.world = world
end


function DoorComponent:delete()

end


---@return DoorComponent
function DoorComponent.new(name, level)
    local obj = Component.new(name)

    obj.fixture = nil
    obj.body    = nil

    obj.level = level
    obj.time = 0

    obj.color    = nil
    obj.radius   = nil
    obj.position = nil
    obj.rotation = nil

    local mt = getmetatable(obj)
    mt.__index = DoorComponent
    return setmetatable(obj, mt)
end


return DoorComponent
