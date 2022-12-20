local str = '#afaa65'

local r, g, b, a
r, g, b, a = str:gmatch('#(%x%x)(%x%x)(%x%x)')

print(r, g, b, a)
