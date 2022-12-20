--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem
local lg = love.graphics


--------------------------------------------------------------
-- require
--------------------------------------------------------------
local Component  = require('class.component')
local Controller = require('class.controller'):getInstance()


---@class VariableControllerUIComponent : Component
---@field text     TextComponent
---@field color    ColorComponent
---@field position PositionComponent
local VariableControllerUIComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function VariableControllerUIComponent:update(dt, context)
    self._generated_text = self._text_generator()
end


---@param context Context
function VariableControllerUIComponent:draw(context)
    self.color:setColor()
    lg.setFont(self.text.font)
    lg.print(self._generated_text, self.position.x, self.position.y)
end


---@param context Context
function VariableControllerUIComponent:onAdd(context)
    self.text     = context:get('text')
    self.color    = context:get('color')
    self.position = context:get('position')

    self.latest_controller_type = nil
    self._generated_text = ""

    self._text_generator = function()
        local latest_controller_type = Controller:getLatestControllerType()
        if latest_controller_type == self.latest_controller_type then
            return self._generated_text
        end

        self.latest_controller_type = latest_controller_type
        local txt = self.text.text
        local controls = Controller:getControlConfig(latest_controller_type)

        txt = txt:gsub('__%w+__', function(s)
            for key, value in pairs(controls) do
                if ('__%s__'):format(key) == s then
                    return value
                end
            end
        end)

        return txt
    end
end


function VariableControllerUIComponent:delete()

end


---@return Component
function VariableControllerUIComponent.new(name)
    local obj = Component.new(name)

    local mt = getmetatable(obj)
    mt.__index = VariableControllerUIComponent
    return setmetatable(obj, mt)
end


return VariableControllerUIComponent
