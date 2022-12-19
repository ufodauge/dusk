local hex2tbl = require('lib.lume').color
local pink    = require('data.color_palette').pink
local indigo  = require('data.color_palette').indigo

return {
    {
        _id = 'timer',
        { 'position', 750, 530 },
        { 'rotation', -math.pi / 16 },
        { 'color', { hex2tbl('#121212') } },
        { 'text', '%02d:%02d.%02d', 'timeburnerbold', 128 },
        { 'timer' }
    },
    {
        { 'position', 850, 680 },
        { 'color', { hex2tbl('#121212') } },
        { 'text', '__action__ : stage select', 'timeburnerbold', 28 },
        { 'variable_controller_ui' },
        { 'controller_on_result' },
    }
}
