---@class GameObject
---@field private components Component[]
local GameObject = {}

---@param component Component
---@param name      string
function GameObject:addComponent(component, name)
    component.name = name
    table.insert(self.components, component)
end


---@param dt number
function GameObject:update(dt)
    for _, component in ipairs(self.components) do
        component:update(dt, self.components)
    end
end


function GameObject:draw()
    for _, component in ipairs(self.components) do
        if component then
            component:draw(self.components)
        end
    end
end


function GameObject:delete()
    for i = 1, #self.components do
        self.components[i]:delete()
        self.components[i] = nil
    end
end


function GameObject.new()
    local obj = {} --[[@as GameObject]]

    ---@class Context
    obj.components = {}

    ---@param comp_name string
    function obj.components:get(comp_name)
        for i = 1, #obj.components do
            if obj.components[i].name == comp_name then
                return obj.components[i]
            end
        end
    end


    return setmetatable(obj, { __index = GameObject })
end


return GameObject
