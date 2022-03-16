-- 参考链接：https://blog.csdn.net/weixin_43586120/article/details/89456183

-- 场景一
local function funA()
    local a = 10
    return function ()
        return a; -- 内部匿名函数访问外部函数的 a
    end
end

local b = funA();
-- 直接使用 b 会报错
print("b 的值为 ", b() ) -- 10

local function funB()
    return 100
end
b = funB()
print("b 的值为 " .. b) -- 100
print("---------------- ")

-- 场景二
local function outerFunc()
    local a = 0
    local function innerFun()
        a = a + 1
        print("a 的值为 " .. a)
    end
    return innerFun
end

-- 每次外部函数执行的时候，都会开辟一块内存空间，外部函数的地址不同，都会重新创建一个新的地址
local inner1 = outerFunc();
inner1() -- 1
inner1() -- 2
inner1() -- 3

local inner2 = outerFunc();
inner2() -- 1
inner2() -- 2
inner2() -- 3
print("---------------- ")

-- 场景三
local i = 0
local function outerFun()
    local function innerFun()
        i = i + 1
        print("i 的值为 " .. i)
    end
    return innerFun;
end

local inner3 = outerFun();
local inner4 = outerFun();
inner3(); -- 1
inner4(); -- 2
inner3(); -- 3
inner4(); -- 4
print("---------------- ")

-- 场景四
local function fn()
    local a = 3
    return function ()
        return a + 1
    end
end
print(fn()()) -- 4
print(fn()()) -- 4
print("---------------- ")

-- 场景五
local function outerFun()
    local i = 0
    local function innerFun()
        i = i + 1
        print("i 的值为 " .. i)
    end
    return innerFun
end
local inner5 = outerFun()
local inner6 = outerFun()
inner5(); -- 1
inner6(); -- 1
inner5(); -- 2
inner6(); -- 2
print("---------------- ")

-- 场景六
WINDOW = {};

(function ()
    local m = 0
    local function getM()
        return m
    end
    local function setA(val)
        m = val
    end
    WINDOW.g = getM;
    WINDOW.f = setA;
end)() -- 定义并执行一个函数
WINDOW.f(100);
print("g() 的值为 " .. WINDOW.g()) -- 100
print("---------------- ")

-- 场景七
local function a()
    local n = 0
    local function b()
        n = n + 1
        print("n 的值为 " .. n)
    end
    return b
end
local c = a()
c() -- 1
c() -- 2
print("---------------- ")

-- 场景八
local function f()
    local count = 0
    return function ()
        count = count + 1
        print("count 的值为" .. count)
    end
end
local t1 = f()
t1() -- 1
t1() -- 2
t1() -- 3
print("---------------- ")

-- 场景九
local tmp
local add = function (x)
    local sum = 1
    tmp = function (x)
        sum = sum + x
        if x == 3 then
            return sum
        else
            return tmp
        end
    end
    return tmp
end
print(add(1)(2)(3)) -- 6
print("---------------- ")


-- 场景十
local table = {"apple", "pear", "orange"}

for index = 1, #table do
    (function (i)
        print("编列结果为 " .. table[i])
    end)(index)
end
print("---------------- ")

-- 场景十一
local function m1()
    local x = 1
    return function ()
        x = x + 1
        print(x)
    end
end

m1()() -- 2
m1()() -- 2
m1()() -- 2

local m2 = m1()
m2() -- 2
m2() -- 3
m2() -- 4

print("---------------- ")

-- 场景十二
local fn12 = (function ()
    local i12 = 10
    local function fn12()
        i12 = i12 + 1
        print("i12 的值为 " .. i12)
    end
    return fn12
end)()
fn12() -- 11
fn12() -- 12
print("---------------- ")

-- 场景十三
local function love1()
    local num = 123
    local me1 = function ()
        print("num 的值为 " .. num)
    end
    num = num + 1
    return me1
end
local loveme1 = love1()
loveme1() -- 124
print("---------------- ")

-- 场景十四
local function fun14(n, o)
   print("o 的值为 " .. o)
   local tab14 = {}
   tab14.fun = function (m)
        return fun14(m, n)
   end
   return tab14
end
local a14 = fun14(0, 0) -- 0
a14.fun(1) -- 0
a14.fun(2) -- 0
a14.fun(3) -- 0
local b14 = fun14(0, 0).fun(1).fun(2).fun(3) -- 0 0 1 2
local c14 = fun14(0, 0).fun(1) -- 0 0
c14.fun(2) -- 1
c14.fun(3) -- 1
print("---------------- ")

-- 场景十五
local function fun15()
    local arr15 = {}
    I = 0 -- 全局变量
    while I < 5 do
        I = I + 1
        arr15[I] = function ()
            return I
        end
    end
    return arr15
end
local list15 = fun15()
for index, value in ipairs(list15) do
    print(value()) -- 5 5 5 5 5
end
print("---------------- ")

-- 场景十六
local function fun16()
    local arr16 = {}
    for i = 1, 5 do -- i 是局部变量
        arr16[i] = function ()
            return i
        end
    end
    return arr16
end
local list16 = fun16()
for index, value in ipairs(list16) do
    print(value()) -- 1 2 3 4 5
end
print("---------------- ")

-- 场景十七
local function fun17()
    local arr17 = {}
    J = 0 -- 全局变量
    while J < 5 do
        J = J + 1
        arr17[J] = (function (J)
            return function ()
                return J
            end
        end)(J)
    end
    return arr17
end
local list17 = fun17()
for index, value in ipairs(list17) do
    print(value()) -- 1 2 3 4 5
end
print("---------------- ")

-- 场景十八
print(var18) -- nil

V18 = {}
do
    local var18 = 2
    V18.fun18 = function ()
        var18 = var18 - 1
        print(var18)
    end
end
V18.fun18();
V18.fun18();
print("---------------- ")

local function fun19()
    local var19 = 3
    local tab19 = {
        ["A"] = function ()
            var19 = var19 - 1
            print("var19 = ", var19)
        end
    }
    return tab19
end
fun19().A() -- var19 = 2

print("---------------- ")

-- 词法定界
local function fn1()
    local a = 5
    local function fn2()
        print(a)
    end
    fn2()
end

fn1()

print("---------------- ")


local function fn3()
    print("hello world")
end

local fn4 = function () -- 函数作为变量
    print("hello world")
end

fn3()
fn4()