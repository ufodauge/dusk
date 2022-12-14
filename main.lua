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
local Roomy = require('lib.roomy'):getInstance()
love.assets = require('lib.cargo').init({
    dir = 'assets',
    processors = {
        ['images/'] = function(image, filename)
            image:setFilter('nearest', 'nearest')
        end
    }
})


function love.load()
    Roomy:hook()

    LuiDebug:setRoomy(Roomy)
    LuiDebug:setScenePath('scene')
end


function love.update(dt)
    LuiDebug:update(dt)
end


function love.draw()
    LuiDebug:draw()
end
