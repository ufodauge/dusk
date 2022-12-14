--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local moonshine = require 'lib.moonshine'


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg     = love.graphics
local assets = love.assets


local Component = require('class.component')


---@class BackgroundComponent : Component
---@field color   RGBA
---@field image   love.Image
---@field effect  Moonshine
local BackgroundComponent = setmetatable({}, { __index = Component })


---@param dt number
---@param context Context
function BackgroundComponent:update(dt, context)
end


---@param context Context
function BackgroundComponent:draw(context)
    lg.setBackgroundColor(self.color)
end


---@param context Context
function BackgroundComponent:onAdd(context)
    local color = context:get('color') --[[@as ColorComponent]]
    if color then
        self.color = color.color_table
    end
end


function BackgroundComponent:delete()

end


---@param filename string
---@return BackgroundComponent|Component
function BackgroundComponent.new(filename)
    local obj = Component.new()

    -- obj.image = assets.image.bg[filename]
    obj.color = { 1, 1, 1, 1 }

    local mt = getmetatable(obj)
    mt.__index = BackgroundComponent
    return setmetatable(obj, mt)
end


return BackgroundComponent
