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
    loader:setRelationToSceneBasedObject(time, 'setTime')

    manager = GameObjectManager.new(
        loader:getInstances())
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
