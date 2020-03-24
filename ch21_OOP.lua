print("----------------------- OOP  ----------------------------------")
local animal = 
{
    name = "animal"
}

function animal:run()
    print(self.name .. " run !")
end


function animal:New(o)
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

--[[
    dog's metatable is animal,  animal __index is animal, find run  in TABLE animal.
]]
local dog = animal:New()

dog.name = "dog"
dog:run()

--[[
    littledog's metatable is dog, dog __index is gog, find run in Table dog
]]
local littleDog = dog:New{name="hua"}
littleDog:run()

print("----------------------- multi inheritance----------------------")

local redthing =
{
    showColor = function ()
        print("Red!")
    end
}

function search(parents, k)
    for _, v in ipairs(parents) do
        if v[k] then return v[k] end
    end
end

function createClass(...)
    local parents = {...}
    -- body
    local mt = 
    {
        __index = function(t, k)
            for _, v in ipairs(parents) do
                if v[k] then return v[k] end
            end
        end
    }

    local c = {}
    setmetatable(c, mt)
    c.__index = c

    function c:new(o)
        o = o or {}
        setmetatable(o, c)
        return o
    end

    return c
end

local classRedDog = createClass(dog, redthing)
local redDog = classRedDog:new()

print(redDog)

redDog.showColor()
redDog:run()

print("----------------------- class stack ----------------------")


function class(className, superclass)
    local c = {}
    _G[className] = c

    if _G[superclass] ~= nil then
        _G[superclass].__index = _G[superclass]
        setmetatable(c, _G[superclass])
    end

    c.new = function(self, o)
        o = o or {}
        self.__index = self
        setmetatable(o, self)
        return o
    end
end

class("stack")
function stack:push(v)
    table.insert(self, v)
end

function stack:pop()
    return table.remove(self)
end

function stack:isempty()
    return #self == 0
end

local st = stack:new()
st:push(33)
st:push(22)
st:push(11)

while not st:isempty() do
    print(st:pop())
end


print("----------------------- stackqueue ----------------------")
class("stackqueue", "stack")
function stackqueue:insertbottom(v)
    table.insert(self, 1, v)
end
local stq = stackqueue:new()

stq:push(111)
stq:push(222)
stq:insertbottom(333)
while not stq:isempty() do
    print(stq:pop())
end

print("--------------------privacy : dual representation -----------")
local dualStack = {}
local stackContent = {}
function dualStack:new(o)
    -- body
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    stackContent[o] = {}
    return o
end

function dualStack:push(v)
    table.insert(stackContent[self], v)
end

function dualStack:pop()
    return table.remove(stackContent[self])
end

function dualStack:isEmpty()
    return #(stackContent[self]) == 0
end

local dst = dualStack:new()
dst:push("a")
dst:push("aa")
dst:push("aaa")
while not dst:isEmpty() do
    print(dst:pop())
    -- body
end

print("-------------- proxy --------------------------")
function getAccount()
    local proxy = {}
    local innerTable = {v = 2}
    function innerTable:balance()
        return self.v
    end
    setmetatable(proxy, {__index = innerTable})
    return proxy
end

local ac = getAccount()
print(ac:balance())