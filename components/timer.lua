--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug = require('lib.luidebug')
local Roomy    = require('lib.roomy'):getInstance()
local Signal   = require('lib.signal')


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics


local Component = require('class.component')

---@class TimerComponent : Component
---@field time      number
---@field working   boolean
---@field hide      boolean
---@field minute    number
---@field second    number
---@field milisec   number
---@field text      TextComponent
---@field color     ColorComponent
---@field position  PositionComponent
---@field rotation? RotationComponent
local TimerComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function TimerComponent:update(dt, context)
    self.minute  = math.floor(self.time / 60)
    self.second  = math.floor(self.time % 60)
    self.milisec = math.floor((self.time % 1) * 100)

    if not self.working then
        return
    end

    self.time = self.time + dt
end


---@param context Context
function TimerComponent:draw(context)
    if self.hide then
        return
    end

    lg.setColor(self.color.color_table)
    lg.setFont(self.text.font)
    lg.print(
        (self.text.text):format(
            self.minute,
            self.second,
            self.milisec),
        self.position.x,
        self.position.y,
        self.rotation and self.rotation.rot or 0)
end


---@param context Context
function TimerComponent:onAdd(context)
    self.text     = context:get('text')
    self.color    = context:get('color')
    self.position = context:get('position')
    self.rotation = context:get('rotation')

    Signal.subscribe('goaled', function()
        self.working = false
        self.hide    = true
    end)
end


function TimerComponent:delete()

end


function TimerComponent:setTime(time)
    self.working = false
    self.time = time
end


---@return Component
function TimerComponent.new(name)
    local obj = Component.new(name)

    obj.time    = 0
    obj.working = true
    obj.hide    = false

    obj.minute  = 0
    obj.second  = 0
    obj.milisec = 0

    local mt = getmetatable(obj)
    mt.__index = TimerComponent
    return setmetatable(obj, mt)
end


return TimerComponent
