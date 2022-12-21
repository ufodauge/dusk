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

---@class PopupLevelDataComponent : Component
---@field level integer
---@field leaderboards LeaderboardComponent[]
---@field text         TextComponent
---@field color        ColorComponent
---@field position     PositionComponent
---@field rotation?    RotationComponent
local PopupLevelDataComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function PopupLevelDataComponent:update(dt, context)

end


---@param context Context
function PopupLevelDataComponent:draw(context)
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
function PopupLevelDataComponent:onAdd(context)
    self.text     = context:get('text')
    self.color    = context:get('color')
    self.position = context:get('position')
    self.rotation = context:get('rotation')
end


function PopupLevelDataComponent:delete()

end


function PopupLevelDataComponent:setLeaderboardData(level)
    self.level = level

    ---@type LeaderboardData
    local leader_board = util.load_times(level)

    self.time = leader_board[level][self.rank]
    self.mm   = math.floor(self.time / 60)
    self.ss   = math.floor(self.time % 60)
    self.ms   = math.floor((self.time % 1) * 100)
end


---@return PopupLevelDataComponent
function PopupLevelDataComponent.new(name, rank)
    local self = Component.new(name)

    self.rank = rank

    local mt = getmetatable(self)
    mt.__index = PopupLevelDataComponent
    return setmetatable(self, mt)
end


return PopupLevelDataComponent
