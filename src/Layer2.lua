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

--The checksum is 5 chars long in hex
--utils = require('Utils')

--Init Variables
local mac = {}

--L2:Functions

function fcs(msg)
	local buffer = {msg:byte(1,#msg)}
	local add = 0
	for i,v in pairs(buffer) do
		add = add + v
	end
	return string.rep("0",6-#tostring(add))..tostring(utils.toHex(add))
end

function createMac(side)
	side = tostring(side)
	sideTable = {top = 0,bottom = 1,left = 2,right = 3,back = 4,front = 5}
	if side and sideTable[side] then
		local macBuffer = tostring(utils.toHex(os.computerID() * 6 + sideTable[side]))
		return string.rep("0",12-#macBuffer).. macBuffer
	end
	return error("Failed: "..side.."is not a side", 2)
end

function getMac(side)
	if not mac[side] then
		mac[side] = createMac(side)
	end
	return mac[side]
end

function getMacString(side)
	return utils.toDec(getMac(side))
end

--End: L2:Functions]]

--Post Init Variables
frame = {preamble,dstMac,srcMac,packet or data,fcs}
dotQFrame = {preamble,dstMac,srcMac,vlan,packet or data,fcs}

--Active / Test Code
calc = function()
	print(utils.toHex(255*1518))
end
--End: L2:Active / Test Code]]
