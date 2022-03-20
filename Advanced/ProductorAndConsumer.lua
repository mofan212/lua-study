local newProductor

local function receive()
    local status, value = coroutine.resume(newProductor)
    return value
end

local function send(x)
    coroutine.yield(x)     -- x表示需要发送的值，值返回以后，就挂起该协同程序
end

local function productor()
    local i = 0
    while true do
         i = i + 1
         send(i)     -- 将生产的物品发送给消费者
    end
end

local function consumer()
    while true do
         local i = receive()     -- 从生产者那里得到物品
         print(i)
    end
end


-- 启动程序
newProductor = coroutine.create(productor)
consumer() -- 从 1 开始打印，每次输出加 1，直到人为终止程序