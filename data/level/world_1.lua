local hex2tbl = require('lib.lume').color
local blue_gray = require('data.color_palette').blue_gray
local orange = require('data.color_palette').deep_orange

return {
    {
        { 'position', 0, 0 },
        { 'size', 1280, 720 },
        { 'color', { hex2tbl(blue_gray['50']) } },
        { 'rectangle' },
    },
    {
        { 'position', -40, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(blue_gray['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    {
        { 'position', 0, 680 },
        { 'size', 1280, 40 },
        { 'color', { hex2tbl(blue_gray['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    {
        { 'position', 1280, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(blue_gray['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    -- door
    {
        { 'position', 400, 600 },
        { 'radius', 10 },
        { 'rotation', 0 },
        { 'color', { hex2tbl(orange['300']) } },
        { 'circle' },
        { 'ball', true },
        { 'door', 1 },
        { 'lighting', 3.0 }
    },
    {
        { 'position', 160, 450 },
        { 'radius', 26 },
        { 'color', { hex2tbl(blue_gray['500']) } },
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
