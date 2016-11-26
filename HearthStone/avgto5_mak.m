% ��20����5��ƽ����Ҫ���پ�
% ��״̬ת�ƾ��󷨼���
% ���� markovto.m ����

% ���������
%   p ����ʤ�ʣ�Ĭ�� 0.5
%   starts ������������Ĭ�� 60
%     20-15 ÿ��3�ǣ�15-10ÿ��4�ǣ�10-5ÿ��5��
%     ������ʤ2֮�󣬵�3�ֿ�ʼ������2�ǣ��ʱ�������Ϊ p^3
%     (�����Ƕ����¼����ɷ���������ת�ƾ���)
% ���������
%   ƽ������
function count = avgto5_mak(p, stars)

if nargin < 2
    stars = 60;
end

if nargin < 1
    p = 0.5;
end

if ~(p >= 0 && p <= 1)
    error('p should in [0 1] range');
end

% ״̬����Ҫ���ǵ�Ӧ��1
stars = stars + 1;

% ����״̬����
Pmatrix = zeros(stars, stars);

for i = 1 : stars
    if i == 1
        % ��ʼ1��ʱ��ʧ�ܲ�����
        Pmatrix(i, i+1) = p;
        Pmatrix(i, i) = 1-p;

    elseif i == 2
        % 2 ��ʱ������������ʤ
        Pmatrix(i, i+1) = p;
        Pmatrix(i, i-1) = 1-p;

    elseif i == stars
        % ���һ������Ϊ���
        Pmatrix(i, i) = 1;

    elseif i == stars - 1
        Pmatrix(i, i+1) = p;
        Pmatrix(i, i-1) = 1-p;

    else
        % �м��Ǽ�������ʤ����
        Pmatrix(i, i-1) = 1-p;
        Pmatrix(i, i+2) = p^3;
        Pmatrix(i, i+1) = p - p^3;
    end
end

% �������һ��
if any(abs(sum(Pmatrix, 2) - 1) > 1.0e6)
    count = sum(Pmatrix, 2); % ���������ÿ�кͷ��أ����ϲ�ɲ�
    error('Pmatrix is bad');
end

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
