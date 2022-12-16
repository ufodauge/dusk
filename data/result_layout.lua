local hex2tbl = require('lib.lume').color
local pink = require('data.color_palette').pink
local indigo = require('data.color_palette').indigo

return {
    {
        { 'position', 600, 830 },
        { 'rotation', -math.pi / 14 },
        { 'color', { hex2tbl('#121212') } },
        { 'text', '%02d:%02d.%02d', 'timeburnerbold', 96 },
        { 'timer' }
    },
}
