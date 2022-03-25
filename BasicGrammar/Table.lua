--[[ 
    1、table 是 Lua 的一种数据结构用来帮助我们创建不同的数据类型，如：数组、字典等。
    2、Lua table 使用关联型数组，你可以用任意类型的值来作数组的索引，但这个值不能是 nil。
    3、Lua table 是不固定大小的，你可以根据自己需要进行扩容。
    4、Lua 也是通过 table 来解决模块（module）、包（package）和对象（Object）的。 例如 string.format 表示使用 "format" 来索引 table string。
 ]]

-- 构建一个表
local mytable = {}

mytable[1] = "One"

mytable = nil -- 删除引用。Lua 的垃圾回收机制会释放内存

 --[[ 
     当我们为 table a 并设置元素，然后将 a 赋值给 b，则 a 与 b 都指向同一个内存。
     如果 a 设置为 nil ，b 同样能访问 table 的元素（不会影响 b）。
     如果没有指定的变量指向a，Lua 的垃圾回收机制会清理相对应的内存。
  ]]

mytable = {}
print("mytable 的类型是 " .. type(mytable)) -- table

mytable[1] = "One"
mytable["mofan"] = "修改前"
print("索引为 1 的元素是 " .. mytable[1]) -- One
print("索引为 mofan 的元素是 " .. mytable["mofan"]) -- 修改前

-- anotherTable 和 mytable 指向同一个 table
local anotherTable = mytable
print("anotherTable 中索引为 1 的元素是 " .. anotherTable[1]) -- One
print("anotherTable 中索引为 mofan 的元素是 " .. anotherTable["mofan"]) -- 修改前

anotherTable["mofan"] = "修改后"
print("anotherTable 中索引为 mofan 的元素是 " .. anotherTable["mofan"]) -- 修改后

-- 释放变量
anotherTable = nil
print("anotherTable 是 ", anotherTable) -- nil。使用 .. 连接将报错，因为 .. 是用来连接两个字符串的

-- mytable 不受影响
print("mytable 索引为 mofan 的元素是 " .. mytable["mofan"]) -- 修改后

mytable = nil
print("mytable 是 ", mytable) -- nil
print("---------------- ")


-- Table 的操作

-- Table 连接
local numberTable = {"One", "Two", "Three"}
print("连接 table 中所有元素 ", table.concat(numberTable)) -- OneTwoThree
print("使用指定连接符进行连接 ", table.concat(numberTable, ",")) -- One,Two,Three
print("对指定位置的元素进行连接", table.concat(numberTable, ",", 2, 3)) -- Two,Three
print("---------------- ")

-- 插入和移除
numberTable = {"1", "2", "3"}
table.insert(numberTable, "4") -- 在末尾插入
print("索引为 4 的元素是 ", numberTable[4]) -- 4

table.insert(numberTable, 2, "Two") -- 在索引为 2 的位置插入元素
print("索引为 1 的元素是 ", numberTable[1]) -- 1
print("索引为 2 的元素是 ", numberTable[2]) -- Two
print("索引为 3 的元素是 ", numberTable[3]) -- 2

print("索引为 5 的元素是 ", numberTable[5]) -- 4
table.remove(numberTable, 5)
print("索引为 5 的元素是 ", numberTable[5]) -- nil
print("---------------- ")

-- 排序
numberTable = {"B", "A", "D", "C"}
print "排序前"
for index, value in ipairs(numberTable) do
  print(index, value)
end
print "排序后"
table.sort(numberTable)
for index, value in ipairs(numberTable) do
  print(index, value)
end
print "自定义排序规则"
table.sort(numberTable, function (a, b)
  return a > b
end)
for index, value in ipairs(numberTable) do
  print(index, value) -- 降序排序
end
print("---------------- ")

-- 求取 table 中的最大值
local function getMaxInTable(t)
  local mn = nil
  for index, value in ipairs(t) do
    if mn == nil then
      mn = value
    end
    if mn < value then
      mn = value
    end
  end
  return mn
end

local testTab = {[1] = 1, [2] = 2, [3] = 3, [4] = 6}
print("testTab 中的最大值是 ", getMaxInTable(testTab)) -- 6
print("testTab 的长度为 ", #testTab ) -- 4
print("---------------- ")

-- 获取 table 的长度
--[[ 
  在操作符一栏中，我们知道使用 # 符号求取 table 的长度时会因为索引中断导致无法正确获取到 table 的长度，
  为此我们编写一个函数来获取 table 的实际长度
 ]]

local function getTableLength(t)
  local length = 0
  for index, value in pairs(t) do -- 使用 pairs 而不是 ipairs
    length = length + 1
  end
  return length
end 

-- 使用操作符一栏的数据进行测试

local tab3 = {}
tab3[1] = "1"
tab3[2] = "2"
tab3[4] = "4"
print("tab3 的长度 ", getTableLength(tab3))  -- 3

local tab4 = {}
tab4[1]="1"
tab4[2]="2"
tab4[5]="5"
print("tab4 的长度 ", getTableLength(tab4))  -- 3

local tab5 = {1, 2, nil, nil, 5}
print("tab5 的长度 ", getTableLength(tab5)) -- 3

tab5[6] = 1
print("tab5 的长度 ", getTableLength(tab5)) -- 4
print("---------------- ")


-- 简单的去重
local function table_unique(t)
  local check = {};
  local n = {};
  for key, value in pairs(t) do
      if not check[value] then
          n[key] = value
          check[value] = value
      end
  end
  return n
end

local notDistinctTable = {1 , 2 , 3 , 4 , 20 , 6 , 7 , 7 , 15 , 28};
for key, value in pairs(table_unique(notDistinctTable)) do
  print("value is ", value)
end

-- table 作为入参是引用传递
local function fn1(t)
  t["1"] = "3"
end
local t = {["1"] = "1", ["2"] = "2"}
print "调用前"
for key, value in pairs(t) do
  print(key, value)
  -- 2 2
  -- 1 1
end
fn1(t)
print "调用后"
for key, value in pairs(t) do
  print(key, value)
  -- 2 2
  -- 1 3
end