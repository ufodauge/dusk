--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem
local lg = love.graphics


--------------------------------------------------------------
-- require
--------------------------------------------------------------
local Baton    = require('lib.baton')
local Signal   = require('lib.signal')
local LuiDebug = require('lib.luidebug'):getInstance()


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local POP_STRENGTH = 185
local CATEGORY = require('data.box2d_category')


local Component = require('class.component')


---@class PlayerComponent : Component
---@field blob              BlobComponent
---@field pop_angle         number
---@field pop_strength_rate number
---@field baton             any
---@field controllable      boolean
local PlayerComponent = setmetatable({}, { __index = Component })

---comment
---@param dt number
---@param context Context
function PlayerComponent:update(dt, context)
    if not self.controllable then
        return
    end

    -- controlls
    --------------------------------------------------------------
    self.baton:update()


    -- angle controlls
    --------------------------------------------------------------
    local axis_x, axis_y = self.baton:get('move')
    if axis_x == 0 and axis_y == 0 then

        -- tilt angle
        --------------------------------------------------------------
        if self.baton:down('tilt_left') then
            self.pop_angle = self.pop_angle - math.pi / 128
        end
        if self.baton:down('tilt_right') then
            self.pop_angle = self.pop_angle + math.pi / 128
        end

    else

        -- direction angle
        --------------------------------------------------------------
        self.pop_angle = -math.atan2(axis_x, axis_y) + math.pi / 2

    end


    -- jump controlls
    --------------------------------------------------------------
    if self.baton:released('action') then
        self.blob:applyLinearImpulse(
            POP_STRENGTH * math.cos(self.pop_angle) * self.pop_strength_rate,
            POP_STRENGTH * math.sin(self.pop_angle) * self.pop_strength_rate)
    end


    if self.baton:down('action') then
        self.pop_strength_rate = self.pop_strength_rate + dt
        if self.pop_strength_rate > 1 then
            local remainder = self.pop_strength_rate % 1
            self.pop_strength_rate = self.pop_strength_rate - 1 + remainder
        end
    else
        self.pop_strength_rate = 0
    end
end


function PlayerComponent:draw()
end


---@param context Context
function PlayerComponent:onAdd(context)
    self.blob = context:get('blob')
    self.blob.blob:setCategory(CATEGORY.PLAYER)
end


function PlayerComponent:delete()
end


---@return PlayerComponent
function PlayerComponent.new(name)
    local obj = Component.new(name)

    obj.position = nil
    obj.blob     = nil

    -- load keyconfig
    --[[
        TODO: the codes below is only to lode default config
    ]]
    --------------------------------------------------------------
    local config = lf.load('data/key_config.lua')()
    obj.baton = Baton.new(config)

    -- indicator status
    --------------------------------------------------------------
    obj.pop_angle         = -math.pi / 2
    obj.pop_strength_rate = 0


    obj.controllable = true

    Signal.subscribe('goaled', function()
        obj.controllable = false
    end)

    local mt = getmetatable(obj)
    mt.__index = PlayerComponent
    return setmetatable(obj, mt)
end


return PlayerComponent
