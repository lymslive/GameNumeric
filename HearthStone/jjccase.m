% 计算竞场各种情况的胜率
% 规则：3负或12胜出局

% 共有15种情况：
% i-j 表示 i 胜 j 负，p 表示每局胜率, C(n,k) 表示组合数
% 1) 0-3, (1-p)^3
% 2) 1-3, p*(1-p)^3* C(3,1)
% 3) 2-3, p^2*(1-p)^3*C(4, 2)
% i) i-3, p^i*(1-p)^3*C(i+3-1, i)
% 12) 11-3, p^11*(1-p)^3*C(13,11)
% 13) 12-0, p^12
% 14) 12-1, p^12*(1-p)*C(12,1)
% 15) 12-2, p^12*(1-p)^2*C(13,2)

% 输入参数：
%   胜率 p，可以行向量，同时计算不多个胜率参数
% 输出参数：
%   列表 tab, 15 行对应上述15种情况，各种的概率，每列对应一个胜率p
%   平均胜场 avg
function [tab, avg] = jjccase(p)

if ~isrow(p)
    error('p should a scalar or row vector');
end

n = length(p);
tab = zeros(15, n);
avg = zeros(1, n);

row = 1;
% 负 3 场情况
for i = 1 : 12
    win = i-1;
    lost = 3;
    pthis = p.^win .* (1-p).^lost .* nchoosek(win+lost-1, win);

    tab(row, :) = pthis;
    row = row + 1;

    avg = avg + win * pthis;
end

% 12 胜情况
for j = 1 : 3
    win = 12;
    lost = j - 1;
    pthis = p.^win .* (1-p).^lost .* nchoosek(win+lost-1, lost);

    tab(row, :) = pthis;
    row = row + 1;

    avg = avg + win * pthis;
end

end %-main
