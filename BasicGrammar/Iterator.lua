-- 无状态的迭代器
local function square(iteratorMaxCount, currentNumber)
    if currentNumber < iteratorMaxCount
        then
            currentNumber = currentNumber + 1
        return currentNumber, currentNumber * currentNumber
    end
end

for i, n in square, 3, 0
do
    print(i, n)
    -- 1 1
    -- 2 4
    -- 3 9
end
print("---------------- ")

--[[ 
    为什么上面会输出那样的结果呢？先知道泛型 for 的语法格式：
        for 变量列表 in 迭代函数, 状态变量, 控制变量 do 
            循环体
        end    
    再了解下泛型 for 的执行过程：
    1、初始化 in 后面表达式的值，与多值赋值一样，如果表达式返回的结果个数不足三个自动以 nil 补充，多余的被忽略；
    2、将状态常量和控制变量作为参数调用迭代函数（注意：对于 for 结构来说，状态常量仅仅在初始化时获取他的值并传递给迭代函数）。
    3、将迭代函数返回的值赋给变量列表。
    4、如果返回的第一个值为 nil 循环结束，否则执行循环体。
    5、回到第二步再次调用迭代函数
 ]]

-- 回顾下 ipairs 迭代函数
local array = {"a", "b", "c"}
for i, v in ipairs(array) do
    print(i .. ": " .. v)
end
print("---------------- ")

--[[ 
    通过查看 ipairs 的说明，知道它将返回三个值，分别是：
    1、迭代函数
    2、表 t
    3、0
    因此不难知道 Lua 中的 ipairs 是这样实现的：
    function iter (a, i)
        i = i + 1
        local v = a[i]
        if v then
            return i, v
        end
    end
    
    function ipairs (a)
        return iter, a, 0
    end
 ]]


-- 多状态的迭代器
-- 很多情况下，迭代器需要保存多个状态信息而不是简单的状态常量和控制变量，最简单的方法是使用闭包。

array = {"one", "two"}

local function elementIterator (collection)
   local index = 0
   local count = #collection
   -- 闭包函数
   return function ()
      index = index + 1
      if index <= count
      then
         --  返回迭代器的当前元素
         return collection[index]
      end
   end
end

for element in elementIterator(array)
do
   print(element)
end
print("---------------- ")

-- 泛型 for 在迭代的时候每次调用的是闭包函数，迭代函数只是开始的时候调用一次
local function eleiter(t)
    local index = 0
    print('in eleiter function')  --> 每次调用迭代函数都说一句：in eleiter function
    return function()
        print('I am here.')  --> 每次调用闭包函数都说一句：I am here
        index = index + 1
        return t[index]
    end
end

local t = {'one','two'}
for ele in eleiter(t) do
    print(ele)
end
print("---------------- ")

-- pairs 与 ipairs
--[[ 
    1、它俩都能遍历 table
    2、ipairs 仅仅遍历值，按照索引（略过非整数的索引）升序遍历，索引中断（包括遇到 nil）停止遍历。
    3、pairs 能遍历集合的所有元素。
 ]]

local function traversalTableWithIpairs(table)
    for k, v  in ipairs(table) do
        print(k, v)
    end
    print("---------------- ")
end

local function traversalTableWithPairs(table)
    for k, v  in pairs(table) do
        print(k, v)
    end
    print("---------------- ")
end

 local table = {
     [1] = "one",
     [4] = "four",
     [6] = "six"
 }
-- 1 one 在 key 为 2 处断开
traversalTableWithIpairs(table)


table = {
    [2] = "two",
    [4] = "four",
    [6] = "six"
}
-- 什么都没输出，因为 key 为 1 时，value 为 nil
traversalTableWithIpairs(table)

-- 输出所有 key value
traversalTableWithPairs(table)

local anotherTable = {
    "alpha",
    "beta",
    [3] = "and",
    [3.5] = "or",
    ["two"] = "not"
}

-- 输出前三项，因为其余两项 key 不是整数
traversalTableWithIpairs(anotherTable)

-- 输出所有 key value
traversalTableWithPairs(anotherTable)