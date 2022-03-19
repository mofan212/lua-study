--[[ 
    可以对使用 key 来访问 table 中指定的 value，但是无法对两个 table 进行操作，比如相加。
    因此 Lua 提供了元表(Metatable)，允许我们改变 table 的行为，每个行为关联了对应的元方法。
    例如：使用元表可以为 Lua 定义如何计算两个 table
 ]]

--[[ 
    两个 table 相加时：
    1、检查两者之一是否有元表；
    2、再检查元表中是否有一个 `__add` 的字段，如果找到就调用对应的值。
    __add 等即时字段，其对应的值（往往是一个函数或是 table）就是"元方法"。

    如何设置或获取元表：
    1、setmetatable(table,metatable): 对指定 table 设置元表(metatable)，如果元表(metatable)中存在 `__metatable` 键值，setmetatable 会失败。
    2、getmetatable(table): 返回对象的元表(metatable)。
]]

local mytable = {} -- 普通表
local metatable1 = {}  -- 元表 1 号
local metatable2 = {} -- 元表 2 号

setmetatable(mytable, metatable1) -- 设置元表

local a = getmetatable(mytable) -- 获取元表
print(a)

mytable.__metatable = nil -- 移除普通表的元表
mytable = setmetatable({}, metatable2) -- 设置元表 2 号

a = getmetatable(mytable) -- 获取新设置的元表
print(a) -- 比较两次打印结果，结果不一样，证明新设置成功

print("---------------- ")

--[[ 
    `__index` 元方法
    解析：当你通过键来访问 table 的时候，如果这个键没有值，那么Lua就会寻找该table的metatable（假定有metatable）中的__index 键。
        如果__index包含一个表格，Lua会在表格中查找相应的键。
    `__index(table, ley)` 如果 __index 包含一个函数，就会调用那个函数，table 和 key 会作为该函数的入参。
 ]]

mytable = setmetatable({key1 = "value1"}, {
    __index = function (tab, key)
        if key == "key2" then
            return "metatableValue"
        else
            return nil
        end
    end
})

print(mytable.key1) -- value1
print(mytable.key2) -- metatableValue

print("---------------- ")

-- 上述案例可以简写成：
mytable = setmetatable({key1 = "value1"}, {__index = {key2 = "metatableValue"} })
print(mytable.key1) -- value1
print(mytable.key2) -- metatableValue

print("---------------- ")

-- 套娃式使用
mytable = setmetatable({key1 = "value1"}, {__index = setmetatable({key2 = "value2"}, {__index = {key3 = "value3"}})})
print(mytable.key1) -- value1
print(mytable.key2) -- value2
print(mytable.key3) -- value3

print("---------------- ")

--[[ 
    从套娃式使用可以知道 Lua 在查询一个表元素的规则是：
    1、在表中查找，如果找到，返回该元素，找不到则继续；
    2、判断该表是否有元表，如果没有元表，返回 nil，有元表则继续。
    3、判断元表有没有 __index 方法，如果 __index 方法为 nil，则返回 nil；如果 __index 方法是一个表，则重复 1、2、3；
        如果 __index 方法是一个函数，则返回该函数的返回值。
 ]]

--[[ 
    当我们对一个 table 中不存在的字段进行赋值时，可以赋值成功，比如：
    ```lua
        tab = {}
        tab.key1 = "value1"
        print(key1) -- value1
    ```
    那如果想要监控对不存在字段赋值的动作应该怎么做呢？
    可以使用 `__newindex` 元方法。
    当给表的一个缺少的索引赋值时，解释器就会查找__newindex 元方法：如果存在则调用这个函数而不进行赋值操作。
    __newindex 元方法用来对表更新，__index则用来对表访问 。
    __newindex 的两个规则：
    1、如果 __newindex 是一个函数，则在给 table 中不存在的字段赋值时，会调用这个函数，并且赋值不成功。
    2、如果 __newindex 是一个 table，则在给 table 中不存在的字段赋值时，会直接给 __newindex 的 table 赋值。
    __newindex 是一个函数时会传入 3 个参数：table 本身、字段名、想要赋予的值。
    [Lua中的元方法__newindex详解](https://www.jb51.net/article/55155.htm)
 ]]

local supperMan = {
    name = "超人",
    money = "Incalculable",
    sayHello = function ()
        print "I am Kent"
    end
}

local man = {name = "none"}

local newIndexTab = {
    __index = supperMan,
    __newindex = function (tab, key, value)
        print(key .. " 字段不存在，请勿赋值！")
    end
}

setmetatable(man, newIndexTab)

man.sayHello = function ()
    print "Hello everyone"
end

man.sayHello()
-- sayHello 字段不存在，请勿赋值！(访问 sayHello 字段时，字段不存在，执行 __newindex)
-- I am Kent (访问 sayHello 字段时，字段不存在，也会执行 __index 对应的函数或去其指向的 table 中寻找对应的字段值)
man.name = "mofan"
print(man.name) -- mofan 字段存在，直接修改，不执行 __newindex

newIndexTab = {name = "new index tab name"}
man = setmetatable({}, {__newindex = newIndexTab})
print("newIndexTab 赋值前 name 的值 ", newIndexTab.name) -- new index tab name
man.name = "mofan"
print("newIndexTab 赋值后 name 的值 ", newIndexTab.name) -- mofan
print("man 中 name 的值 ", man.name) -- nil