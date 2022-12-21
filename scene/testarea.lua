--------------------------------------------------------------
-- requires
--------------------------------------------------------------
local lume = require('lib.lume')


--------------------------------------------------------------
-- shorthands
--------------------------------------------------------------
local lg = love.graphics
local lm = love.mouse


local rectangles = {}
local circles    = {}

---@enum KeyState
local KEY_STATE = {
    RELEASED = 0,
    PRESSED  = 1,
}

local state = {
    counter = -60,
    dragging = false,
    draw_mode = 'rectangle'
}

local grid_size = 20
local grid_cursor_points = {
    x = 0,
    y = 0
}
local cursor_points = {
    x = 0,
    y = 0
}
local drawing_points = {}
local log = {}

--------------------------------------------------------------
-- testarea
--------------------------------------------------------------
local testarea = {}

function testarea:enter()
    rectangles = {}
    circles    = {}
end


function testarea:update(dt)
    if lm.isDown(1) then
        state.counter = state.counter <= 0
            and math.min(state.counter + 1, 60)
            or 1
    else
        state.counter = state.counter > 0
            and math.max(state.counter - 1, -60)
            or 0
    end

    -- example:
    --   if state.counter == KEY_STATE.PRESSED  then ... end
    --   if state.counter == KEY_STATE.RELEASED then ... end

    cursor_points.x, cursor_points.y = lm.getPosition()
    grid_cursor_points.x = math.ceil((cursor_points.x - grid_size / 2) / grid_size) * grid_size
    grid_cursor_points.y = math.ceil((cursor_points.y - grid_size / 2) / grid_size) * grid_size

    if state.counter == KEY_STATE.PRESSED then
        lume.push(drawing_points, grid_cursor_points.x, grid_cursor_points.y, 0, 0)
    elseif state.counter > KEY_STATE.PRESSED then
        if state.draw_mode == 'rectangle' then
            drawing_points[3] = grid_cursor_points.x
            drawing_points[4] = grid_cursor_points.y
        elseif state.draw_mode == 'circle' then
            drawing_points[3] = math.abs(drawing_points.x - grid_cursor_points.x) >
                math.abs(drawing_points.y - grid_cursor_points.y)
                and grid_cursor_points.y
                or grid_cursor_points.x
        end
    elseif state.counter == KEY_STATE.RELEASED then
        if state.draw_mode == 'rectangle' then
            lume.push(
                rectangles,
                lume.clone(drawing_points))
        elseif state.draw_mode == 'circle' then
            lume.push(
                circles,
                lume.clone(drawing_points))
        end
        lume.push(log, state.draw_mode)
    end
end


function testarea:draw()
    lg.setBackgroundColor(lume.color('#FEFEFE'))

    lg.setColor(lume.color('#010101'))
    lg.circle(
        'line',
        grid_cursor_points.x,
        grid_cursor_points.y,
        grid_size / 4)

    lg.setColor(lume.color('#AA33AA'))
    for _, rectangle in ipairs(rectangles) do
        lg.rectangle(
            'line',
            rectangle[1],
            rectangle[2],
            rectangle[3],
            rectangle[4])
    end

    lg.setColor(lume.color('#AAAA33'))
    for _, circle in ipairs(circles) do
        lg.circle(
            'line',
            circle[1],
            circle[2],
            circle[3])
    end
end


function testarea:leave()
end


function testarea:keypressed(key)
    if key == 'z' then
        local latest = table.remove(log)
        if latest == 'rectangle' then
            table.remove(rectangles)
        elseif state.draw_mode == 'circle' then
            table.remove(circles)
        end
    end

    if key == 'a' then
        state.draw_mode = state.draw_mode == 'rectangle'
            and 'circle'
            or 'rectangle'
    end

    if key == 's' then

    end
end


return testarea
