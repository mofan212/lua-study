--[[ 
    1��Lua �еĺ��������� Java �еķ���
    2�������ʽ��
            optional_function_scope function function_name (arg1, arg2, arg3..., argn)
                function_body
                return result_params_comma_separated
            end
        optional_function_scope: ָ��������ȫ�ֺ������Ǿֲ�������δ���øò���Ĭ��Ϊȫ�ֺ�����
            ����ʹ�ùؼ��� local ���ú���Ϊ�ֲ�������
        function_name: �������ơ�
        arg1, arg2, arg3..., argn: ������������������Զ��Ÿ�����Ҳ����û�в�����
        function_body: �����壬��������Ҫִ�еĴ������顣
        result_params_comma_separated: ��������ֵ��Lua ���Ժ������Է��ض��ֵ��ÿ��ֵ�Զ��Ÿ�����
    3���� Lua �п��Խ�һ��������Ϊ��һ�������Ĳ�����
    4��Lua �ĺ������Խ��ܿɱ���Ŀ�Ĳ������� C �������ƣ��ں��������б���ʹ������ ... ��ʾ�����пɱ�Ĳ�����    
    5������ͨ�� select("#",...) ����ȡ�ɱ����������
    6�����������м����̶��������Ͽɱ���������̶�����������ڱ䳤����֮ǰ
 ]]

--  ��һ��������Ϊ��һ�������Ĳ���
local myprint = function (param)
    print("�Զ����ӡ���� - ## ", param, "##")
end
local function add(n1, n2, printFunc)
    local result = n1 + n2
    printFunc(result)
end

myprint(10)
add(1, 2, myprint)
print("---------------- ")

-- �෵��ֵ
local function twoReturnValue(a, b)
    return a + 1, b + 2
end

local r1, r2 = twoReturnValue(1, 2)
print("return1 = " .. r1 .. ", return2 = " .. r2)
print("---------------- ")

-- �ɱ����
local function average(...)
    local result = 0;
    local arg = {...}
    for index, value in ipairs(arg) do
        result  = result + value
    end
    -- ���ַ�ʽ��ȡ���������ĸ���
    print("���� " .. #arg .. "����")
    print("���� " .. select("#",...) .. "����")
    return result / #arg
end

print("ƽ��ֵΪ " .. average(1, 2, 3, 4, 5))
print("---------------- ")

-- �̶�������ɱ����
local function fwrite(fmt, ...)
    return io.write(string.format(fmt, ...))
end
fwrite("mofan \n") -- mofan
fwrite("%d%d \n", 1, 2) -- 12
print("---------------- ")

--[[ 
    ͨ���ڱ����䳤������ʱ��ֻ��Ҫʹ�� {��}��Ȼ���䳤�������ܻ����һЩ nil��
        ��ô�Ϳ����� select ���������ʱ䳤�����ˣ�select('#', ��) ���� select(n, ��)
            select('#', ��) ���ؿɱ�����ĳ��ȡ�
            select(n, ��) ���ڷ��ش���� n ��ʼ������λ�õ����в����б�
    ���� select ʱ�����봫��һ���̶�ʵ�� selector��ѡ�񿪹أ���һϵ�б䳤������
    ��� selector Ϊ���� n����ô select ���ز����б��д����� n ��ʼ������λ�õ����в����б�
    ����ֻ��Ϊ�ַ��� #������ select ���ر䳤������������
 ]]

local function  func(...)
    -- �ӵ�����λ�ÿ�ʼ������ var ��Ӧ�ұ߱����б�ĵ�һ������
    local var = select(3, ...)
    print(var)
    -- ��ӡ������λ�ú������б����
    print(select(3, ...))
end 

func(1, 2, 3, 4, 5, 6)