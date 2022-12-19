---@class GameObjectManager
---@field instances GameObject[]
local GameObjectManager = {}


---@param dt number
function GameObjectManager:update(dt)
    for i = #self.instances, 1, -1 do
        self.instances[i]:update(dt)
        if not self.instances[i] then
            break
        end
        if self.instances[i].dead then
            self.instances[i]:delete()
            table.remove(self.instances, i)
        end
    end
end


function GameObjectManager:draw()
    for i = 1, #self.instances do
        if self.instances[i] then
            self.instances[i]:draw()
        end
    end
end


function GameObjectManager:delete()
    for i = #self.instances, 1, -1 do
        if self.instances[i].delete then
            self.instances[i]:delete()
        end
        self.instances[i] = nil
    end
end


---@param id string
---@return GameObject|nil
function GameObjectManager:getObjectById(id)
    for i = #self.instances, 1, -1 do
        if self.instances[i].id == id then
            return self.instances[i]
        end
    end
    return nil
end


---@param instances GameObject[]
---@return GameObjectManager
function GameObjectManager.new(instances)
    local obj = {}

    obj.instances = instances

    return setmetatable(obj, { __index = GameObjectManager })
end


return GameObjectManager
