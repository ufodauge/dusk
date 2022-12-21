local hex2tbl    = require('lib.lume').color
local EVENT_NAME = require('data.event_name')

return {
    {
        _id = 'timer',
        { 'position', 750, 530 },
        { 'rotation', -math.pi / 16 },
        { 'color', { hex2tbl('#12121200') } },
        { 'text', '%02d:%02d.%02d', 'timeburnerbold', 128 },
        { 'timer' },
        { 'animator', 'color', {
            { 0.6, { a = 1 }, nil, 1 },
          }
        },
        { 'animator', 'color', {
            { 0.5, { a = 0 } }
          },
          EVENT_NAME.RETURN_TO_STAGE_SELECT
        },
        { 'animator', 'position', {
            { 0, { x = 350 }, nil, 1 },
            { 0.6, nil, 'quadout' },
          }
        },
    },
    -- results
    --------------------------------------------------------------
    {
        _id = 'leaderboard_rank_1',
        { 'position', 350, 180 },
        { 'color', { hex2tbl('#12121200') } },
        { 'text', '1st: %02d:%02d.%02d', 'timeburnerbold', 28 },
        { 'leaderboard', 1 },
        { 'animator', 'color', {
            { 0.5, { a = 1 }, nil, 1 }
          }
        },
        { 'animator', 'color', {
            { 0.5, { a = 0 } }
          },
          EVENT_NAME.RETURN_TO_STAGE_SELECT
        },
        { 'animator', 'position', {
            { 0.6, { x = 600 }, nil, 1 }
          }
        }
    },
    {
        _id = 'leaderboard_rank_2',
        { 'position', 350, 240 },
        { 'color', { hex2tbl('#12121200') } },
        { 'text', '2nd: %02d:%02d.%02d', 'timeburnerbold', 28 },
        { 'leaderboard', 2 },
        { 'animator', 'color', {
            { 0.5, { a = 1 }, nil, 1 }
          }
        },
        { 'animator', 'color', {
            { 0.5, { a = 0 } }
          },
          EVENT_NAME.RETURN_TO_STAGE_SELECT
        },
        { 'animator', 'position', {
            { 0.6, { x = 620 }, nil, 1.1 }
          }
        }
    },
    {
        _id = 'leaderboard_rank_3',
        { 'position', 350, 300 },
        { 'color', { hex2tbl('#12121200') } },
        { 'text', '3rd: %02d:%02d.%02d', 'timeburnerbold', 28 },
        { 'leaderboard', 3 },
        { 'animator', 'color', {
            { 0.5, { a = 1 }, nil, 1 }
          }
        },
        { 'animator', 'color', {
            { 0.5, { a = 0 } }
          },
          EVENT_NAME.RETURN_TO_STAGE_SELECT
        },
        { 'animator', 'position', {
            { 0.6, { x = 640 }, nil, 1.2 }
          }
        }
    },
    {
        _id = 'leaderboard_rank_4',
        { 'position', 350, 360 },
        { 'color', { hex2tbl('#12121200') } },
        { 'text', '4th: %02d:%02d.%02d', 'timeburnerbold', 28 },
        { 'leaderboard', 4 },
        { 'animator', 'color', {
            { 0.5, { a = 1 }, nil, 1 }
          }
        },
        { 'animator', 'color', {
            { 0.5, { a = 0 } }
          },
          EVENT_NAME.RETURN_TO_STAGE_SELECT
        },
        { 'animator', 'position', {
            { 0.6, { x = 660 }, nil, 1.3 }
          }
        }
    },
    {
        _id = 'leaderboard_rank_5',
        { 'position', 350, 420 },
        { 'color', { hex2tbl('#12121200') } },
        { 'text', '5th: %02d:%02d.%02d', 'timeburnerbold', 28 },
        { 'leaderboard', 5 },
        { 'animator', 'color', {
            { 0.5, { a = 1 }, nil, 1 }
          }
        },
        { 'animator', 'color', {
            { 0.5, { a = 0 } }
          },
          EVENT_NAME.RETURN_TO_STAGE_SELECT
        },
        { 'animator', 'position', {
            { 0.6, { x = 680 }, nil, 1.4 }
          }
        }
    },

    -- return to stage select
    --------------------------------------------------------------
    {
        _delay = 3,
        { 'position', 850, 680 },
        { 'color', { hex2tbl('#12121200') } },
        { 'text', '__action__ : stage select', 'timeburnerbold', 28 },
        { 'variable_controller_ui' },
        { 'controller_on_result' },
        { 'animator', 'color', {
            { 0.5, { a = 1 } }
          }
        },
        { 'animator', 'color', {
            { 0.5, { a = 0 } }
          },
          EVENT_NAME.RETURN_TO_STAGE_SELECT
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
          EVENT_NAME.RETURN_TO_STAGE_SELECT
        },
    }
}
