local SZ = 3
local EMPTY = "\n"

local preWords = {}

function initPreWords()
	for i = 1, SZ do
		preWords[i] = EMPTY
	end
end

function insertPreWords(wd)
	table.remove(preWords, 1)
	table.insert(preWords, wd)
end

function getPrefix()
	return table.concat(preWords, " ")
end

local mc = {}
function insert(value)
	local prefix = getPrefix()
	if mc[prefix] == nil then
		mc[prefix] = {}
	end
	table.insert(mc[prefix], value)
end

function getNext(prefix)
	--print(prefix)
	local v = mc[prefix]
	local k = math.random(#v)
	return v[k]
end
 
function readLine()
	initPreWords()
	for line in io.lines("in.txt") do
		for w in string.gmatch(line, "%w+[,.:;]?") do
			insert(w)
			insertPreWords(w)
		end
	end
	insert(EMPTY)
end

function generator()
	initPreWords()
	local pre = getPrefix()
	while true do
		local v = getNext(pre)
		--print("debug" , pre, v)
		if(v == EMPTY) then break end
		io.write(v, " ")
		insertPreWords(v)
		pre = getPrefix()
	end
end

readLine()
generator()
