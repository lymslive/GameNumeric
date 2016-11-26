% 从 5 级冲到传说平均需要多少局
% 用简单的递归算式计算

% 数学分析：
% 模型类似有概率失败的强化问题，5级到传说，每级5星，共25星
% 设每局胜率 p，由于匹配机制，可认为在 50% 左右
% 设 x(n) 为从 n 星升到 n+1 星所需的局数
% 1) p 概率胜利，只需1局
% 2) 1-p 概率失败，降一星，共需要 x(n-1) + x(n) + 1 局
% 得到等式：x(n) = p*1 + (1-p)*(x(n-1)+x(n)+1)
% 化简递归式：x(n) = (1-p)/p*x(n-1) + 1/p
% 令 s(n) = sum(x) 从1星升到n+1星所需局数
% s(n) = (1-p)/p*s(n-1) + n/p
% 初始条件：x(1) = 1/p, s(1) = 1/p
%

% 输入参数：
% p 单局胜率，默认 0.5
% starts 共需升星数，默认 25
% 输出参数：
% 平均局数
function count = avg5top_rec(p, stars)

if nargin < 2
    stars = 25;
end

if nargin < 1
    p = 0.5;
end

sprev = 1/p;
sthis = sprev;
for i = 2 : stars
    sthis = (1-p)/p * sprev + i/p;
    sprev = sthis;
end

count = sthis;

end %-of main
