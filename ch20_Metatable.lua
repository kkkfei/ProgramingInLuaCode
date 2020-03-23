local Set = {}
 

function Set.new(list)
	local set = {}
	setmetatable(set, {__add=Set.union,
						__tostring=Set.tostring,
						__sub=Set.difference,
						__len=Set.size})
	for k, v in ipairs(list) do
		set[v] = true
	end
	return set
end

function Set.union(a, b)
	local res = Set.new({})
	for k, v in pairs(a) do res[k] = true end
	for k, v in pairs(b) do res[k] = true end

	return res
end

function Set.tostring(a)
	local list = {}
	for k, v in pairs(a) do
		list[#list + 1] = k
	end
	return #a .. " {"..table.concat(list, ",") .. "}"
end

function Set.difference(a, b)
	local res = Set.new({})
	for k, v in pairs(a) do
		if b[k] == nil then
			res[k] = true
		end
	end
	return res
end

function Set.size(a)
	local cnt = 0
	for k in pairs(a) do
		cnt = cnt + 1
	end
	return cnt
end

a = Set.new{"a", "b", "c"}
b = Set.new{"aa", 1, 3, "c"}
c = a + b
print(a-b)
print(c)

-------------------- Set Default Value -----------------------
do
	local key = {}
	local mt = {__index = function(t) return t[key] end}
	function setDefault(t, d)
		t[key] = d
		setmetatable(t, mt)
	end
	a = {}
	setDefault(a, 4)
	print(a.c)
end

print("------------------- readonly table ----------------")
do
	local key = {}
	local mt = {
		__index = function(t, k) 
			print("index")
			return t[key][k]
		end,
		
		__newindex = function(t, k, v)
			print("new index")
		end
	}

	function readonly(t)
		local proxy = { }
		proxy[key] = t
		setmetatable(proxy, mt)
		return proxy
	end
	
	a = readonly{11, 22, 33}
	print(a[2])
	a[1] = 111
end

print("------------------- file proxy ----------------")
function fileAsArray(filename)
	local proxy = {}
	local file = io.open(filename, "r+")
	local mt = {
		__index = function(t, k)
			file:seek("set", k-1)
			return file:read(1)
		end,
		__newindex = function(t, k, v)
			file:seek("set", k-1)
			file:write(v)
		end,
		__pairs = function(t)
			return function(t, k)
				k = k==nil and 1 or k+1
				if k == #t + 1 then return nil end
				return k, t[k]
			end, t, nil
		end,
		__len = function()
			return file:seek("end")
		end,
		__tostring = function()
			file:seek("set") 
			return file:read("a")
		end
	}
	setmetatable(proxy, mt)
	return proxy
end

local f = fileAsArray("in.txt")
for k, v in pairs(f) do
	io.write(v .. " ")
end
io.write("\n")
 




 


 