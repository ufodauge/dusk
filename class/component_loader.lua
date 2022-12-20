--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local TAG_DEFAULT = 'default'


--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local LuiDebug   = require('lib.luidebug'):getInstance()
local GameObject = require('class.gameobject')
local Flux       = require('lib.flux')


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
---@field instances           table<string, GameObject[]>
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
        local delay = data._delay
        local tag = data._tag or TAG_DEFAULT
        game_object.id = data._id or '_'

        -- add components
        --------------------------------------------------------------
        if delay then
            Flux.to({}, delay, {}):oncomplete(function()
                self:_addComponents(game_object, data)
            end)
        else
            self:_addComponents(game_object, data)
        end

        self.instances[tag] = self.instances[tag] or {}
        self.instances[tag][#self.instances[tag] + 1] = game_object

    end

    self.loaded = true
end


function ComponentLoader:_addComponents(game_object, data)
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
end


---@param tag? string
---@return GameObject[]
function ComponentLoader:getInstances(tag)
    self:_load()
    tag = tag or TAG_DEFAULT
    if self.instances[tag] then
        return self.instances[tag]
    end
    return {}
end


---@return ComponentLoader
function ComponentLoader.new(filepath)
    local obj = {}

    obj.scene_based_objects = {}
    obj.instances           = {}
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
