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


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug        = require('lib.luidebug'):getInstance()
local Roomy           = require('lib.roomy'):getInstance()
local ComponentLoader = require('class.component_loader')
local lume            = require('lib.lume')
local LightWorld      = require('lib.lightworld.lib')
local Signal          = require('lib.signal')
local ResultScene     = require('scene.result')
local Signal          = require('lib.signal')


---@class GameScene : Scene
local GameScene = {}

local current_level = 0 ---@type integer
local instances     = {} ---@type GameObject[]
local instances_hud = {} ---@type GameObject[]
local world         = nil ---@type love.World
local light_world   = nil


---@param prev Scene
---@param level integer
function GameScene:enter(prev, level)
    -- load entire level data
    --------------------------------------------------------------
    current_level = level or 1

    -- physics world
    --------------------------------------------------------------
    world = lp.newWorld()
    world:setGravity(WORLD_GRAVITY_X, WORLD_GRAVITY_Y)

    -- light world
    --------------------------------------------------------------
    light_world = LightWorld({
         ambient = { 0.8, 0.8, 0.8 }
    })
    -- light_world.post_shader:addEffect('tilt_shift')


    local loader = ComponentLoader.new(('data/level/%d.lua'):format(current_level))

    loader:setRelationToSceneBasedObject(
        world,
        'createPhysicsObject')
    loader:setRelationToSceneBasedObject(
        light_world,
        'setLightWorld')

    instances     = loader:getInstances()
    instances_hud = loader:getHUDInstances()


    LuiDebug.debug_menu:addCommand('goal', function()
        Signal.send('goaled')
    end)
end


function GameScene:resume(prev, ...)
    print('resumed')
end


function GameScene:update(dt)
    world:update(dt)
    light_world:update(dt)

    for i = #instances, 1, -1 do
        instances[i]:update(dt)
        if instances[i].dead then
            instances[i]:delete()
            table.remove(instances, i)
        end
    end
    for i = #instances_hud, 1, -1 do
        instances_hud[i]:update(dt)
        if instances_hud[i].dead then
            instances_hud[i]:delete()
            table.remove(instances_hud, i)
        end
    end
end


function GameScene:draw()
    light_world:draw(function()
        love.graphics.clear()
        for _, instance in ipairs(instances) do
            if instance then
                instance:draw()
            end
        end
    end)
    for _, instance in ipairs(instances_hud) do
        if instance then
            instance:draw()
        end
    end
end


function GameScene:pause(next, ...)
    print('paused')
end


---@param next Scene
function GameScene:leave(next)
    for i = #instances, 1, -1 do
        if instances[i].delete then
            instances[i]:delete()
        end
        instances[i] = nil
    end
    for i = #instances_hud, 1, -1 do
        if instances_hud[i].delete then
            instances_hud[i]:delete()
        end
        instances_hud[i] = nil
    end
    world:destroy()
    LuiDebug.debug_menu:removeCommand('goal')
end


-- events
--------------------------------------------------------------
-- Signal.subscribe('goaled', function()
--     light_world.post_shader:addEffect('blur', 10.0, 10.0)



--     Roomy:push(ResultScene)
-- end)


return GameScene
