local EVENT_NAME = require('data.event_name')
local LEVEL_TAG  = require('data.level_tag')
local hex2tbl    = require('lib.lume').color
local blue_gray  = require('data.color_palette').blue_gray
local orange     = require('data.color_palette').deep_orange
local lg         = love.graphics

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
        { 'position', -40, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(blue_gray['300'] .. '00') } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'animator', 'position', {
            { 0, { y = -300 } },
            { 1.5, nil },
          }
        },
    },
    {
        { 'position', 0, 680 },
        { 'size', 1280, 40 },
        { 'color', { hex2tbl(blue_gray['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
        { 'animator', 'position', {
            { 0, { y = -300 } },
            { 1.5, nil },
          }
        },
    },
    {
        { 'position', 1280, 0 },
        { 'size', 40, 720 },
        { 'color', { hex2tbl(blue_gray['300']) } },
        { 'rectangle' },
        { 'block' },
        { 'shadow_body' },
        { 'animator', 'position', {
            { 0, { y = -300 } },
            { 1.5, nil },
          }
        },
    },
    -- lv 1
    --------------------------------------------------------------
    {
        _delay = 1.5,
        _id = LEVEL_TAG[1],
        { 'position', 340, 630 },
        { 'radius', 20 },
        { 'rotation', 0 },
        { 'color', { hex2tbl(orange['300'] .. '00') } },
        { 'circle' },
        { 'ball', true },
        { 'door', 1 },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'lighting', 3.0 },
    },
    -- lv 2
    --------------------------------------------------------------
    {
        _delay = 1.5,
        _id = LEVEL_TAG[2],
        { 'position', 640, 630 },
        { 'radius', 20 },
        { 'rotation', 0 },
        { 'color', { hex2tbl(orange['300'] .. '00') } },
        { 'circle' },
        { 'ball', true },
        { 'door', 2 },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'lighting', 3.0 },
    },
    -- lv 3
    --------------------------------------------------------------
    {
        _delay = 1.5,
        _id = LEVEL_TAG[3],
        { 'position', 940, 630 },
        { 'radius', 20 },
        { 'rotation', 0 },
        { 'color', { hex2tbl(orange['300'] .. '00') } },
        { 'circle' },
        { 'ball', true },
        { 'door', 3 },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'lighting', 3.0 },
    },
    {
        { 'position', -75, -100 },
        { 'radius', 1200 },
        { 'color', { hex2tbl('#FDFDFB00') } },
        { 'lighting' },
        { 'animator', 'color', {
            { 3, { a = 1 }, nil, 2 },
          }
        },
    },
    {
        _delay = 2,
        { 'position', 160, 450 },
        { 'radius', 26 },
        { 'color', { hex2tbl(blue_gray['500'] .. '00') } },
        { 'blob' },
        { 'shadow_body' },
        { 'animator', 'color', {
            { 1, { a = 1 } },
          }
        },
        { 'player' },
        { 'player_ui' }
    },
    -- pop-up ui
    --------------------------------------------------------------
    {
        { 'position', lg.getWidth() / 2 - 200, lg.getHeight() / 2 - 100 },
        { 'player_tracker', 0, -150 },
        { 'size', 400, 200 },
        { 'color', { hex2tbl('#01010100') } },
        { 'text', '__cancel__: enter the level', 'timeburnerbold', 28 },
        { 'variable_controller_ui' },
        { 'animator', 'color', {
            { 0.3, { a = 1 } }
          },
          EVENT_NAME.PLAYER_GETS_CLOSER_THE_DOOR
        },
        { 'animator', 'color', {
            { 0.3, { a = 0 } }
          },
          EVENT_NAME.PLAYER_LEAVE_FROM_THE_DOOR
        },
    },
    {
        { 'position', 0, 0 },
        { 'size', love.window.getMode() },
        { 'color', { hex2tbl('#00000000') } },
        { 'rectangle' },
        { 'animator', 'color',
          {
            { 0.5, { a = 1 }, nil, 0.5 }
          },
          EVENT_NAME.ENTER_TO_LEVEL
        },
    },
}
