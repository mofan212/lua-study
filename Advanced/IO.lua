--[[ 
    Lua I/O 库用于读取和处理文件。分为简单模式（和C一样）、完全模式。
    1、简单模式（simple model）拥有一个当前输入文件和一个当前输出文件，并且提供针对这些文件相关的操作。
    2、完全模式（complete model） 使用外部的文件句柄来实现。它以一种面对对象的形式，将所有的文件操作定义为文件句柄的方法
    一般来说，简单模式在做一些简单的文件操作时更合适。
 ]]

-- 使用绝对路径，以只读的方式打开文件 
local file = io.open("D:\\Code\\Lua\\Advanced\\testfile\\test.txt", "r")
-- 设置默认输入的文件（输入指的是输入到内存中）
io.input(file)
-- 读取文件中的第一行
print(io.read())
-- 关闭文件
io.close(file)
-- 使用相对路径以附加的方式打开文件（其中 Advanced 目录是我使用 VS Code 打开的 Lua 目录下的一个子目录）
file = io.open("Advanced/testfile/test.txt", "a")
-- 设置默认输出的文件（输出指的是输出到磁盘上）
io.output(file)
-- 在文件最后一行添加内容（并不是在当前文件的最后一行的下一行添加，而是追加到最后一行末尾）
io.write(" -- I am mofan")
io.write("\ninsert an extra row") -- 将内容插入到最后一行的下一行
-- 关闭文件
io.close(file)


-- 如果需要同时操作多个文件，就需要使用完全模式
file = io.open("Advanced/testfile/test.txt", "r")
-- 输出文件第一行
print(file:read())
-- 关闭打开的文件
file:close()
file = io.open("Advanced/testfile/test.txt", "a")
-- 将内容插入到最后一行的下一行
file:write("\n -- the last row")
file:close()

-- file:seek()
file = io.open("Advanced/testfile/test.txt", "r")
file:seek("end", -25)
print(file:read("*a"))
file:seek("set")
local num = file:read("*n") -- 获取数字
if num == nil then
    local tab = {}
    -- 将文件内容写到 tab 中
    for line in io.lines("Advanced/testfile/test.txt") do
        table.insert(tab, line)
    end
    file:close()
    file = io.open("Advanced/testfile/test.txt", "w")
    for index, value in ipairs(tab) do
        -- 在第一行前面增加 123
        if index == 1 then
            file:write("123" .. value .. "\n")
        else
            file:write(value .. "\n")
        end
        
    end
    file:close()
end
file = io.open("Advanced/testfile/test.txt", "r")
print(file:read("*n")) -- 123
file:close()

--[[ 
    使用 *n 作为参数读取文件中的数字的时候，只有文件中第一个字符是数字（或者空格加数字）的情况下才能读取到并返回这个数字
    否则将返回 nil
 ]]

-- io.flush
file = io.open("Advanced/testfile/test.txt", "a")
file:setvbuf("full", 16)
file:write("10 letters\n")
file:write("10 letters\n")
file:flush() -- 注释前后，效果不一样
-- 暂停程序，模拟出错
os.execute("pause")
file:close()

--[[ 
    参考链接：[Lua io.flush()/file:setvbuf()](https://www.jianshu.com/p/3c255cb27db4)
    使用 file:setvbuf() 设置缓冲区大小为 16，然后向文件中写入超过 16 个字符的内容：
    1、未使用 file:flush() 时，不满 16 的字符是不会写入文件的。当程序退出缓冲区时会将不满 16 的字符继续写入，
        但如果这时程序出现了异常，这部分字符就丢失了。
    2、使用 file:flush() 后，可以将缓冲区数据强制写入到文件或内存变量并清空缓冲区。
 ]]