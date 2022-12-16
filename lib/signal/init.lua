---@class Signal
local Signal = {}

local channel = {}

---@param ch string
---@param ... any
function Signal.send(ch, ...)
    channel[ch] = channel[ch] or {}
    for _, func in pairs(channel[ch]) do
        func(...)
    end
end


---@param ch string
---@param func function
function Signal.subscribe(ch, func)
    channel[ch] = channel[ch] or {}
    channel[ch][func] = func
end


---@param ch string
---@param func function
function Signal.unsubscribe(ch, func)
    channel[ch][func] = nil
end


return Signal
