--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem
local lp = love.physics


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local WORLD_GRAVITY_X = 0
local WORLD_GRAVITY_Y = 512

--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug   = require('lib.luidebug'):getInstance()
local Roomy      = require('lib.roomy'):getInstance()
local GameObject = require('class.gameobject')
local lume       = require('lib.lume')

--------------------------------------------------------------
-- Components
--------------------------------------------------------------
local Components = require('lib.cargo').init('components')

local game = {}

local current_level = 0 ---@type integer
local instances     = {} ---@type GameObject[]
local world         = nil ---@type love.World


---@param prev Scene
---@param level integer
function game:enter(prev, level)
    level = level or 1

    -- load entire level data
    --------------------------------------------------------------
    current_level = level

    local chunk, errmsg = lf.load(('data/level/%d.lua'):format(level))
    -- TODO: make it safely
    if errmsg then
        error(errmsg)
    end
    local components_data = chunk()


    -- physics world
    --------------------------------------------------------------
    world = lp.newWorld()
    world:setGravity(WORLD_GRAVITY_X, WORLD_GRAVITY_Y)


    --create objects
    --------------------------------------------------------------
    for _, data in ipairs(components_data) do

        -- object
        local game_object = GameObject.new()

        -- add components
        --------------------------------------------------------------
        for component_name, args in pairs(data) do
            if Components[component_name] then
                -- create component
                --------------------------------------------------------------
                local comp = Components[component_name].new(unpack(args))


                -- relate scene-based objects
                --------------------------------------------------------------
                if comp.createPhysicsObject then
                    comp:createPhysicsObject(world)
                end


                game_object:addComponent(comp, component_name)
            else

                LuiDebug:log('Component: ' .. component_name .. ' has not been found.')
            end
        end

        instances[#instances + 1] = game_object
    end
end


function game:update(dt)
    world:update(dt)
    for _, instance in ipairs(instances) do
        instance:update(dt)
    end
end


function game:draw()
    for _, instance in ipairs(instances) do
        if instance then
            instance:draw()
        end
    end
end


---@param next Scene
function game:leave(next)
    for i = #instances, 1, -1 do
        if instances[i].delete then
            instances[i]:delete()
        end
        instances[i] = nil
    end
    world:destroy()
end


return game
