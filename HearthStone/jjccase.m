% ���㾺�����������ʤ��
% ����3����12ʤ����

% ����15�������
% i-j ��ʾ i ʤ j ����p ��ʾÿ��ʤ��, C(n,k) ��ʾ�����
% 1) 0-3, (1-p)^3
% 2) 1-3, p*(1-p)^3* C(3,1)
% 3) 2-3, p^2*(1-p)^3*C(4, 2)
% i) i-3, p^i*(1-p)^3*C(i+3-1, i)
% 12) 11-3, p^11*(1-p)^3*C(13,11)
% 13) 12-0, p^12
% 14) 12-1, p^12*(1-p)*C(12,1)
% 15) 12-2, p^12*(1-p)^2*C(13,2)

% ���������
%   ʤ�� p��������������ͬʱ���㲻���ʤ�ʲ���
% ���������
%   �б� tab, 15 �ж�Ӧ����15����������ֵĸ��ʣ�ÿ�ж�Ӧһ��ʤ��p
%   ƽ��ʤ�� avg
function [tab, avg] = jjccase(p)

if ~isrow(p)
    error('p should a scalar or row vector');
end

n = length(p);
tab = zeros(15, n);
avg = zeros(1, n);

row = 1;
% �� 3 �����
for i = 1 : 12
    win = i-1;
    lost = 3;
    pthis = p.^win .* (1-p).^lost .* nchoosek(win+lost-1, win);

    tab(row, :) = pthis;
    row = row + 1;

    avg = avg + win * pthis;
end

% 12 ʤ���
for j = 1 : 3
    win = 12;
    lost = j - 1;
    pthis = p.^win .* (1-p).^lost .* nchoosek(win+lost-1, lost);

    tab(row, :) = pthis;
    row = row + 1;

    avg = avg + win * pthis;
end

end %-main
