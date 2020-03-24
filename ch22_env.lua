print("--------------22.2----------------")
local foo
do
local _ENV = _ENV
function foo () print(X) end
end
X = 13
_ENV = nil
foo()  --> 13
X = 0  -- error

print("--------------22.3----------------")
-- local print = print
-- function foo (_ENV, a)
-- 	print(a + b)
-- end
-- foo({b = 14}, 12) --12 + 14
-- foo({b = 10}, 1) --1 + 10
