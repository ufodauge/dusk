--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics


local Component = require('class.component')

---@class BulletinBoardComponent : Component
---@field text     TextComponent
---@field color    ColorComponent
---@field position PositionComponent
---@field rotation RotationComponent
local BulletinBoardComponent = setmetatable({}, { __index = Component })

---@param dt number
---@param context Context
function BulletinBoardComponent:update(dt, context)

end


---@param context Context
function BulletinBoardComponent:draw(context)
    lg.setColor(self.color.color_table)
    lg.setFont(self.text.font)
    lg.print(
        self.text.text,
        self.position.x,
        self.position.y,
        self.rotation and self.rotation.rot or 0)
end


---@param context Context
function BulletinBoardComponent:onAdd(context)
    self.text     = context:get('text')
    self.color    = context:get('color')
    self.position = context:get('position')
    self.rotation = context:get('rotation')
end


function BulletinBoardComponent:delete()

end


---@return BulletinBoardComponent
function BulletinBoardComponent.new(name)
    local obj = Component.new(name)

    obj.text     = nil
    obj.color    = nil
    obj.position = nil
    obj.rotation = nil

    local mt = getmetatable(obj)
    mt.__index = BulletinBoardComponent
    return setmetatable(obj, mt)
end


return BulletinBoardComponent
