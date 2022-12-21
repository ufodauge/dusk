# スレッド

## 基本的な使い方

```lua
-- 本来はファイル自体を渡すものだが、
-- このようにコードを直接書き込むこともできる
local threadCode = [[
-- thread:start の引数から受け取った値を渡す
local min, max = ...

for i = min, max do
    -- チャンネルはメインスレッドとこのスレッドで通信を行うもの
    -- メインループのイテレーション一回ごとにメッセージを一つプッシュする
    -- このメッセージはメインスレッドで受け取ることができる
    love.thread.getChannel( 'info' ):push( i )
end
]]

local thread -- スレッドオブジェクト
local timer  -- タイマー

function love.load()
    thread = love.thread.newThread(threadCode)
    thread:start(99, 1000)
end


function love.update(dt)
    timer = timer and timer + dt or 0

    -- エラーハンドリング
    local error = thread:getError()
    assert(not error, error)
end


function love.draw()
    -- メインスレッドが阻害されていないことを示すため、
    -- 円を滑らかに描画する
    love.graphics.circle('line', 100 + math.sin(timer) * 20, 100 + math.cos(timer) * 20, 20)

    -- "info" チャンネルからメッセージをポップする
    local info = love.thread.getChannel('info'):pop()
    if info and love.keyboard.isDown("a") then
        love.graphics.print(info, 10, 10)
    end
end
```




