--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem
local lp = love.physics
local lg = love.graphics


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug        = require('lib.luidebug'):getInstance()
local Roomy           = require('lib.roomy'):getInstance()
local ComponentLoader = require('class.component_loader')


--------------------------------------------------------------
-- Components
--------------------------------------------------------------
local Components = require('lib.cargo').init('components')


---@class ResultScene : Scene
local ResultScene = {}

---@type GameScene
local GameScene = nil
local instances = {} ---@type GameObject[]

function ResultScene:enter(prev, time)
    GameScene = prev

    local loader = ComponentLoader.new('data/result_layout.lua')
    loader:setRelationToSceneBasedObject(time, 'setTime')

    instances = loader:getInstances()
end


function ResultScene:update(dt)
    GameScene:update(dt / 4)

    for _, instance in ipairs(instances) do
        instance:update(dt)
    end
end


function ResultScene:draw()
    GameScene:draw()

    for _, instance in ipairs(instances) do
        if instance then
            instance:draw()
        end
    end
end


function ResultScene:leave(next, ...)
end


return ResultScene
