Rectangle = {area = 0, length = 0, breadth = 0}

function Rectangle:new (o,length,breadth)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.length = length or 0
  self.breadth = breadth or 0
  self.area = length*breadth;
  return o
end

function Rectangle:printArea ()
  print("矩形面积为 ",self.area)
end
-- 创建

local r = Rectangle:new(nil, 2, 3);
local p = Rectangle:new(nil, 4, 5);

-- 输出

r:printArea(); -- 20
p:printArea(); -- 20


local Rect = {area = 0,length = 0,windth = 0}
function Rect:new(length,windth)
  local t = {}
  setmetatable(t,self)
  self.__index = self
  t.length = length
  t.windth = windth
  t.area = t.length * t.windth
  return t
end

function Rect:ShowArea()
    print(self.area)
end

local a = Rect:new(1,2)
local b = Rect:new(3,4)
a:ShowArea() -- 2
b:ShowArea() -- 12
-- 打印出的地址不一样
print(a)
print(b)

--[[ 
    Rect 作为 new 出来的表(楼上代码写的 a 和 b)的元表：由于没有设置 __newindex 元方法。
        所以 a 和 b 在赋值的时候把长和宽的值赋给了自己，并没有把值赋给 Rect (也就是说 Rect 表中的数据一直都没有改变过)。
    a 和 b 在调用 ShowArea 方法的时候，自己的表里没有这个方法，会到元表中寻找这个方法，元表(Rect)中设置了 __index 元方法，所以能找到 ShowArea 这个方法，然后调用。
    (注意这里是 a 和 b 调用的 ShowArea 方法，所以 ShowArea 方法中 self 指向的是 a 和 b，而不是 Rect)。
 ]]