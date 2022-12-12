--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug = require('lib.luidebug'):getInstance()
local Roomy    = require('lib.roomy'):getInstance()

---@class Dummy : Scene
local Dummy = {}


function Dummy:enter(prev, ...)

end


function Dummy:update(dt)

end


function Dummy:draw()

end


function Dummy:leave(next, ...)

end


return Dummy
