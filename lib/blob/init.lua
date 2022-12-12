--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lp = love.physics
local lg = love.graphics


--------------------------------------------------------------
-- constants
--------------------------------------------------------------
local NODE_RADIUS = 8


---@class Blob
---@field kernel_body love.Body
---@field kernel_fixture love.Fixture
---@field nodes {body: love.Body, fixture: love.Fixture, joint_to_kernel: love.Joint, joint_to_node: love.Joint}
local Blob = {}


function Blob:update()
end


---@param debug boolean?
function Blob:draw(debug)
    if debug then
        for _, node in ipairs(self.nodes) do
            lg.circle(
                'line',
                node.body:getX(),
                node.body:getY(),
                NODE_RADIUS)
        end
        love.graphics.setColor(1, 0.5, 0.5)
        lg.circle(
            'line',
            self.kernel_body:getX(),
            self.kernel_body:getY(),
            NODE_RADIUS)
        love.graphics.setColor(1, 1, 1)
    end
end


---comment
function Blob:destroy()
    for i = 1, #self.nodes do
        --? joint の破棄は勝手にされてた
        self.nodes[i].fixture:destroy()
        self.nodes[i].body:destroy()
    end
    self.kernel_fixture:destroy()
    self.kernel_body:destroy()
end


---comment
---@param world love.World
---@param x number
---@param y number
---@param r number radius
---@param s number?
---@param t any?
function Blob.new(world, x, y, r, s, t)
    local obj = {}

    local kernel_body    = lp.newBody(world, x, y, 'dynamic')
    local kernel_shape   = lp.newCircleShape(r / 4)
    local kernel_fixture = lp.newFixture(kernel_body, kernel_shape)

    -- kernelfixture:setMask(1)

    local node_shape = lp.newCircleShape(NODE_RADIUS)
    local node_count = r / 2

    local nodes = {}

    for i = 1, node_count do
        local angle = (2 * math.pi) * i / node_count

        local node_x = x + r * math.cos(angle)
        local node_y = y + r * math.sin(angle)

        local node_body = lp.newBody(world, node_x, node_y, 'dynamic')
        node_body:setAngularDamping(50)

        local node_fixture = lp.newFixture(node_body, node_shape)
        node_fixture:setFriction(30)
        node_fixture:setRestitution(0)
        -- node_fixture:setUserData(i)

        local node_joint = lp.newDistanceJoint(
            kernel_body, node_body, node_x, node_y, node_x, node_y, false)
        node_joint:setDampingRatio(0.1)
        node_joint:setFrequency(12 * (20 / r))

        table.insert(nodes, {
            body            = node_body,
            fixture         = node_fixture,
            -- joint_to_kernel = node_joint,
            -- joint_to_node   = nil,
        })
    end

    for i = 1, #nodes do
        local j = (i % #nodes) + 1
        -- discard
        local joint = lp.newDistanceJoint(
            nodes[i].body,
            nodes[j].body,
            nodes[i].body:getX(),
            nodes[i].body:getY(),
            nodes[j].body:getX(),
            nodes[j].body:getY(),
            false)
        -- nodes[i].joint_to_node = joint
    end

    -- --set tesselation and smoothing
    -- local smooth = s or 2

    -- local tess = t or 4
    -- self.tess = {}
    -- for i = 1, tess do
    --     self.tess[i] = {}
    -- end

    obj.kernel_body = kernel_body
    obj.kernel_fixture = kernel_fixture
    obj.nodes = nodes

    return setmetatable(obj, { __index = Blob })
end


return Blob
