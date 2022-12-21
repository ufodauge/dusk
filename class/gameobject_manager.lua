---@class GameObjectManager
---@field instances GameObject[]
---@field tag ManagerTag
local GameObjectManager = {}

local managers = {}


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

    managers[self.tag] = nil
end


---@param tag ManagerTag
---@return GameObjectManager|nil
function GameObjectManager:getManager(tag)
    if managers[tag] then
        return managers[tag]
    else
        print(("there's no manager of tag '%s'"):format(tag))
        return nil
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
    print(("there's no game object of id '%s'"):format(id))
    return nil
end


---@param instances GameObject[]
---@param tag       string|number
---@return GameObjectManager
function GameObjectManager.new(instances, tag)
    if managers[tag] then
        error(("tag %s is already used"):format(tag))
    end

    local obj = {}

    obj.instances = instances
    obj.tag       = tag

    managers[tag] = setmetatable(obj, { __index = GameObjectManager })

    return managers[tag]
end


return GameObjectManager
