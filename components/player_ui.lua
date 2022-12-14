--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local SecondOrderDynamics = require('lib.sos').SecondOrderDynamics
local Vector              = require('lib.sos').Vector


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local POP_ANGLE_UI_POINTS    = { 60, 0, 50, -5, 55, 0, 50, 5 }
local POP_STRENGTH_UI_X_REL  = 80
local POP_STRENGTH_UI_Y_REL  = -80
local POP_STRENGTH_UI_RADIUS = 25

local SOC_F = 0.923
local SOC_Z = 0.462
local SOC_R = -0.231


local Component = require('class.component')

---@class PlayerUiComponent : Component
---@field x                 number
---@field y                 number
---@field pop_angle         number
---@field pop_strength_rate number
local PlayerUiComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function PlayerUiComponent:update(dt, context)
    local player = context:get('player') --[[@as PlayerComponent]]

    -- track self position smoothly
    --------------------------------------------------------------
    local x, y = player.x, player.y
    if not self.sod then
        self.sod = SecondOrderDynamics(SOC_F, SOC_Z, SOC_R, Vector(x, y))
    end
    local vec = self.sod:update(dt, Vector(x, y))

    self.x, self.y = vec.x, vec.y


    -- get angle and strength
    --------------------------------------------------------------
    self.pop_angle = player.pop_angle
    self.pop_strength_rate = player.pop_strength_rate
end


---@param context Context
function PlayerUiComponent:draw(context)
    -- draw direction indicator ui
    --------------------------------------------------------------
    lg.push()
    do
        lg.translate(self.x, self.y)
        local default_line_width = lg.getLineWidth()

        lg.setLineWidth(2)

        -- strength ui
        --------------------------------------------------------------
        lg.setColor(0.6, 0.6, 1, 1)
        lg.circle('fill',
            POP_STRENGTH_UI_X_REL,
            POP_STRENGTH_UI_Y_REL,
            POP_STRENGTH_UI_RADIUS * self.pop_strength_rate)
        lg.setColor(1, 1, 1, 1)
        lg.circle('line',
            POP_STRENGTH_UI_X_REL,
            POP_STRENGTH_UI_Y_REL,
            POP_STRENGTH_UI_RADIUS)

        -- angle ui
        --------------------------------------------------------------
        lg.rotate(self.pop_angle)
        lg.setColor(0.6, 0.6, 1, 1)
        lg.polygon('fill', POP_ANGLE_UI_POINTS)
        lg.setColor(1, 1, 1, 1)
        lg.polygon('line', POP_ANGLE_UI_POINTS)

        lg.setLineWidth(default_line_width)
    end
    lg.pop()
end


function PlayerUiComponent:delete()

end


---@return Component
function PlayerUiComponent.new()
    local obj = Component.new()

    local mt = getmetatable(obj)
    mt.__index = PlayerUiComponent
    return setmetatable(obj, mt)
end


return PlayerUiComponent
