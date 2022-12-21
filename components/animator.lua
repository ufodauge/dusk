--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local Flux     = require('lib.flux')
local Signal   = require('lib.signal')
local LuiDebug = require('lib.luidebug'):getInstance()


---@class AnimationController
---@field [1] number
---@field [2] table<string, number|boolean>|nil
---@field [3] EaseType
---@field [4] number
---@field [5] function
---@field [6] function
---@field [7] function


local Component = require('class.component')

---@class AnimatorComponent : Component
---@field _tween      Tween
---@field _defaults   table<Component, table<string, number|boolean>>
---@field comp_name   string
---@field signal      string
---@field controllers AnimationController[]
---@field _registerAnimationWrapper function
local AnimatorComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function AnimatorComponent:update(dt, context)

end


---@param context Context
function AnimatorComponent:draw(context)

end


---@param context Context
function AnimatorComponent:onAdd(context)
    self._tween = nil
    if self.signal then
        self._registerAnimationWrapper = function()
            self:_registerAnimations(context)
        end
        Signal.subscribe(self.signal, self._registerAnimationWrapper)
    else
        self:_registerAnimations(context)
    end
end


---@param context Context
function AnimatorComponent:_registerAnimations(context)
    if self._tween then
        self._tween:stop()
        self._tween = nil
    end
    for _, controller in ipairs(self.controllers) do
        local comp = context:get(self.comp_name)
        self:_chainAnimation(comp, controller)
    end
end


---@param comp Component
---@param controller AnimationController
function AnimatorComponent:_chainAnimation(comp, controller)
    local slice = {}
    local bools = {}

    if not self._defaults[comp] then
        self._defaults[comp] = {}
        for k, v in pairs(controller[2]) do
            self._defaults[comp][k] = comp[k]
        end
    end

    if controller[2] then
        for k, v in pairs(controller[2]) do
            if type(v) == 'number' then
                slice[k] = v
            elseif type(v) == 'boolean' then
                bools[k] = v
            end
        end
    else
        for k, v in pairs(self._defaults[comp]) do
            if type(v) == 'number' then
                slice[k] = v
            elseif type(v) == 'boolean' then
                bools[k] = v
            end
        end
    end

    if self._tween then
        self._tween
            :after(comp, controller[1], slice)
            :ease(controller[3] or 'quadout')
            :delay(controller[4] or 0)
            :oncomplete(function()
                for k, v in pairs(bools) do
                    comp[k] = v
                end
            end)
    else
        self._tween = Flux.to(comp, controller[1], slice)
            :ease(controller[3] or 'quadout')
            :delay(controller[4] or 0)
            :oncomplete(function()
                for k, v in pairs(bools) do
                    comp[k] = v
                end
            end)
    end
end


function AnimatorComponent:delete()
    self._tween:stop()
    if self.signal then
        Signal.unsubscribe(self.signal, self._registerAnimationWrapper)
    end
end


---@param name        string
---@param comp_name   string  # component's name to control
---@param controllers AnimationController[]
---@param signal      string  # event's name
---@return AnimatorComponent|Component
function AnimatorComponent.new(name, comp_name, controllers, signal)
    local obj = Component.new(name)

    obj._tween = nil

    obj.comp_name   = comp_name
    obj.controllers = controllers
    obj.signal      = signal

    obj._defaults = {}
    obj._registerAnimationWrapper = nil

    local mt = getmetatable(obj)
    mt.__index = AnimatorComponent
    return setmetatable(obj, mt)
end


return AnimatorComponent
