--------------------------------------------------------------
-- LOCAL_LUA_DEBUGGER_VSCODE
--------------------------------------------------------------
if os.getenv('LOCAL_LUA_DEBUGGER_VSCODE') == '1' then
    require('lldebugger').start()
end


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug = require('lib.luidebug'):getInstance()
local Roomy    = require('lib.roomy'):getInstance()
Assets         = require('lib.cargo').init({
    dir = 'assets',
    processors = {
        ['images/'] = function(image, filename)
            image:setFilter('nearest', 'nearest')
        end
    }
})


function love.load()
    Roomy:hook()

    LuiDebug:activate()
    LuiDebug:setRoomy(Roomy)
    LuiDebug:setScenePath('scene')
end


function love.update(dt)
    LuiDebug:update(dt)
end


function love.draw()
    LuiDebug:draw()
end
