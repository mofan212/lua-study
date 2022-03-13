-- 一维数组
local array = {"My", "name", "is", "mofan"}
for i = 0, 2 do
    print(array[i])
    -- nil 
    -- My
    -- name
end

array = {}

for i= -2, 2 do
   array[i] = i *2
end

for i = -2, 2 do
   print(array[i])
   -- -4
   -- -2
   -- 0
   -- 2
   -- 4
end

for i = 1, 5 do
    print(array[i])
    -- 2
    -- 4
    -- nil
    -- nil
    -- nil
 end

-- 多维数组
array = {}
for i = 1, 3 do
   array[i] = {}
      for j = 1, 3 do
         array[i][j] = i * j
      end
end

for i = 1, 3 do
   for j = 1, 3 do
      print(array[i][j])
   end
end
print("---------------- ")

array = {}
local maxRows = 3
local maxColumns = 3
for row = 1, maxRows do
   for col = 1, maxColumns do
      array[row * maxColumns + col] = row * col
   end
end

-- 访问数组
for row = 1, maxRows do
   for col = 1, maxColumns do
      print(array[row * maxColumns + col])
   end
end