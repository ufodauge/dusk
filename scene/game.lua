--[[
TODO: メインスレッド止めるな委員会
]]
--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem
local lp = love.physics
local lg = love.graphics


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local WORLD_GRAVITY_X = 0
local WORLD_GRAVITY_Y = 512
local CATEGORY        = require('data.box2d_category')
local EVENT_NAME      = require('data.event_name')


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug          = require('lib.luidebug'):getInstance()
local Roomy             = require('lib.roomy'):getInstance()
local ComponentLoader   = require('class.component_loader')
local GameObjectManager = require('class.gameobject_manager')
local lume              = require('lib.lume')
local LightWorld        = require('lib.lightworld.lib')
local Signal            = require('lib.signal')
local ResultScene       = require('scene.result')
local Signal            = require('lib.signal')


---@class GameScene : Scene
local GameScene = {}

local current_level = '1' ---@type string
local manager       = {} ---@type GameObjectManager
local manager_hud   = {} ---@type GameObjectManager
local world         = nil ---@type love.World
local light_world   = nil


---@param prev Scene
---@param level integer
function GameScene:enter(prev, level)
    -- load entire level data
    --------------------------------------------------------------
    current_level = tostring(level or 1)

    -- physics world
    --------------------------------------------------------------
    world = lp.newWorld()
    world:setGravity(WORLD_GRAVITY_X, WORLD_GRAVITY_Y)

    -- light world
    --------------------------------------------------------------
    light_world = LightWorld({
         ambient = { 0.8, 0.8, 0.8 }
    })
    light_world.post_shader:addEffect('tilt_shift')


    local loader = ComponentLoader.new(('data/level/%s.lua'):format(current_level))

    loader:setRelationToSceneBasedObject(
        world,
        'createPhysicsObject')
    loader:setRelationToSceneBasedObject(
        light_world,
        'setLightWorld')

    manager     = GameObjectManager.new(
        loader:getInstances())
    manager_hud = GameObjectManager.new(
        loader:getInstances('hud'))


    LuiDebug.debug_menu:addCommand('goal', function()
        Signal.send(EVENT_NAME.GOALED)
    end)

    -- events
    --------------------------------------------------------------
    self._send_goal_time = function(time)
        light_world.post_shader:addEffect('blur', 10.0, 10.0)
        Roomy:push(ResultScene, time)
    end
    Signal.subscribe(EVENT_NAME.SEND_GOAL_TIME, self._send_goal_time)
end


function GameScene:resume(prev, ...)
    print('resumed')
end


function GameScene:update(dt)
    world:update(dt)
    light_world:update(dt)

    manager:update(dt)
    manager_hud:update(dt)
end


function GameScene:draw()
    light_world:draw(function()
        manager:draw()
    end)
    manager_hud:draw()
end


function GameScene:pause(next, ...)
    print('paused')
end


---@param next Scene
function GameScene:leave(next)
    manager:delete()
    manager_hud:delete()

    world:destroy()
    LuiDebug.debug_menu:removeCommand('goal')

    Signal.unsubscribe(EVENT_NAME.SEND_GOAL_TIME, self._send_goal_time)
end


return GameScene
