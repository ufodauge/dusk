--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug   = require('lib.luidebug'):getInstance()
local GameObject = require('class.gameobject')


--------------------------------------------------------------
-- Components
--------------------------------------------------------------
local Components = require('lib.cargo').init('components')


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lf = love.filesystem


---@class ComponentLoader
---@field scene_based_objects table<string, any>
---@field components_data     table[]
---@field loaded              boolean
---@field instances           GameObject[]
---@field instances_hud       GameObject[]
local ComponentLoader = {}

function ComponentLoader:setRelationToSceneBasedObject(object, funcname)
    self.scene_based_objects[funcname] = object
end


function ComponentLoader:_load()
    if self.loaded then
        return
    end

    --create objects
    --------------------------------------------------------------
    for _, data in ipairs(self.components_data) do

        -- object
        local game_object = GameObject.new()

        -- add components
        --------------------------------------------------------------
        for _, comp_data in ipairs(data) do

            -- assume comp_data[1] is component name
            --------------------------------------------------------------
            local comp_name = comp_data[1]

            if Components[comp_name] then
                -- create component
                --------------------------------------------------------------
                local comp = Components[comp_name].new(unpack(comp_data))
                game_object:addComponent(comp, comp_name)

                -- relate scene-based objects
                --------------------------------------------------------------
                for funcname, object in pairs(self.scene_based_objects) do
                    if comp[funcname] then
                        comp[funcname](comp, object)
                    end
                end

            else

                LuiDebug:log('Component: ' .. comp_name .. ' has not been found.')

            end
        end

        if data.hud then
            self.instances_hud[#self.instances_hud + 1] = game_object
        else
            self.instances[#self.instances + 1] = game_object
        end
    end

    self.loaded = true
end


function ComponentLoader:getInstances()
    self:_load()
    return self.instances
end


function ComponentLoader:getHUDInstances()
    self:_load()
    return self.instances_hud
end


---@return ComponentLoader
function ComponentLoader.new(filepath)
    local obj = {}

    obj.scene_based_objects = {}
    obj.instances           = {}
    obj.instances_hud       = {}
    obj.loaded              = false

    local chunk, errmsg = lf.load(filepath)
    if errmsg then
        print(errmsg)
    else
        obj.components_data = chunk()
    end

    return setmetatable(obj, { __index = ComponentLoader })
end


return ComponentLoader
