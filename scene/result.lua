--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem
local lp = love.physics
local lg = love.graphics


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug          = require('lib.luidebug'):getInstance()
local Roomy             = require('lib.roomy'):getInstance()
local ComponentLoader   = require('class.component_loader')
local GameObjectManager = require('class.gameobject_manager')
local MANAGER_TAG       = require('data.manager_tag')
local RECORDS_COUNT     = require('data.constants').RECORDS_COUNT


--------------------------------------------------------------
-- Components
--------------------------------------------------------------
local Components = require('lib.cargo').init('components')


---@class ResultScene : Scene
local ResultScene = {}

---@type GameScene
local GameScene = nil
local manager   = {} ---@type GameObjectManager

function ResultScene:enter(prev, time)
    GameScene = prev

    local loader = ComponentLoader.new('data/result_layout.lua')

    manager = GameObjectManager.new(
        loader:getInstances(), MANAGER_TAG.RESULT)

    local timer = manager
        :getObjectById('timer')
        :getComponentByName('timer') --[[@as TimerComponent]]

    timer:setTime(time)
    timer:saveTime(GameScene.current_level)

    for i = 1, RECORDS_COUNT do
        local lb = manager
            :getObjectById(('leaderboard_rank_%d'):format(i))
            :getComponentByName('leaderboard') --[[@as LeaderboardComponent]]
        lb:setLeaderboardData(GameScene.current_level)
    end
end


function ResultScene:update(dt)
    GameScene:update(dt / 4)
    manager:update(dt)
end


function ResultScene:draw()
    GameScene:draw()
    manager:draw()
end


function ResultScene:leave(next, ...)
    manager:delete()
end


return ResultScene
