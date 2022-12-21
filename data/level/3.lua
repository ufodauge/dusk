local MANAGER_TAG = require('data.manager_tag')
local hex2tbl     = require('lib.lume').color
local cyan        = require('data.color_palette').cyan
local amber       = require('data.color_palette').amber

return {
    {
        { 'position', 0, 0 },
        { 'size', 1280, 720 },
        { 'color', { hex2tbl(cyan['50'] .. '00') } },
        { 'rectangle' },
        { 'animator', 'color', {
          { 1, { a = 1 } },
          }
        },
    },
    {
        { 'position', 0, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(cyan['300'] .. '00') } },
        { 'rectangle' },
        { 'block' },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'animator', 'position', {
            { 0, { y = -300 } },
            { 1, nil },
          }
        },
        { 'shadow_body' },
    },
    {
        { 'position', 1240, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(cyan['300'] .. '00') } },
        { 'rectangle' },
        { 'block' },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'animator', 'position', {
            { 0, { y = -300 } },
            { 1, nil },
          }
        },
        { 'shadow_body' },
    },
    --------------------------------------------------------------
    {
        { 'position', 40, 320 },
        { 'size', 400, 400 },
        { 'color', { hex2tbl(cyan['300'] .. '00') } },
        { 'rectangle' },
        { 'block' },
        { 'moving_platform', 0, 200, 8, true },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'animator', 'position', {
            { 0, { y = -300 } },
            { 1, nil },
          }
        },
        { 'shadow_body' },
    },
    {
        { 'position', 840, 320 },
        { 'size', 400, 400 },
        { 'color', { hex2tbl(cyan['300'] .. '00') } },
        { 'rectangle' },
        { 'block' },
        { 'moving_platform', 0, 200, 8, true },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'animator', 'position', {
            { 0, { y = -300 } },
            { 1, nil },
          }
        },
        { 'shadow_body' },
    },
    {
        { 'position', 440, 520 },
        { 'size', 400, 400 },
        { 'color', { hex2tbl(cyan['300'] .. '00') } },
        { 'rectangle' },
        { 'block' },
        { 'moving_platform', 0, -200, 8, true },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'animator', 'position', {
            { 0, { y = -300 } },
            { 1, nil },
          }
        },
        { 'shadow_body' },
    },
    --------------------------------------------------------------
    {
        { 'bubble_factory',
          { occurrence = 0.03, size_max = 30, size_min = 5 } },
    },
    {
        _delay = 1.5,
        { 'position', 220, 240 },
        { 'radius', 26 },
        { 'color', { hex2tbl(cyan['500'] .. '00') } },
        { 'blob' },
        { 'shadow_body' },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'player', },
        { 'player_ui', },
    },
    {
        { 'position', 1060, 240 },
        { 'radius', 10 },
        { 'color', { hex2tbl(amber['300'] .. '00') } },
        { 'circle' },
        { 'ball', true },
        { 'goal' },
        { 'lighting', 3.0 },
        { 'animator', 'color', {
            { 3, { a = 1 }, nil, 2 },
          }
        },
    },
    {
        { 'position', -75, -100 },
        { 'radius', 1200 },
        { 'color', { 0, 0, 0, 1 } },
        { 'lighting' },
        { 'animator', 'color', {
            { 3, { r = 1, g = 1, b = 1 }, nil, 2 },
          }
        },
    },
    {
        _delay = 1.5,
        _id    = 'timer',
        _tag   = MANAGER_TAG.HUD,
        { 'position', 1100, 30 },
        { 'color', { hex2tbl('#12121200') } },
        { 'text', '%02d:%02d.%02d', 'timeburnerbold', 20 },
        { 'timer' },
        { 'animator', 'color', {
            { 3, { a = 1 } },
          }
        },
    },
}
