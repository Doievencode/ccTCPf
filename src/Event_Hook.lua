--[[License

The MIT License (MIT)

Copyright (c) 2015 ccTCP Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

--]]

local listeners = {}
local lastkey = 0
function insertListener(func)
    listeners[lastkey+1] = func
    lastkey = lastkey + 1
    return lastkey -1
end
function removeListener(index)
    listeners[index] = nil
end

local ospulleventbackup
function activate()
    ospulleventbackup = os.pullEvent
    os.pullEvent = function(...)
        local result = {ospulleventbackup(...)}
        for k,v in pairs(listeners) do
            v(unpack(result))
        end
        return unpack(result)
    end
end
function deactivate()
    os.pullEvent = ospulleventbackup
end

--auto enable
activate()
