--[[ 
    �����������+ - * / %
    ���������������
        ^ (����)
        - (�����򸺺�)
        // (���� >= Lua 5.3)
 ]]

print(2^2) -- 4.0
print(-2) -- -2
print(5 // 2) -- 2
print(5 / 2) -- 2.5
print("---------------- ")

--[[ 
    ��ϵ�������== ~= < > <= >=
 ]]
-- ~= ������
print(1 ~= 2) -- true
print("---------------- ")


--[[ 
    �߼��������and or not
    and����� (A and B)���� A Ϊ false���򷵻� A�����򷵻� B��
    or����� (A and B)���� A Ϊ true���򷵻� A�����򷵻� B��
    not�����߼��������෴���������Ϊ true���߼���Ϊ false��
 ]]
-- not ȡ��
print(not(1 and nil)) -- true
print("---------------- ")

--[[ 
    �����������
    1��.. ���������ַ���
    2��# �����ַ������ĳ���
 ]]
print("hello" .. "world") 
local str = "hello world"
local tab = {"v1", "v2"}
print("str length is " .. #str) -- 11
print("table size is " .. #tab) -- 2

local tab2 = {k1 = "v1", k2 = "v2"}
print(tab2.k1) -- v1
print("tab2 size is " .. #tab2) -- 0
print("---------------- ")

--[[ 
    ��������ȼ���
    ^
    not    - (unary)
    *      /       %
    +      -
    ..
    <      >      <=     >=     ~=     ==
    and
    or
 ]]

--[[ 
    ���� number ���͵���ֵ���� and ������������ and �ұ��Ǹ���ֵ��
    ���� or ������������ or ����Ǹ���ֵ��
    ��Ϊ and ���ȼ��� or �ߣ����� and �� or ���������ȼ��� and �ķ���ֵ���ټ��� or ��ֵ��
 ]]

-- ʵ����Ԫ�����
local flag = true
print(flag and "mofan" or "Ĭ��")
print("---------------- ")

-- ʹ�� # �����ȡ��ĳ���
local tab3 = {}
tab3[1] = "1"
tab3[2] = "2"
tab3[4] = "4"
print("tab3 �ĳ��� ", #tab3)  -- 4

local tab4 = {}
tab4[1]="1"
tab4[2]="2"
tab4[5]="5"
print("tab4 �ĳ��� ", #tab4)  -- 2

local tab5 = {1, 2, nil, nil, 5}
print("tab5 �ĳ��� ", #tab5) -- 5

tab5[6] = 1
print("tab5 �ĳ��� ", #tab5) -- 2

-- ʹ�� # ��������� table �ĳ���ʱ������ֵ�ƺ��������������ڴ���