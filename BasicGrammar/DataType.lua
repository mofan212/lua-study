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
--[[ �����ȫ�ֱ����� table ���һ��������ֵΪ nil����ͬ������ɾ�� ]]
tab1 = {k1 = "v1", k2 = "v2", "v3"}
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end
tab1.k1 = nil
for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end

print("---------------- ")
-- nil ���Ƚ�ʱ��Ҫ����˫����
print(type(X))
print(type(X) == nil) -- type(X) ���ص��� "nil" �ַ���
print(type(X) == "nil")


print("---------------- ")
-- boolean
-- Lua �Ὣ false �� nil ������ false�������Ķ��� true���������� 0
print(type(true))
print(type(false))
print(type(nil))
 
if false or nil then
    print("������һ���� true")
else
    print("false �� nil ��Ϊ false")
end

if 0 then
    print("���� 0 �� true")
else
    print("���� 0 Ϊ false")
end

print("---------------- ")
-- number
-- Lua Ĭ��ֻ��һ�� number ����
print(type(2))
print(type(2.2))
print(type(0.2))
print(type(2e+1))
print(type(0.2e-1))
print(type(7.8263692594256e-06))

print("---------------- ")
-- string
--[[ 
    1���ַ�����һ��˫���Ż���������ʾ
    2������ʹ����������������ʾ�ַ���
    3���������ַ�����������ʱ���᳢�Խ���������ַ���ת��һ������
    4���ַ�������ʹ�� `..`�������� `+`
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
    1��table �Ĵ�����ͨ��"������ʽ"����ɣ���򵥹�����ʽ��{}����������һ���ձ�Ҳ�����ڱ������һЩ���ݣ�ֱ�ӳ�ʼ����
    2��table ��ʵ��һ��"��������"��associative arrays����������������������ֻ������ַ�����
    3��table ��Ĭ�������� 1 ��ʼ�������� 0
    4��table ����̶����ȴ�С�������������ʱ table ���Ȼ��Զ�������û��ʼ�� table ���� nil
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
-- ��ͬ�� Java��Lua �еĺ�����һ�ȹ���
local function factorial(n)
    if n == 0 then
        return 1
    else
        return n * factorial(n - 1)
    end
end
print(factorial(5))
local factorial1 = factorial -- ������Ϊ�ֲ�����
print(factorial1(5))

local function testFun(tab, fun)
    for k, v  in pairs(tab) do
        print(fun(k, v))
    end
end

local tab = {k1 = "v1", k2 = "v2"}
testFun(tab, function (k, v) -- ����������Ϊ���
    return k .. "= " .. v
end)