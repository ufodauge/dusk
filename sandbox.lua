local _depth = 0
---dump table structure
---@param orig any
---@return string
local function dump(orig)
    if type(orig) == "table" then

        local result = "{"
        _depth = _depth + 1

        for key, value in pairs(orig) do
            if type(key) ~= "number" then key = "'" .. key .. "'" end
            result = result .. ("\n%s[%s] = %s,"):format(
                string.rep(" ", _depth * 2),
                key,
                dump(value))
        end

        _depth = _depth - 1
        return result .. ("\b\n%s}"):format(string.rep(" ", _depth * 2))

    else

        return tostring(orig)

    end
end

local SampleClass = {}

function SampleClass.new()
    return setmetatable(
        { 1, 2 },
        {
            __index = SampleClass
        })
end

function SampleClass:delete()
    print(self)
    self = nil
end

local f1 = SampleClass.new()

print(dump(f1))

f1:delete()

print(dump(f1))
