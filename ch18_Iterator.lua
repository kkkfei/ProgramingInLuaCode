print("----------------- iterator ipair ----------------")
--[[
	use coroutine to keep state.
]]
function value(t)
	local i = 0
	return function()
		i = i+1
		local v = t[i]
		if v then
			return i, v
		end
	end
end

t = {"aaa",123, 444}
 
for k, v in value(t) do
	print(k, v)
end

print("----------------- stateless iterator 1 ----------------")
--[[
	use generic for to keep state.
]]
function _value2(t, i)
	i = i + 1
	local v = t[i]
	if v then
		return i, v
	end
end

function value2(t)
	return _value2, t, 0
end

t = {"bbb",123, 444}
 
for k, v in value2(t) do
	print(k, v)
end

print("----------------- stateless iterator 2 ----------------")
lines = {
	["hello"] = 10,
	["ah"] = 3,
	["world"] = 44,
}

function orderLines(t)
	local ot = {}
	for k,v in pairs(t) do
		ot[#ot + 1] = k
	end
	table.sort(ot)
	local i = 0
	return function()
		i = i + 1
		return ot[i]
	end
end

for k in orderLines(lines) do
	print(k)
end

print("----------------- implement pairs----------------")

for k, v in next, lines, nil do
	print(k, v)
end

print("----------------- excerse 18.1 18.2----------------")

function fromto(n, m) 
	local add = n <= m and 1 or -1
	local i = n - add
	
	return function() 
		i = i + add
		if i == m + add then return nil end
		return i
	end
end


function _fromto2(t, v)
	local n = t[1]
	local m = t[2]
	if n < m then
		v = v + 1
		local step = v - n + 1
		if v > m then return nil 
		else return v, step end
	else
		v = v - 1
		local step = n - v + 1
		if v < m then return nil
		else return v, step end
	end
end


function fromto2(n, m)
	local k = n < m and 1 or -1
	return _fromto2, {n,m}, n<m and n-1 or n+1
end

for i,step in fromto2(22, 20) do
	print("step " .. step .. " is " .. i)
end


print("----------------- excerse 18.3 ----------------")
function uniquewords(file)
	local f = io.input(file)
	local content = io.read("a")
	
	local words = {}
	for w in string.gmatch(content, "%w+") do
		words[w] = true
	end
	
	return next, words, nil
end

for wd in uniquewords("in.txt") do
	print(wd)
end

print("----------------- excerse 18.4 ----------------")
function substrings(str)
	local i = 1
	local j = 0
	local n = #str
	return function(s)
		j = j+1
		if j == n+1 then i = i+1; j = i; end
		if i > n then return nil end
		return string.sub(s, i, j)
	end, str
end

for s in substrings("abcde") do
	print(s)
end

print("----------------- excerse 18.5 ----------------")


function dfs(t, f, st, lv)
	if lv > #t then f(st); return; end
	
	table.insert(st, t[lv])
	dfs(t, f, st, lv+1)
	table.remove(st)
	dfs(t, f, st, lv+1)
end

function subset(t, f)
	local st = {}
	dfs(t, f, st, 1)
end

subset( {"a", "b", "c"}, function(t)
	for k, v in ipairs(t) do 
		io.write(v .. " ")
	end
	print()
end)
print("end")
	