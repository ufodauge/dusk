--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug = require('lib.luidebug'):getInstance()
local Roomy    = require('lib.roomy'):getInstance()

---@class ResultScene : Scene
local ResultScene = {}
local game_scene = nil

function ResultScene:enter(prev, ...)
    game_scene = prev
end


function ResultScene:update(dt)
    game_scene:update(dt / 4)
end


function ResultScene:draw()
    game_scene:draw()
end


function ResultScene:leave(next, ...)
end


return ResultScene
