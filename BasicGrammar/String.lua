-- �ַ���ȫ��д
print(string.upper("mofan"))

-- �ַ���ȫСд
print(string.lower("MOFAN"))

-- �ַ����滻
print(string.gsub("m_o_f_a_n", "_", "", 3)) -- mofa_n 3
print(string.gsub("m_o_f_a_n", "_", "")) -- mofan 4

-- �����Ӵ�
print(string.find("m_o_f_a_n", "m_o", 1)) -- 1 3
print(string.find("m_o_f_a_n", "_m_o", 1)) -- nil
print(string.find("m_o_f_a_n", "_m_o", 2)) -- nil

-- ��ת�ַ���
print(string.reverse("mofan")) -- nafom

-- �ַ�����ʽ��
print(string.format("the value is: %d", 212))

-- �����������ַ���ת����ASCII��
print(string.char(97, 98, 99, 100)) -- abcd
print(string.byte("abcd", 4)) -- 100
print(string.byte("abcd")) -- 97

-- �ַ�������
print(string.len("mofan")) -- 5

-- �����ַ���
print(string.rep("mofan", 2)) -- mofanmofan
print(string.rep("mofan", 2, ", ")) -- mofan, mofan

-- �ַ�������������
for word in string.gmatch("I am mofan", "%a+") do
     print(word)
     -- I
     -- am
     -- mofan
end

-- �������һ��
print(string.match("I am 20 years old", "%d+ %a+")) -- 20 years
print(string.format("%d, %q", string.match("I am 20 years old", "(%d+) (%a+)"))) -- 20, "years"
print(string.match("I am 20 years old", "%d+ %a+", 15)) -- nil

-- �ַ�����ȡ
--[[ 
    string.sub(s, i [, j])
    s��Ҫ��ȡ���ַ�����
    i����ȡ��ʼλ�á�
    j����ȡ����λ�ã�Ĭ��Ϊ -1�����һ���ַ���
 ]]
print(string.sub("mofan", 1, 2)) -- mo
print(string.sub("mofan", 5, 7)) -- n
print(string.sub("mofan", 1, -2)) -- mofa
print(string.sub("mofan", 6)) -- ���ַ���
print(string.sub("mofan", 100)) -- ���ַ���
print(string.sub("mofan", -5)) -- mofan
print(string.sub("mofan", -100)) -- mofan


local string1 = "Lua"
local string2 = "Tutorial"
local number1 = 10
local number2 = 20
-- �����ַ�����ʽ��
print(string.format("������ʽ�� %s %s",string1,string2)) -- ������ʽ�� Lua Tutorial
-- ���ڸ�ʽ��
local date = 2; local month = 1; local year = 2014
print(string.format("���ڸ�ʽ�� %02d/%02d/%03d", date, month, year)) -- ���ڸ�ʽ�� 02/01/2014
-- ʮ���Ƹ�ʽ��
print(string.format("%.4f",1/3)) -- 0.3333