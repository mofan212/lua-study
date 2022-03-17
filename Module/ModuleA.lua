--[[ 
    1、模块类似于一个封装库，从 Lua 5.1 开始，Lua 加入了标准的模块管理机制。
    2、Lua 的模块是由变量、函数等已知元素组成的 table，因此创建一个模块很简单，就是创建一个 table，
        然后把需要导出的常量、函数放入其中，最后返回这个 table 就行。
 ]]


-- 定义一个名为 A 的模块
A = {}

A.constant = "I am a Constant"


function A.funA()
    io.write "funA in the module A \n"
end

-- 不能从外部访问模块里的这个私有函数
local function funB()
    print "I am a private function"
end

-- 可以通过公有函数调用私有函数
function A.funC()
    funB()
end

return A;