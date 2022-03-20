--[[ 
    [Lua 协同程序(coroutine)](https://www.runoob.com/lua/lua-coroutine.html)
 ]]

local co = coroutine.create(
    function(i)
        print(i);
    end
)
print(coroutine.status(co)) -- suspended
print("type of co is ", type(co)) -- thread
coroutine.resume(co, 1)   -- 1
print(coroutine.status(co))  -- dead

print("---------------- ")

co = coroutine.wrap(
    function(i)
        print(i);
    end
)

co(1)
print("type of co is ", type(co)) -- function

print("---------------- ")

--[[ 
    create 和 wrap 函数在功能上相似，但是它们的返回值是不同的。
    1、create 返回的是一个协同程序，类型为 thread，需要使用 resume 调用；
    2、wrap 返回的是一个普通函数，类型是 function，和普通函数一样的使用方式，但不能使用 resume 调用
 ]]


local co2
co2 = coroutine.create(
    function()
        for i = 1, 10 do
            print(i)
            if i == 3 then
                print(coroutine.status(co2))  -- running
                print(coroutine.running()) -- thread:XXXXXX false
            end
            coroutine.yield()
        end
    end
)

coroutine.resume(co2) --1
coroutine.resume(co2) --2
coroutine.resume(co2) --3

print(coroutine.status(co2))   -- suspended
print(coroutine.running()) -- thread:XXXXXX true

--[[ 
    coroutine.running()：
    返回当前正在运行的协程加一个布尔量。 如果当前运行的协程是主线程，其为真。
 ]]

print("---------------- ")


--[[ 
    1、当执行 create 时，相当于在线程中注册了一个事件；
    2、当执行 resume 触发事件时，前一步 create 的函数将被执行；
    3、当遇到 yield 时就会挂起当前线程，等到下次 resume 触发事件
 ]]

local function foo (a)
    print("foo 函数输出", a)
    return coroutine.yield(2 * a) -- 返回  2*a 的值
end

co = coroutine.create(function (a , b)
    print("第一次协同程序执行输出", a, b) -- co-body 1 10

    local r = foo(a + 1)

    print("第二次协同程序执行输出", r)
    local s
    r, s = coroutine.yield(a + b, a - b)  -- a，b的值为第一次调用协同程序时传入
  
    print("第三次协同程序执行输出", r, s)
    return b, "结束协同程序"                   -- b的值为第二次调用协同程序时传入
end)
    
print("main", coroutine.resume(co, 1, 10)) -- true, 4
print("---------------- ")
print("main", coroutine.resume(co, "r")) -- true 11 -9
print("---------------- ")
print("main", coroutine.resume(co, "x", "y")) -- true 10 end
print("---------------- ")
print("main", coroutine.resume(co, "x", "y")) -- cannot resume dead coroutine
print("---------------- ")

-- resume和 yield 的配合强大之处在于，resume 处于主程中，它将外部状态（数据）传入到协同程序内部；而 yield 则将内部的状态（数据）返回到主程中。

-- resume 和 yield 函数的返回值

co = coroutine.create(function (a)
   local r = coroutine.yield(a + 1) -- yield 返回 a + 1 给调用它的 resume 函数，即 2
   print("r = ", r) -- r 的值是第二次 resume 传进来的 100
end)

local status, r = coroutine.resume(co, 1) -- resume 返回两个值，一个是自身状态，一个是 yield 的值
print(status) -- true
print(r) -- 2
status = coroutine.resume(co, 100)
print(status) -- true
-- resume 调用失败，返回 false，并带上 “cannot resume dead coroutine”。
print(coroutine.resume(co, 10)) -- false    cannot resume dead coroutine
-- 调用失败并将其返回值赋值给其他变量
status, r = coroutine.resume(co, 10)
print(status) -- false
print(r) -- cannot resume dead coroutine

print("---------------- ")

-- yield 的返回值
local cor = coroutine.create(function(a)
    print("参数 a 值为 ", a);
    local b, c = coroutine.yield(a + 3); --这里表示挂起协程，并且将a+1的值进行返回，并且指定下一次唤醒需要 b,c 两个参数。
    print("参数 b,c值分别为 ", b, c); -- b c 的值为当次 resume 唤醒协程时指定的值，即 2 3
    return b * c; --协程结束，并且返回 b*c 的值。
end);

print("第一次调用：", coroutine.resume(cor, 1));
print("第二次调用：", coroutine.resume(cor, 2, 3));
print("第三次调用：", coroutine.resume(cor));


--[[ 
    总结:
    1、coroutine.creat 方法只要建立了一个协程 ，那么这个协程的状态默认就是 suspend。使用 resume 方法启动后，会变成 running 状态；遇到 yield 时将状态设为 suspend；如果遇到 return，那么将协程的状态改为 dead。
    2、coroutine.resume 方法需要特别注意的一点是，这个方法只要调用就会返回一个 boolean 值。
    3、coroutine.resume 方法如果调用成功，那么返回 true；如果有 yield 方法，同时返回 yield 括号里的参数；如果没有 yield，那么继续运行直到协程结束；直到遇到 return，将协程的状态改为 dead，并同时返回 return 的值。
    4、coroutine.resume 方法如果调用失败(调用状态为 dead 的协程会导致失败)，那么返回 false，并且带上一句"cannot resume dead coroutine"
 ]]