local hex2tbl = require('lib.lume').color
local green = require('data.color_palette').green
local orange = require('data.color_palette').deep_orange

return {
    {
        { 'position', 0, 0 },
        { 'size', 1280, 720 },
        { 'color', { hex2tbl(green['50']) } },
        { 'rectangle' },
    },
    {
        { 'position', -40, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(green['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    {
        { 'position', 0, 680 },
        { 'size', 1280, 40 },
        { 'color', { hex2tbl(green['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    {
        { 'position', 1280, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(green['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    -- door
    {
        { 'position', 200, 660 },
        { 'radius', 40 },
        { 'color', { hex2tbl(orange['300']) } },
        { 'rectangle' },
        { 'door', 1 }
    },
    {
        { 'position', 160, 450 },
        { 'radius', 26 },
        { 'color', { hex2tbl(green['500']) } },
        { 'blob' },
        { 'shadow_body' },
        { 'player', },
        { 'player_ui', },
    },
    {
        { 'position', -75, -100 },
        { 'radius', 1200 },
        { 'color', { hex2tbl('#FDFDFB') } },
        { 'lighting' }
    }
}
