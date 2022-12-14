--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics
local lm = love.math


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local PARTICLE_RATE_PER_FRAME = 0.06
local PARTICLE_RADIUS = 3


local Component = require('class.component')


---@class BGParticleComponent : Component
---@field particle_type string
---@field particles Particles[]
local BGParticleComponent = setmetatable({}, { __index = Component })


---@param dt number
---@param context Context
function BGParticleComponent:update(dt, context)
    if lm.random() < PARTICLE_RATE_PER_FRAME then
        table.insert(
            self.particles,
            ---@class Particles
            ---@field x    integer
            ---@field y    integer
            ---@field dead boolean
            {
                x = lm.random(0, lg.getWidth()),
                y = lg.getHeight(),
                dead = false,
                update = function(self)
                    self.y = self.y - 1
                    self.x = self.x + lm.random(-2, 2)
                    if self.y < -10 then
                        self.dead = true
                    end
                end,
                draw = function(self)
                    lg.circle('line', self.x, self.y, PARTICLE_RADIUS)
                end
            }
        )
    end

    for i = #self.particles, 1, -1 do
        self.particles[i]:update()
        if self.particles[i].dead then
            table.remove(self.particles, i)
        end
    end
end


---@param context Context
function BGParticleComponent:draw(context)
    lg.setColor(1, 1, 1, 1)
    for i = 1, #self.particles do
        self.particles[i]:draw()
    end
end


function BGParticleComponent:onAdd(context)

end


function BGParticleComponent:delete()

end


---@param particle_type string
---@return BGParticleComponent|Component
function BGParticleComponent.new(particle_type)
    local obj = Component.new()

    obj.particle_type = particle_type
    obj.particles = {}

    local mt = getmetatable(obj)
    mt.__index = BGParticleComponent
    return setmetatable(obj, mt)
end


return BGParticleComponent
