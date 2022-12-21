---@class Component
---@field _name string
local Component = {}

---@param dt number
---@param context Context?
function Component:update(dt, context)
end


---@param context Context?
function Component:draw(context)
end


---@param context Context?
function Component:onAdd(context)
    
end


function Component:delete()
end


---@return Component
function Component.new(name)
    assert(name, "there's no name of Component.")
    local obj = {}

    obj._name = name

    return setmetatable(obj, { __index = Component })
end


return Component
