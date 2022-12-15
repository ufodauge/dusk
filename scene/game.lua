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
local CATEGORY = require('data.box2d_category')


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug    = require('lib.luidebug'):getInstance()
local Roomy       = require('lib.roomy'):getInstance()
local GameObject  = require('class.gameobject')
local lume        = require('lib.lume')
local LightWorld  = require('lib.lightworld.lib')
local ResultScene = require('scene.result')


--------------------------------------------------------------
-- Components
--------------------------------------------------------------
local Components = require('lib.cargo').init('components')


---@class GameScene : Scene
local GameScene = {}

local current_level = 0 ---@type integer
local instances     = {} ---@type GameObject[]
local world         = nil ---@type love.World
local light_world   = nil


---@param prev Scene
---@param level integer
function GameScene:enter(prev, level)
    -- load entire level data
    --------------------------------------------------------------
    current_level = level or 1

    local chunk, errmsg = lf.load(('data/level/%d.lua'):format(current_level))
    --[[
        TODO: make it safely
    ]]
    if errmsg then
        error(errmsg)
    end
    local components_data = chunk()


    --[[
        TODO: ゲームオブジェクト化
        そもそもすべきか？
    ]]
    -- physics world
    --------------------------------------------------------------
    world = lp.newWorld()
    world:setGravity(WORLD_GRAVITY_X, WORLD_GRAVITY_Y)


    --[[
        TODO: ゲームオブジェクト化
        draw 関数全体をラップする必要があるができるのか？？？
        多分しなくていい気がするけどどうでしょう
    ]]
    -- light world
    --------------------------------------------------------------
    light_world = LightWorld({
         ambient = { 0.8, 0.8, 0.8 }
    })
    light_world.post_shader:addEffect('tilt_shift')


    --create objects
    --------------------------------------------------------------
    for _, data in ipairs(components_data) do

        -- object
        local game_object = GameObject.new()

        -- add components
        --------------------------------------------------------------
        for _, comp_data in ipairs(data) do

            local comp_name = comp_data[1]

            if Components[comp_name] then
                -- create component
                --------------------------------------------------------------
                local comp = Components[comp_name].new(unpack(comp_data))
                game_object:addComponent(comp, comp_name)

                -- relate scene-based objects
                --------------------------------------------------------------
                if comp.createPhysicsObject then
                    comp:createPhysicsObject(world)
                end

                if comp.setLightWorld then
                    comp:setLightWorld(light_world)
                end
            else

                LuiDebug:log('Component: ' .. comp_name .. ' has not been found.')
            end
        end

        instances[#instances + 1] = game_object
    end
end


function GameScene:resume(prev, ...)
    print('resumed')
end


function GameScene:update(dt)
    world:update(dt)
    light_world:update(dt)

    for _, instance in ipairs(instances) do
        instance:update(dt)
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
    world:destroy()
end


-- events
--------------------------------------------------------------
function GameScene:goaled(...)
    Roomy:push(ResultScene)
end


return GameScene
