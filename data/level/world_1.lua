local hex2tbl = require('lib.lume').color
local palette = require('data.color_palette')

return {
    {
        { 'position', 0, 0 },
        { 'size', 1280, 720 },
        { 'color', { hex2tbl(palette.pink['50']) } },
        { 'rectangle' },
    },
    {
        { 'position', 0, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(palette.pink['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    {
        { 'position', 40, 680 },
        { 'size', 1200, 40 },
        { 'color', { hex2tbl(palette.pink['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
    },
    {
        { 'position', 1240, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(palette.pink['300']) } },
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
        { 'color', { hex2tbl(palette.pink['500']) } },
        { 'blob' },
        { 'shadow_body' },
        { 'player', },
        { 'player_ui', },
    },
    {
        { 'position', -75, -100 },
        { 'radius', 1200 },
        { 'color', { hex2tbl("#FDFDFB") } },
        { 'lighting' }
    }
}
