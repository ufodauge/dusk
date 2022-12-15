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
local POP_ANGLE_UI_POINTS    = { 60, 0, 45, -10, 45, 10 }
local POP_STRENGTH_UI_X_REL  = 70
local POP_STRENGTH_UI_Y_REL  = -70
local POP_STRENGTH_UI_RADIUS = 30

local SOC_F = 0.269
local SOC_Z = 2.231
local SOC_R = 1.885


local Component = require('class.component')

---@class PlayerUiComponent : Component
---@field x        number # ui's origin
---@field y        number # ui's origin
---@field player   PlayerComponent
---@field position PositionComponent
---@field color    ColorComponent
---@field sod      SecondOrderDynamics
local PlayerUiComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function PlayerUiComponent:update(dt, context)
    local vec = self.sod:update(dt, Vector(self.position.x, self.position.y))
    self.x, self.y = vec.x, vec.y

    -- get angle and strength
    --------------------------------------------------------------
    self.pop_angle = self.player.pop_angle
    self.pop_strength_rate = self.player.pop_strength_rate
end


---@param context Context
function PlayerUiComponent:draw(context)
    -- draw direction indicator ui
    --[[
        TODO: UI が画面外に行ってしまうことがあるので画面内に常駐するよう調整]]
    --------------------------------------------------------------
    lg.push()
    do
        lg.translate(self.x, self.y)
        local default_line_width = lg.getLineWidth()

        lg.setLineWidth(1)

        -- strength ui
        --------------------------------------------------------------
        lg.setColor(self.color.color_table)
        lg.circle('fill',
            POP_STRENGTH_UI_X_REL,
            POP_STRENGTH_UI_Y_REL,
            POP_STRENGTH_UI_RADIUS * self.player.pop_strength_rate)
        lg.setColor(1, 1, 1, 1)
        lg.circle('line',
            POP_STRENGTH_UI_X_REL,
            POP_STRENGTH_UI_Y_REL,
            POP_STRENGTH_UI_RADIUS)

        -- angle ui
        --------------------------------------------------------------
        lg.rotate(self.player.pop_angle)
        lg.setColor(self.color.color_table)
        lg.polygon('fill', POP_ANGLE_UI_POINTS)
        -- lg.setColor(1, 1, 1, 1)
        -- lg.polygon('line', POP_ANGLE_UI_POINTS)

        lg.setLineWidth(default_line_width)
    end
    lg.pop()
end


---@param context Context
function PlayerUiComponent:onAdd(context)
    self.color    = context:get('color')
    self.player   = context:get('player')
    self.position = context:get('position')

    -- track self position smoothly
    --------------------------------------------------------------
    self.sod = SecondOrderDynamics(
        SOC_F, SOC_Z, SOC_R,
        Vector(self.position.x, self.position.y))

    self.x, self.y = self.position.x, self.position.y
end


function PlayerUiComponent:delete()

end


---@return Component
function PlayerUiComponent.new(name)
    local obj = Component.new(name)

    obj.color    = nil
    obj.player   = nil
    obj.position = nil
    obj.sod      = nil

    obj.x = 0
    obj.y = 0

    local mt = getmetatable(obj)
    mt.__index = PlayerUiComponent
    return setmetatable(obj, mt)
end


return PlayerUiComponent
