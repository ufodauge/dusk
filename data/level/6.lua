local MANAGER_TAG = require('data.manager_tag')
local hex2tbl     = require('lib.lume').color
local blue_gray   = require('data.color_palette').blue_gray
local green       = require('data.color_palette').green

return {
    {
        { 'position', 0, 0 },
        { 'size', 1280, 720 },
        { 'color', { hex2tbl(blue_gray['50'] .. '00') } },
        { 'rectangle' },
        { 'animator', 'color', {
          { 1, { a = 1 } },
          }
        },
    },
    {
        { 'position', 0, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(blue_gray['300'] .. '00') } },
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
        { 'position', 40, 680 },
        { 'size', 1200, 40 },
        { 'color', { hex2tbl(blue_gray['300'] .. '00') } },
        { 'rectangle' },
        { 'block' },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'animator', 'position', {
            { 0, { y = 380 } },
            { 1, nil },
          }
        },
        { 'shadow_body' },
    },
    {
        { 'position', 1240, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(blue_gray['300'] .. '00') } },
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
        { 'position', 520, 560 },
        { 'size', 200, 40 },
        { 'color', { hex2tbl(blue_gray['300'] .. '00') } },
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
        { 'position', 220, 440 },
        { 'size', 200, 40 },
        { 'color', { hex2tbl(blue_gray['300'] .. '00') } },
        { 'rectangle' },
        { 'block' },
        { 'moving_platform', 600, 0, 8, true },
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
        { 'position', 820, 320 },
        { 'size', 200, 40 },
        { 'color', { hex2tbl(blue_gray['300'] .. '00') } },
        { 'rectangle' },
        { 'block' },
        { 'moving_platform', -600, 0, 8, true },
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
        { 'position', 220, 200 },
        { 'size', 200, 40 },
        { 'color', { hex2tbl(blue_gray['300'] .. '00') } },
        { 'rectangle' },
        { 'block' },
        { 'moving_platform', 600, 0, 8, true },
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
        { 'position', 160, 580 },
        { 'radius', 26 },
        { 'color', { hex2tbl(blue_gray['500'] .. '00') } },
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
        { 'position', 1120, 100 },
        { 'radius', 10 },
        { 'color', { hex2tbl(green['300'] .. '00') } },
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
