--[[ 
    算术运算符：+ - * / %
    其他算术运算符：
        ^ (乘幂)
        - (减法或负号)
        // (整除 >= Lua 5.3)
 ]]

print(2^2) -- 4.0
print(-2) -- -2
print(5 // 2) -- 2
print(5 / 2) -- 2.5
print("---------------- ")

--[[ 
    关系运算符：== ~= < > <= >=
 ]]
-- ~= 不等于
print(1 ~= 2) -- true
print("---------------- ")


--[[ 
    逻辑运算符：and or not
    and：针对 (A and B)，若 A 为 false，则返回 A，否则返回 B。
    or：针对 (A and B)，若 A 为 true，则返回 A，否则返回 B。
    not：与逻辑运算结果相反，如果条件为 true，逻辑非为 false。
 ]]
-- not 取反
print(not(1 and nil)) -- true
print("---------------- ")

--[[ 
    其他运算符：
    1、.. 连接两个字符串。如果连接的某个值是 nil，则会报错。
    2、# 返回字符串或表的长度
 ]]
print("hello" .. "world") 
local str = "hello world"
local tab = {"v1", "v2"}
print("str length is " .. #str) -- 11
print("table size is " .. #tab) -- 2

local tab2 = {k1 = "v1", k2 = "v2"}
print(tab2.k1) -- v1
print("tab2 size is " .. #tab2) -- 0
print("---------------- ")

local num = 123
-- 将数字转字符串后拼接。如果不转，会报错。
print(str .. tostring(num))

-- 拓展：字符串转数字
local numStr = "456"
print("字符串转数字 ", (tonumber(numStr) + num))
print("字符串转数字 ", (num + numStr))

--[[ 
    运算符优先级：
    ^
    not    - (unary)
    *      /       %
    +      -
    ..
    <      >      <=     >=     ~=     ==
    and
    or
 ]]

--[[ 
    两个 number 类型的数值进行 and 操作，返回在 and 右边那个数值。
    进行 or 操作，返回在 or 左边那个数值。
    因为 and 优先级比 or 高，所以 and 和 or 混合运算会先计算 and 的返回值，再计算 or 的值。
 ]]

-- 实现三元运算符
local flag = true
print(flag and "mofan" or "默烦")
print("---------------- ")

-- 使用 # 计算获取表的长度
local tab3 = {}
tab3[1] = "1"
tab3[2] = "2"
tab3[4] = "4"
print("tab3 的长度 ", #tab3)  -- 4

local tab4 = {}
tab4[1]="1"
tab4[2]="2"
tab4[5]="5"
print("tab4 的长度 ", #tab4)  -- 2

local tab5 = {1, 2, nil, nil, 5}
print("tab5 的长度 ", #tab5) -- 5

tab5[6] = 1
print("tab5 的长度 ", #tab5) -- 2

-- 使用 # 运算符计算 table 的长度时，返回值似乎并不是我们所期待的