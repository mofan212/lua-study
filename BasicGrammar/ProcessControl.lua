--[[ 
    1、控制结构的条件表达式结果可以是任何值，Lua 认为 false 和 nil 为假，true 和非 nil 为真
    2、注意：Lua 中的数字 0 也是 true
 ]]
 if 0 then
    print("0 也是 true")
end
print("---------------- ")

-- if..else
local a = 100
if a < 100 then
    print("a 小于 100")
else
    print("a 不小于 100")
end
print("---------------- ")

-- if..elseif..else
local b = 100
if b > 1000 then
    print("b 大于 1000")
elseif b > 100 then
    print("b 大于 100")
else
    print("b 大于 10")
end

-- 与 Java 一样，Lua 也支持 if 嵌套语句