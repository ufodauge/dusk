--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem
local lg = love.graphics


--------------------------------------------------------------
-- require
--------------------------------------------------------------
local Baton    = require('lib.baton')
local LuiDebug = require('lib.luidebug'):getInstance()


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local POP_STRENGTH = 1000


local Component = require('class.component')


---@class PlayerComponent : Component
---@field x            number
---@field y            number
---@field r            number
---@field blob         Blob
---@field pop_angle    number
---@field pop_strength_rate number
---@field sod          SecondOrderDynamics
---@field baton        any
local PlayerComponent = setmetatable({}, { __index = Component })

---comment
---@param dt number
---@param context Context
function PlayerComponent:update(dt, context)
    -- update positions with blobs
    --------------------------------------------------------------
    local blob_comp = context:get('blob') --[[@as BlobComponent]]
    self.x, self.y = blob_comp:getPosition()


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
        blob_comp.blob.kernel_body:applyLinearImpulse(
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
    lg.setColor(1, 1, 1)
end


function PlayerComponent:delete()
end


---@return PlayerComponent
function PlayerComponent.new()
    local obj = Component.new()

    obj.x, obj.y = 0, 0
    obj.sod = nil

    -- load keyconfig
    -- TODO: the codes below is only to lode default config
    --------------------------------------------------------------
    local config = lf.load('data/key_config.lua')()
    obj.baton = Baton.new(config)

    -- indicator status
    --------------------------------------------------------------
    obj.pop_angle         = -math.pi / 2
    obj.pop_strength_rate = 0


    local mt = getmetatable(obj)
    mt.__index = PlayerComponent
    return setmetatable(obj, mt)
end


return PlayerComponent
