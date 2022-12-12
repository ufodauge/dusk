---@class Component
local Component = {}
Component.param = {}

---@param dt number
---@param context Context?
function Component:update(dt, context)
end


---@param context Context?
function Component:draw(context)
end


function Component:delete()
end


---@return Component
function Component.new()
    local obj = {}

    return setmetatable(obj, { __index = Component })
end


return Component
