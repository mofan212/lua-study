print(type("Hello world"))      --> string
print(type(10.4 * 3))           --> number
print(type(print))              --> function
print(type(type))               --> function
print(type(true))               --> boolean
print(type(nil))                --> nil
print(type(type(X)))            --> string
print(type(X))                  --> nil

print("---------------- ")
-- nil
--[[ 如果给全局变量或 table 里的一个变量赋值为 nil，等同将它们删掉 ]]
tab1 = {k1 = "v1", k2 = "v2", "v3"}
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end
tab1.k1 = nil
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end

print("---------------- ")
-- nil 作比较时需要加上双引号
print(type(X))
print(type(X) == nil) -- type(X) 返回的是 "nil" 字符串
print(type(X) == "nil")


print("---------------- ")
-- boolean
-- Lua 会将 false 和 nil 看作是 false，其他的都是 true，包括数字 0
print(type(true))
print(type(false))
print(type(nil))
 
if false or nil then
    print("至少有一个是 true")
else
    print("false 和 nil 都为 false")
end

if 0 then
    print("数字 0 是 true")
else
    print("数字 0 为 false")
end

print("---------------- ")
-- number
-- Lua 默认只有一种 number 类型，即：double（双精度）类型
print(type(2))
print(type(2.2))
print(type(0.2))
print(type(2e+1))
print(type(0.2e-1))
print(type(7.8263692594256e-06))

print("---------------- ")
-- string
--[[ 
    1、字符串由一对双引号或单引号来表示
    2、可以使用两个方括号来表示字符块
    3、对数字字符串进行运算时，会尝试将这个数字字符串转成一个数字
    4、字符串连接使用 `..`，而不是 `+`
 ]]
stringBlock = [[
    1111
    2222
]]
print(stringBlock)
print("1" + 2) -- 3
print("1" + "3") -- 4
print("1 + 3") -- 1 + 3
print("a" .. "b") -- ab
print(123 .. 456) -- 123456

print("---------------- ")
-- table
--[[ 
    1、table 的创建是通过"构造表达式"来完成，最简单构造表达式是{}，用来创建一个空表。也可以在表里添加一些数据，直接初始化表；
    2、table 其实是一个"关联数组"（associative arrays），数组的索引可以是数字或者是字符串；
    3、table 的默认索引从 1 开始，而不是 0；
    4、table 不会固定长度大小，有新数据添加时 table 长度会自动增长，没初始的 table 都是 nil。
 ]]
local table1 = {}
local table2 = {"apple", "pear", "banana"}

table1["key"] = "value"
local key = 10
table1[key] = 20
table1[key] = table1[key] + 20
for key, value in pairs(table1) do
    print(key .. ": " .. value)
end

for k, v in pairs(table2) do
    print("key: " .. k)
end

local table3 = {}
for i = 1, 10 do
    table3[i] = i
end
table3["key"] = "val"
print(table3["key"])
print(table3["none"])

print("---------------- ")
-- function
-- 不同于 Java，Lua 中的函数是一等公民
local function factorial(n)
    if n == 0 then
        return 1
    else
        return n * factorial(n - 1)
    end
end
print(factorial(5))
local factorial1 = factorial -- 函数作为局部变量
print(factorial1(5))

local function testFun(tab, fun)
    for k, v  in pairs(tab) do
        print(fun(k, v))
    end
end

local tab = {k1 = "v1", k2 = "v2"}
testFun(tab, function (k, v) -- 匿名函数作为入参
    return k .. "= " .. v
end)

print("---------------- ")

--[[ 
    全局变量：全局变量在代码运行周期从头到尾，都不会被销毁，而且随处都可调用。
    当代码量增加，很多时候大量新建全局变量会导致内存激增，因此需要一种可以临时使用、并且可以自动销毁释放内存资源的变量。
    局部变量：使用 local 创建一个局部变量，与全局变量不同，局部变量只在被声明的那个代码块内有效。
 ]]

-- 全局变量与 table
-- 在 Lua 中，所有的全局变量全部被存放在了一共大 table 中，这个 table 名为：_G
A = 123
print("使用 _G 输出全局变量 A 的值 ", _G.A) -- 123
_G.B = 234 -- 相当于定义了一个全局变量
print("获取使用 _G 定义的全局变量 ", _G.B) -- 234
_G["def"] = 456
print("获取全局变量 def 对应的值 ", def, _G["def"], _G.def) -- 456 456 456
-- 甚至还可以
_G.print("hello") -- 相当于直接调用 print("hello")
_G["print"]("world") -- 相当于直接调用 print("world")
