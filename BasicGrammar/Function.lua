--[[ 
    1、Lua 中的函数类似与 Java 中的方法
    2、定义格式：
            optional_function_scope function function_name (arg1, arg2, arg3..., argn)
                function_body
                return result_params_comma_separated
            end
        optional_function_scope: 指定函数是全局函数还是局部函数，未设置该参数默认为全局函数，
            可以使用关键字 local 设置函数为局部函数。
        function_name: 函数名称。
        arg1, arg2, arg3..., argn: 函数参数，多个参数以逗号隔开，也可以没有参数。
        function_body: 函数体，函数中需要执行的代码语句块。
        result_params_comma_separated: 函数返回值，Lua 语言函数可以返回多个值，每个值以逗号隔开。
    3、在 Lua 中可以将一个函数作为另一个函数的参数。
    4、Lua 的函数可以接受可变数目的参数，和 C 语言类似，在函数参数列表中使用三点 ... 表示函数有可变的参数。    
    5、可以通过 select("#",...) 来获取可变参数的数量
    6、函数可以有几个固定参数加上可变参数，但固定参数必须放在变长参数之前
 ]]

--  将一个函数作为另一个函数的参数
local myprint = function (param)
    print("自定义打印函数 - ## ", param, "##")
end
local function add(n1, n2, printFunc)
    local result = n1 + n2
    printFunc(result)
end

myprint(10)
add(1, 2, myprint)
print("---------------- ")

-- 多返回值
local function twoReturnValue(a, b)
    return a + 1, b + 2
end

local r1, r2 = twoReturnValue(1, 2)
print("return1 = " .. r1 .. ", return2 = " .. r2)
print("---------------- ")

-- 可变参数
local function average(...)
    local result = 0;
    local arg = {...}
    for index, value in ipairs(arg) do
        result  = result + value
    end
    -- 两种方式获取参数参数的个数
    print("传入 " .. #arg .. "个数")
    print("传入 " .. select("#",...) .. "个数")
    return result / #arg
end

print("平均值为 " .. average(1, 2, 3, 4, 5))
print("---------------- ")

-- 固定参数与可变参数
local function fwrite(fmt, ...)
    return io.write(string.format(fmt, ...))
end
fwrite("mofan \n") -- mofan
fwrite("%d%d \n", 1, 2) -- 12
print("---------------- ")

--[[ 
    通常在遍历变长参数的时候只需要使用 {…}，然而变长参数可能会包含一些 nil，
        那么就可以用 select 函数来访问变长参数了：select('#', …) 或者 select(n, …)
            select('#', …) 返回可变参数的长度。
            select(n, …) 用于返回从起点 n 开始到结束位置的所有参数列表。
    调用 select 时，必须传入一个固定实参 selector（选择开关）和一系列变长参数。
    如果 selector 为数字 n，那么 select 返回参数列表中从索引 n 开始到结束位置的所有参数列表，
    否则只能为字符串 #，这样 select 返回变长参数的总数。
 ]]

local function  func(...)
    -- 从第三个位置开始，变量 var 对应右边变量列表的第一个参数
    local var = select(3, ...)
    print(var)
    -- 打印第三个位置后所有列表参数
    print(select(3, ...))
end 

func(1, 2, 3, 4, 5, 6)