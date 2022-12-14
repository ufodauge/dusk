local LuiDebug = require('lib.luidebug'):getInstance()
--------------------------------------------------------------
-- Debug
--------------------------------------------------------------
if os.getenv('LOCAL_LUA_DEBUGGER_VSCODE') == '1' then
    require('lldebugger').start()
end
LuiDebug:activate()


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics
local ls = love.sound
local la = love.audio


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local Controller = require('class.controller'):getInstance()
local Roomy      = require('lib.roomy'):getInstance()
local Flux       = require('lib.flux')
local Coil       = require('lib.coil')
love.assets      = require('lib.cargo').init({
    dir = 'assets',
    loaders = {
        wav = function(wav)
            return la.newSource(ls.newSoundData(wav))
        end
    },
    processors = {
        ['images/'] = function(image, filename)
            image:setFilter('nearest', 'nearest')
        end,
        ['sound/'] = function(wav, filename)
            wav:setVolume(0.1)
        end,
    }
})
local GameScene  = require('scene.game')


LuiDebug:addFlag(require('data.constants').PHYSICS_POLYGONS)


function love.load()
    Roomy:hook {
        exclude = { 'update', 'draw' },
    }

    LuiDebug:setRoomy(Roomy)
    LuiDebug:setScenePath('scene')

    Roomy:enter(GameScene, 1)
end


function love.update(dt)
    Flux.update(dt)
    Coil.update(dt)

    Controller:update()

    Roomy:emit('update', dt)

    LuiDebug:update(dt)
end


function love.draw()
    Roomy:emit('draw')
    LuiDebug:draw()
end
