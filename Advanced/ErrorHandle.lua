-- 使用 assert 进行错误处理
local function add(a,b)
    assert(type(a) == "number", "a 不是一个数字")
    assert(type(b) == "number", "b 不是一个数字")
    return a + b
end

-- add(10)

-- assert 首先检查第一个参数，若没问题，assert 不做任何事情；否则，assert 以第二个参数作为错误信息抛出。

-- 使用 error 进行错误处理
local function errorFun(a, b)
    error("error handle")
    return a -b
end

-- print(errorFun(3, 1))


-- pcall
if pcall(add, 1, 2) then
    print("no error")
else
    print "error"    
end

local status, errorInfo = pcall(errorFun, 3, 1)
print(status) -- false
print(errorInfo) -- 存在错误返回错误信息
local sum
status, sum = pcall(add, 3, 4)
print(status) -- true
print(sum) -- 没有错误返回正确结果 7

--[[ 
     xpcall（相比 pcall 可以传递一个错误处理函数）
    错误处理函数的参数为错误信息，且只能有一个参数
 ]]
local function myerrorhandler(err)
    print( "ERROR:", err )
end

status = xpcall(errorFun, myerrorhandler, 3, 1)
print(status) -- false