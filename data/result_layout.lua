local hex2tbl = require('lib.lume').color
local pink    = require('data.color_palette').pink
local indigo  = require('data.color_palette').indigo

return {
    {
        _id = 'timer',
        { 'position', 750, 530 },
        { 'rotation', -math.pi / 16 },
        { 'color', { hex2tbl('#12121200') } },
        { 'text', '%02d:%02d.%02d', 'timeburnerbold', 128 },
        { 'timer' },
        { 'animator', 'color', {
            { 1, { a = 1 }, nil, 1 },
          }
        },
        { 'animator', 'position', {
            { 0, { x = 350 } },
            { 2, nil, 'quadout', 1 },
          }
        },
    },
    {
        { 'position', 850, 680 },
        { 'color', { hex2tbl('#12121200') } },
        { 'text', '__action__ : stage select', 'timeburnerbold', 28 },
        { 'variable_controller_ui' },
        { 'controller_on_result' },
        { 'animator', 'color', {
            { 0.5, { a = 1 }, nil, 3 },
          }
        },
    }
}
