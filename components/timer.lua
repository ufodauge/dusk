--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug = require('lib.luidebug')
local Roomy    = require('lib.roomy'):getInstance()
local Signal   = require('lib.signal')
local Bitser   = require('lib.bitser')
local Lume     = require('lib.lume')
local util     = require('lib.util')


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local EVENT_NAME                     = require('data.event_name')
local RECORDS_COUNT                  = require('data.constants').RECORDS_COUNT
local TIMER_FORMAT                   = '%02d:%02d.%02d'
local SAVEDATA_FILENAME              = require('data.constants').SAVEDATA_FILENAME
local DEFAULT_LEVEL_LEADERBOARD_DATA = require('data.constants').DEFAULT_LEVEL_LEADERBOARD_DATA


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics
local lf = love.filesystem


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

    self.time = util.clamp_time(self.time + dt)
end


---@param context Context
function TimerComponent:draw(context)
    if self.hide then
        return
    end

    self.color:setColor()
    lg.setFont(self.text.font)
    lg.print(
        (TIMER_FORMAT):format(
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

    self._signal = function()
        self.working = false
        self.hide    = true
        Signal.send(EVENT_NAME.SEND_GOAL_TIME, self.time)
    end
    Signal.subscribe(EVENT_NAME.GOALED, self._signal)
end


function TimerComponent:delete()
    Signal.unsubscribe(EVENT_NAME.GOALED, self._signal)
end


---@param time number
function TimerComponent:setTime(time)
    self.working = false
    self.time = util.clamp_time(time)
end


function TimerComponent:saveTime(level)
    ---@type LeaderboardData
    local leader_board = util.load_times(level)

    leader_board[level][RECORDS_COUNT + 1] = self.time
    leader_board[level] = Lume.sort(leader_board[level])
    leader_board[level][RECORDS_COUNT + 1] = nil

    Bitser.dumpLoveFile(SAVEDATA_FILENAME, leader_board)
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

    obj._signal = function() end

    local mt = getmetatable(obj)
    mt.__index = TimerComponent
    return setmetatable(obj, mt)
end


return TimerComponent
