local Component = require('class.component')

---@class ImageComponent : Component
local ImageComponent = setmetatable({}, { __index = Component })

---@param context Context
function ImageComponent:onAdd(context)

end


function ImageComponent:delete()

end


---@return Component
function ImageComponent.new(name, filepath)
    local obj = Component.new(name)

    local mt = getmetatable(obj)
    mt.__index = ImageComponent
    return setmetatable(obj, mt)
end


return ImageComponent
