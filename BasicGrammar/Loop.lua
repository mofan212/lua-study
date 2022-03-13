-- while 循环
local a = 5
while a < 7 do
    print(a)
    a = a + 1
end
print("---------------- ")

-- 数值 for 循环
--[[ 
    1、格式：
        for var=exp1,exp2,exp3 do  
            <执行体>  
        end  
    2、var 从 exp1 变化到 exp2，每次变化以 exp3 为步长递增 var，并执行一次 "执行体"。exp3 是可选的，如果不指定，默认为 1。
    3、for 的三个表达式在循环开始前一次性求值，以后不再进行求值。
 ]]
for i = 10, 1, -1 do
    print(i)
end

local function f(x)  
    print("function")  
    return x * 2  
end  

for i = 1, f(5) do 
    print(i)  
end
print("---------------- ")

-- 泛型 for 循环（类似 Java foreach）
local p = {"one", "two", "three"}
for index, value in ipairs(p) do
    print(index, value)
end
print("---------------- ")

-- repeat..until 循环 （类似 Java 的 do..while）
local b = 5
repeat
    print("b = " .. b)
    b = b + 1
until (b > 7) -- 括号可以省略
print("---------------- ")

-- 当然循环之间也可以嵌套，无论是同种循环还是不同种循环

-- 循环控制语句 break （与 Java 中的使用方式一样，不再赘述）

-- 循环控制语句 goto
-- `goto` 语句允许将控制流程无条件地转到被标记的语句处

local c = 1
::label:: print("--- goto label ---")

c = c + 1
if c < 3 then
    goto label   -- c 小于 3 的时候跳转到标签 label
end
--[[ 
    打印结果：
    --- goto label ---
    --- goto label ---
 ]]

print("---------------- ")

local i = 0
::s1:: do
  print(i)
  i = i + 1
end
if i > 3 then
  os.exit()   -- i 大于 3 时退出
end
goto s1

--[[ 
    打印结果：
    0
    1
    2
    3
 ]]