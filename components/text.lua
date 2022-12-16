--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics


local Component = require('class.component')

---@class TextComponent : Component
---@field font love.Font
---@field text string
local TextComponent = setmetatable({}, { __index = Component })

---comment
---@param name      string
---@param text      string
---@param font_name string
---@param font_size integer
---@return Component|TextComponent
function TextComponent.new(name, text, font_name, font_size)
    local obj = Component.new(name)

    obj.text = text
    obj.font = love.assets.font[font_name](font_size) or lg.getFont()

    local mt = getmetatable(obj)
    mt.__index = TextComponent
    return setmetatable(obj, mt)
end


return TextComponent
