--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics
local lm = love.math


local Component = require('class.component')


---@class BubbleFactoryComponent : Component
---@field bubbles    Bubble[]
---@field occurrence number
---@field size_max   number
---@field size_min   number
local BubbleFactoryComponent = setmetatable({}, { __index = Component })


---@param dt number
---@param context Context
function BubbleFactoryComponent:update(dt, context)
    if lm.random() < self.occurrence then
        local x = lm.random(0, lg.getWidth())
        local y = lg.getHeight()
        local size = lm.random(self.size_min, self.size_max)
        local light_body = self.light_world:newLight(
            x, y,
            1, 1, 1,
            size)
        light_body:setGlowSize(0)

        table.insert(
            self.bubbles,
            ---@class Bubble
            ---@field x          integer
            ---@field y          integer
            ---@field dead       boolean
            ---@field light_body boolean
            {
                x = x,
                y = y,
                size = size,
                dead = false,
                light_body = light_body,

                update = function(this)
                    this.y = this.y - 1
                    this.x = this.x + lm.random(-2, 2)

                    if this.y < -50 then
                        this.dead = true
                    end
                end,

                draw = function(this)
                    -- lg.circle('line', this.x, this.y, this.size)
                end
            }
        )
    end

    for i = #self.bubbles, 1, -1 do
        self.bubbles[i]:update()
        self.bubbles[i].light_body:setPosition(
            self.bubbles[i].x,
            self.bubbles[i].y)
        if self.bubbles[i].dead then
            self.light_world:remove(self.bubbles[i].light_body)
            table.remove(self.bubbles, i)
        end
    end
end


---@param context Context
function BubbleFactoryComponent:draw(context)
    -- lg.setColor(1, 1, 1, 1)
    -- for i = 1, #self.bubbles do
    --     self.bubbles[i]:draw()
    -- end
end


function BubbleFactoryComponent:onAdd(context)

end


function BubbleFactoryComponent:setLightWorld(world)
    self.light_world = world
end


function BubbleFactoryComponent:delete()

end


---@param params {occurrence: number, size_max: number, size_min: number}
---@return BubbleFactoryComponent|Component
function BubbleFactoryComponent.new(name, params)
    local obj = Component.new(name)

    for key, value in pairs(params) do
        obj[key] = value
    end
    obj.bubbles = {}

    local mt = getmetatable(obj)
    mt.__index = BubbleFactoryComponent
    return setmetatable(obj, mt)
end


return BubbleFactoryComponent
