--------------------------------------------------------------
-- LevelEditor
-- 自由な大きさのブロックを配置できるレベルエディタ
--------------------------------------------------------------

--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug   = require('lib.luidebug'):getInstance()
local Roomy      = require('lib.roomy'):getInstance()
-- local Background = require('class.background')

---@class LevelEditor : Scene
local LevelEditor = {}

-- local background = nil

function LevelEditor:enter(prev, ...)
    -- background = Background.new()
end


function LevelEditor:update(dt)

end


function LevelEditor:draw()
    -- background:draw()
end


function LevelEditor:leave(next, ...)

end


return LevelEditor
