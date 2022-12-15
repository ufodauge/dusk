local hex2tbl = require('lib.lume').color
local pink = require('data.color_palette').pink
local indigo = require('data.color_palette').indigo
local CATEGORY = require('data.box2d_category')

return {
    {
        { 'position', 0, 0 },
        { 'size', 1280, 720 },
        { 'color', { hex2tbl(pink['50']) } },
        { 'rectangle' },
    },
    {
        { 'position', 0, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(pink['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    {
        { 'position', 40, 680 },
        { 'size', 1200, 40 },
        { 'color', { hex2tbl(pink['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    {
        { 'position', 1240, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(pink['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    {
        { 'bubble_factory',
          { occurrence = 0.03, size_max = 30, size_min = 5 } },
    },
    {
        { 'position', 160, 450 },
        { 'radius', 26 },
        { 'color', { hex2tbl(pink['500']) } },
        { 'blob', false },
        { 'shadow_body' },
        { 'player', },
        { 'player_ui', },
    },
    {
        { 'position', 1000, 500 },
        { 'radius', 10 },
        { 'color', { hex2tbl(indigo['300']) } },
        { 'circle' },
        { 'ball', true },
        { 'goal' },
        { 'lighting', 3.0 }
    },
    {
        { 'position', -75, -100 },
        { 'radius', 1200 },
        { 'color', { hex2tbl('#FDFDFB') } },
        { 'lighting' }
    },
}
