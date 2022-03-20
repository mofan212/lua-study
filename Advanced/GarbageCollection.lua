local mytable = {"apple", "orange", "banana"}

print(collectgarbage("count"))

mytable = nil

print(collectgarbage("count"))

print(collectgarbage("collect")) -- 做一次完整的垃圾收集循环

print(collectgarbage("count")) -- 可以看到户必须进行垃圾回收后，Lua 使用的总内存数变小了

-- 概念为主，参考：[Lua 垃圾回收](https://www.runoob.com/lua/lua-garbage-collection.html)