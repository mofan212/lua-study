--[[ 
    1�����ƽṹ���������ʽ����������κ�ֵ��Lua ��Ϊ false �� nil Ϊ�٣�true �ͷ� nil Ϊ��
    2��ע�⣺Lua �е����� 0 Ҳ�� true
 ]]
if 0 then
    print("0 Ҳ�� true")
end
print("---------------- ")

-- if..else
local a = 100
if a < 100 then
    print("a С�� 100")
else
    print("a ��С�� 100")
end
print("---------------- ")

-- if..elseif..else
local b = 100
if b > 1000 then
    print("b ���� 1000")
elseif b > 100 then
    print("b ���� 100")
else
    print("b ���� 10")
end

-- �� Java һ����Lua Ҳ֧�� if Ƕ�����