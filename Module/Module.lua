-- 这样导入会报错
-- local ma = require(A)

-- Lua 模块加载机制：https://www.runoob.com/lua/lua-modules-packages.html

-- 导入 Module 下的 ModuleA Lua 文件
require "Module.ModuleA"
print(A.constant) -- A 是在 ModuleA.lua 中返回的 table

-- 取一个别名
local ma = require("Module.ModuleA")

ma.funA();
print(ma.constant)
ma.funC()


local mb = require "Module.ModuleB" -- 导入就会执行一次
local mbb = require "Module.ModuleB" -- 同一文件导入多次，就执行一次

-- 使用 dofile 每次导入都会执行
local mc = dofile "Module/ModuleC.lua"
mc.funA()
local mcc = dofile "Module/ModuleC.lua"

-- 使用 loadfile 导入文件时不执行，需要时才执行
local md = loadfile "Module/ModuleD.lua"
local mdd = loadfile "Module/ModuleD.lua"

md() -- 执行
md().funA() -- 执行 D 模块中的 funA