local LuiDebug = require('lib.luidebug'):getInstance()
--------------------------------------------------------------
-- Debug
--------------------------------------------------------------
if os.getenv('LOCAL_LUA_DEBUGGER_VSCODE') == '1' then
    require('lldebugger').start()
    LuiDebug:activate()
end


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local Controller = require('class.controller'):getInstance()
local Roomy      = require('lib.roomy'):getInstance()
local Flux       = require('lib.flux')
local Coil       = require('lib.coil')
love.assets      = require('lib.cargo').init({
    dir = 'assets',
    processors = {
        ['images/'] = function(image, filename)
            image:setFilter('nearest', 'nearest')
        end
    }
})

LuiDebug:addFlag(require('data.constants').PHYSICS_POLYGONS)


function love.load()
    Roomy:hook()

    LuiDebug:setRoomy(Roomy)
    LuiDebug:setScenePath('scene')
end


function love.update(dt)
    Flux.update(dt)
    Coil.update(dt)

    Controller:update()

    LuiDebug:update(dt)
end


function love.draw()
    LuiDebug:draw()
end
