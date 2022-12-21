--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem
local lg = love.graphics


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local util = require('lib.util')


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local SAVEDATA_FILENAME = require('data.constants').SAVEDATA_FILENAME


local Component = require('class.component')

---@class LeaderboardComponent : Component
---@field level integer
---@field rank  integer
---@field time  number
---@field mm    number
---@field ss    number
---@field ms    number
---@field text      TextComponent
---@field color     ColorComponent
---@field position  PositionComponent
---@field rotation? RotationComponent
local LeaderboardComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function LeaderboardComponent:update(dt, context)

end


---@param context Context
function LeaderboardComponent:draw(context)
    self.color:setColor()
    lg.setFont(self.text.font)
    lg.print(
        (self.text.text):format(
            self.mm,
            self.ss,
            self.ms),
        self.position.x,
        self.position.y,
        self.rotation and self.rotation.rot or 0)
end


---@param context Context
function LeaderboardComponent:onAdd(context)
    self.text     = context:get('text')
    self.color    = context:get('color')
    self.position = context:get('position')
    self.rotation = context:get('rotation')
end


function LeaderboardComponent:delete()

end


function LeaderboardComponent:setLeaderboardData(level)
    self.level = level

    ---@type LeaderboardData
    local leader_board = util.load_times(level)

    self.time = leader_board[level][self.rank]
    if self.time == -1 then
        self.mm = 59
        self.ss = 59
        self.ms = 99
        
        return
    end
    self.mm = math.floor(self.time / 60)
    self.ss = math.floor(self.time % 60)
    self.ms = math.floor((self.time % 1) * 100)
end


---@return LeaderboardComponent
function LeaderboardComponent.new(name, rank)
    local self = Component.new(name)

    self.rank = rank

    local mt = getmetatable(self)
    mt.__index = LeaderboardComponent
    return setmetatable(self, mt)
end


return LeaderboardComponent
