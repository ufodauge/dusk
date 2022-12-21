--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem
local lg = love.graphics


--------------------------------------------------------------
-- require
--------------------------------------------------------------
local Signal     = require('lib.signal')
local LuiDebug   = require('lib.luidebug'):getInstance()
local Controller = require('class.controller'):getInstance()
local quadout    = require('lib.easing.quad').o


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local POP_STRENGTH = 170
local CATEGORY     = require('data.box2d_category')
local EVENT_NAME   = require('data.event_name')

local Component = require('class.component')


---@class PlayerComponent : Component
---@field blob              BlobComponent
---@field pop_angle         number
---@field pop_strength_rate number
---@field controllable      boolean
---@field _send_goal_time   function
local PlayerComponent = setmetatable({}, { __index = Component })

---comment
---@param dt number
---@param context Context
function PlayerComponent:update(dt, context)
    if not self.controllable then
        return
    end


    -- angle controlls
    --------------------------------------------------------------
    local axis_x, axis_y = Controller:get('move')
    if axis_x == 0 and axis_y == 0 then

        -- tilt angle
        --------------------------------------------------------------
        if Controller:down('tilt_left') then
            self.pop_angle = self.pop_angle - math.pi / 128
        end
        if Controller:down('tilt_right') then
            self.pop_angle = self.pop_angle + math.pi / 128
        end

    else

        -- direction angle
        --------------------------------------------------------------
        self.pop_angle = -math.atan2(axis_x, axis_y) + math.pi / 2

    end


    -- jump controlls
    --------------------------------------------------------------
    if Controller:released('action') then
        self.blob:applyLinearImpulse(
            POP_STRENGTH * math.cos(self.pop_angle) * self.pop_strength_rate,
            POP_STRENGTH * math.sin(self.pop_angle) * self.pop_strength_rate)
    end


    if Controller:down('action') then
        self._time = (self._time + dt) % 1
    else
        self._time = 0
    end
    self.pop_strength_rate = quadout(self._time)
end


function PlayerComponent:draw()
end


---@param context Context
function PlayerComponent:onAdd(context)
    self.blob = context:get('blob')
    self.blob.blob:setCategory(CATEGORY.PLAYER)
end


function PlayerComponent:delete()
    Signal.unsubscribe(EVENT_NAME.GOALED, self._send_goal_time)
end


---@return PlayerComponent
function PlayerComponent.new(name)
    local obj = Component.new(name)

    obj.position = nil
    obj.blob     = nil

    -- indicator status
    --------------------------------------------------------------
    obj.pop_angle         = -math.pi / 2
    obj.pop_strength_rate = 0
    obj._time             = 0


    obj.controllable = true

    obj._send_goal_time = function()
        obj.controllable = false
    end
    Signal.subscribe(EVENT_NAME.GOALED, obj._send_goal_time)

    local mt = getmetatable(obj)
    mt.__index = PlayerComponent
    return setmetatable(obj, mt)
end


return PlayerComponent
