--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local EVENT_NAME = require('data.event_name')


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local Signal = require('lib.signal')


local Component = require('class.component')

---@class PlayerTrackerComponent : Component
---@field position      PositionComponent
---@field _set_position fun(x: number, y: number)
---@field _ox           number
---@field _oy           number
local PlayerTrackerComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function PlayerTrackerComponent:update(dt, context)
end


---@param context Context
function PlayerTrackerComponent:draw(context)

end


---@param context Context
function PlayerTrackerComponent:onAdd(context)
    self.position = context:get('position')

    self._set_position = function(x, y)
        self.position.x = x + self._ox
        self.position.y = y + self._oy
    end

    Signal.subscribe(
        EVENT_NAME.SEND_NEARBY_DOOR_POSITION,
        self._set_position)
end


function PlayerTrackerComponent:delete()
    Signal.unsubscribe(
        EVENT_NAME.SEND_NEARBY_DOOR_POSITION,
        self._set_position)
end


---@return PlayerTrackerComponent
function PlayerTrackerComponent.new(name, ox, oy)
    local self = Component.new(name)

    self.position = nil

    self._ox = ox
    self._oy = oy

    local mt = getmetatable(self)
    mt.__index = PlayerTrackerComponent
    return setmetatable(self, mt)
end


return PlayerTrackerComponent
