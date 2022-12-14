local hex2tbl = require('lib.lume').color
local palette = require('data.color_palette')

return {
    {
        {
            _name = 'color',
            { hex2tbl(palette.pink['50']) }
        },
        {
            _name = 'background'
        },
        -- bg_particle = {}
    },
    {
        {
            _name = 'color',
            { hex2tbl(palette.pink['500']) }
        },
        {
            _name = 'blob',
            640, 300, 24
        },
        {
            _name = 'player',
        },
        {
            _name = 'player_ui',
        },
    },
    {
        {
            _name = 'color',
            { hex2tbl(palette.pink['300']) }
        },
        {
            _name = 'block',
            0, 0, 40, 720
        },
    },
    {
        {
            _name = 'color',
            { hex2tbl(palette.pink['300']) }
        },
        {
            _name = 'block',
            40, 680, 1200, 40
        },
    },
    {
        {
            _name = 'color',
            { hex2tbl(palette.pink['300']) }
        },
        {
            _name = 'block',
            1240, 0, 40, 720
        },
    },
}
