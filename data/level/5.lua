local MANAGER_TAG = require('data.manager_tag')
local hex2tbl     = require('lib.lume').color
local deep_orange = require('data.color_palette').deep_orange
local cyan        = require('data.color_palette').cyan

return {
    {
        { 'position', 0, 0 },
        { 'size', 1280, 720 },
        { 'color', { hex2tbl(deep_orange['50'] .. '00') } },
        { 'rectangle' },
        { 'animator', 'color', {
          { 1, { a = 1 } },
          }
        },
    },
    {
        { 'position', 840, 0 },
        { 'size', 440, 720 },
        { 'color', { hex2tbl(deep_orange['300'] .. '00') } },
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
        { 'position', 440, 680 },
        { 'size', 400, 40 },
        { 'color', { hex2tbl(deep_orange['300'] .. '00') } },
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
        { 'position', 0, 0 },
        { 'size', 440, 720 },
        { 'color', { hex2tbl(deep_orange['300'] .. '00') } },
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
        { 'position', 440, 680 },
        { 'size', 400, 40 },
        { 'color', { hex2tbl(deep_orange['300'] .. '00') } },
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
        { 'position', 440, 580 },
        { 'size', 140, 20 },
        { 'color', { hex2tbl(deep_orange['300'] .. '00') } },
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
        { 'position', 440, 400 },
        { 'size', 140, 20 },
        { 'color', { hex2tbl(deep_orange['300'] .. '00') } },
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
        { 'position', 440, 200 },
        { 'size', 140, 20 },
        { 'color', { hex2tbl(deep_orange['300'] .. '00') } },
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
        { 'position', 700, 480 },
        { 'size', 140, 20 },
        { 'color', { hex2tbl(deep_orange['300'] .. '00') } },
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
        { 'position', 700, 300 },
        { 'size', 140, 20 },
        { 'color', { hex2tbl(deep_orange['300'] .. '00') } },
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
        { 'bubble_factory',
          { occurrence = 0.03, size_max = 30, size_min = 5 } },
    },
    {
        _delay = 1.5,
        { 'position', 780, 620 },
        { 'radius', 26 },
        { 'color', { hex2tbl(deep_orange['500'] .. '00') } },
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
        { 'position', 500, 120 },
        { 'radius', 10 },
        { 'color', { hex2tbl(cyan['300'] .. '00') } },
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
