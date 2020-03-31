 print("-------------------23.1----------------------")
-- wk = {}
-- setmetatable(wk, {__mode="v"})

-- function mem(o)
--     local res = function() return o end
--     wk[o] = res
--     return res
-- end

-- a = {sss="aaa"}
-- setmetatable(a, {__gc=function(o) print("in gc") end})
-- mem(a)
-- a = nil
-- collectgarbage()
-- print("-------gc 1 end---------")
-- collectgarbage()
-- print("-------gc 2 end---------")

print("-------------------23.2----------------------")
-- o = {x = "hi"}
-- setmetatable(o, {__gc = function (o) print(o.x) end})
-- o = nil
-- os.exit() --  not call __gc
-- error()  -- call __gc
--collectgarbage() --> hi


print("-------------------23.4----------------------")
-- local count = 0
-- local mt = {
    --     __gc = function () 
    --     count = count - 1 end
    -- }
    -- local a = {}
    -- for i = 1, 10000 do
    -- count = count + 1
    -- a[i] = setmetatable({}, mt)
    -- end
    -- collectgarbage()
    -- print(collectgarbage("count") * 1024, count)  --262200
    -- a = nil
    -- collectgarbage()  -- clear Table a
    -- print(collectgarbage("count") * 1024, count) 
    -- collectgarbage()  -- clear a[1] a[2]  a[3]
    -- print(collectgarbage("count") * 1024, count)
    
    
print("-------------------23.5----------------------")
 
setmetatable({}, {
    __gc = function(o)
        print("GC",collectgarbage("count") )
        setmetatable({}, getmetatable(o))
    end
})

a = {}
function f()
    while true do
        print(collectgarbage("count"))
        local n = io.read("n")
        n = n * 100
        while n > 0 do
            a[0] = {}
            n = n -1
        end
    end
end
collectgarbage("setpause", 200)
co = coroutine.create(f)

coroutine.resume(co)
 

