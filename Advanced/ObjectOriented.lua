-- 作为一个 Javaer，没啥比面向对象更熟悉的了

-- 模拟调用对象的方法

Account = {balanve = 0}

function Account.withdraw(v)
    Account.balanve = Account.balanve - v
end

Account.withdraw(10)
print(Account.balanve) -- -10
print("---------------- ")


-- 元类
Shape = {area = 0}
-- 基础类方法 new
function Shape:new (o,side)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  side = side or 0
  self.area = side*side;
  return o
end
-- 基础类方法 printArea
function Shape:printArea ()
  print("面积为 ", self.area)
end

-- 创建对象
local myshape = Shape:new(nil,10)
myshape:printArea() -- 100

Square = Shape:new()

-- 派生类方法 new
function Square:new (o,side)
  o = o or Shape:new(o,side)
  setmetatable(o, self)
  self.__index = self
  return o
end

-- 派生类方法 printArea（重写基础类的函数）
function Square:printArea ()
  print("正方形面积为 ", self.area)
end

-- 创建对象
local mysquare = Square:new(nil,10)
mysquare:printArea() -- 100

Rectangle = Shape:new()
-- 派生类方法 new
function Rectangle:new (o,length,breadth)
  o = o or Shape:new(o)
  setmetatable(o, self)
  self.__index = self
  self.area = length * breadth
  return o
end

-- 派生类方法 printArea
function Rectangle:printArea ()
  print("矩形面积为 ", self.area)
end

-- 创建对象
local myrectangle = Rectangle:new(nil,10,20)
myrectangle:printArea() -- 200
print("---------------- ")

--[[ 
    . 与 : 的区别在于使用 : 定义的函数隐含 self 参数，使用 : 调用函数会自动传入 table 至 self 参数。
 ]]


-- 示例的优化，不必每次 new 是都将第一个变量的值设置为 nil
--创建一个类，表示四边形
local RectAngle = { } --声明类名和类成员变量

function RectAngle:new (len, wid) --声明新建实例的 new 方法
    local o = {
    --设定各个项的值
        length = len or 0,
        width = wid or 0,
        area = len * wid
    }
    setmetatable(o, {__index = self} ) --将自身的表映射到新 new 出来的表中
    return o
end

function RectAngle:getInfo() --获取表内信息的方法
    return self.length, self.width, self.area
end


local a = RectAngle:new(10,20)
print(a:getInfo())      -- 10    20    200
local b = RectAngle:new(10,10)
print(b:getInfo())      -- 10    10    100
print(a:getInfo())      -- 10    20    200