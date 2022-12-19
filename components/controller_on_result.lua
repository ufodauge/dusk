--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem
local lg = love.graphics


--------------------------------------------------------------
-- require
--------------------------------------------------------------
local Controller = require('class.controller'):getInstance()
local Signal     = require('lib.signal')
local LuiDebug   = require('lib.luidebug'):getInstance()
local Roomy      = require('lib.roomy'):getInstance()
local GameScene  = require('scene.game')


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local EVENT_NAME = require('data.event_name')

local Component = require('class.component')


---@class ControllerOnResultComponent : Component
---@field _rt_stage_select  function
local ControllerOnResultComponent = setmetatable({}, { __index = Component })

---comment
---@param dt number
---@param context Context
function ControllerOnResultComponent:update(dt, context)
    if Controller:pressed('action') then
        Signal.send(EVENT_NAME.RETURN_TO_STAGE_SELECT)
        Roomy:enter(GameScene, "world_1")
    end
end


function ControllerOnResultComponent:draw()
end


---@param context Context
function ControllerOnResultComponent:onAdd(context)
end


function ControllerOnResultComponent:delete()
    Signal.unsubscribe(
        EVENT_NAME.RETURN_TO_STAGE_SELECT,
        self._rt_stage_select)
end


---@return ControllerOnResultComponent
function ControllerOnResultComponent.new(name)
    local obj = Component.new(name)

    obj._rt_stage_select = function()

    end
    Signal.subscribe(
        EVENT_NAME.RETURN_TO_STAGE_SELECT,
        obj._rt_stage_select)


    local mt = getmetatable(obj)
    mt.__index = ControllerOnResultComponent
    return setmetatable(obj, mt)
end


return ControllerOnResultComponent
