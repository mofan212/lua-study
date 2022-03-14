-- 字符串全大写
print(string.upper("mofan"))

-- 字符串全小写
print(string.lower("MOFAN"))

-- 字符串替换
print(string.gsub("m_o_f_a_n", "_", "", 3)) -- mofa_n 3
print(string.gsub("m_o_f_a_n", "_", "")) -- mofan 4

-- 查找子串
print(string.find("m_o_f_a_n", "m_o", 1)) -- 1 3
print(string.find("m_o_f_a_n", "_m_o", 1)) -- nil
print(string.find("m_o_f_a_n", "_m_o", 2)) -- nil

-- 反转字符串
print(string.reverse("mofan")) -- nafom

-- 字符串格式化
print(string.format("the value is: %d", 212))

-- 整型数字与字符的转换（ASCII）
print(string.char(97, 98, 99, 100)) -- abcd
print(string.byte("abcd", 4)) -- 100
print(string.byte("abcd")) -- 97

-- 字符串长度
print(string.len("mofan")) -- 5

-- 拷贝字符串
print(string.rep("mofan", 2)) -- mofanmofan
print(string.rep("mofan", 2, ", ")) -- mofan, mofan

-- 字符串迭代（正则）
for word in string.gmatch("I am mofan", "%a+") do
     print(word)
     -- I
     -- am
     -- mofan
end

-- 正则查找一次
print(string.match("I am 20 years old", "%d+ %a+")) -- 20 years
print(string.format("%d, %q", string.match("I am 20 years old", "(%d+) (%a+)"))) -- 20, "years"
print(string.match("I am 20 years old", "%d+ %a+", 15)) -- nil

-- 字符串截取
--[[ 
    string.sub(s, i [, j])
    s：要截取的字符串。
    i：截取开始位置。
    j：截取结束位置，默认为 -1，最后一个字符。
 ]]
print(string.sub("mofan", 1, 2)) -- mo
print(string.sub("mofan", 5, 7)) -- n
print(string.sub("mofan", 1, -2)) -- mofa
print(string.sub("mofan", 6)) -- 空字符串
print(string.sub("mofan", 100)) -- 空字符串
print(string.sub("mofan", -5)) -- mofan
print(string.sub("mofan", -100)) -- mofan


local string1 = "Lua"
local string2 = "Tutorial"
local number1 = 10
local number2 = 20
-- 基本字符串格式化
print(string.format("基本格式化 %s %s",string1,string2)) -- 基本格式化 Lua Tutorial
-- 日期格式化
local date = 2; local month = 1; local year = 2014
print(string.format("日期格式化 %02d/%02d/%03d", date, month, year)) -- 日期格式化 02/01/2014
-- 十进制格式化
print(string.format("%.4f",1/3)) -- 0.3333