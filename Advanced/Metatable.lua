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
