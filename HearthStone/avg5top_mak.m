% �� 5 ���嵽��˵ƽ����Ҫ���پ�
% ��״̬ת�ƾ��󷨼���
% ���� markovto.m ����

% ���������
% p ����ʤ�ʣ�Ĭ�� 0.5
% starts ������������Ĭ�� 25
% ���������
% ƽ������
function count = avg5top_mak(p, stars)

if nargin < 2
    stars = 25;
end

if nargin < 1
    p = 0.5;
end

% ״̬����Ҫ���ǵ�Ӧ��1
stars = stars + 1;

Pmatrix = zeros(stars, stars);

% �ɹ�������һ�Ǹ��� p
for i = 1 : stars - 1
    Pmatrix(i, i+1) = p;
end

% ʧ�ܣ���һ�Ǹ��� 1-p
for i = 2 : stars
    Pmatrix(i, i-1) = 1 - p;
end

% ��ʼ״̬���ʾ����һ����
Pmatrix(1,1) = 1-p;
% ��ֹ״̬���ʾ������
Pmatrix(stars, stars) = 1;
Pmatrix(stars, stars-1) = 0;

% ��ʼ״̬
source = 1;
% ��ֹ״̬
target = stars;
% ���ģ��������壬markovto ������Ҫ
lcost = ones(1, stars);

% ����ת�ƾ��󷽷�
[step, stop, cost] = markovto(Pmatrix, source, target, lcost);

% ���ؽ��
count = step;

end %-of main
