% 从 5 级冲到传说平均需要多少局
% 用状态转移矩阵法计算
% 调用 markovto.m 函数

% 输入参数：
% p 单局胜率，默认 0.5
% starts 共需升星数，默认 25
% 输出参数：
% 平均局数
function count = avg5top_mak(p, stars)

if nargin < 2
    stars = 25;
end

if nargin < 1
    p = 0.5;
end

% 状态数比要升星的应多1
stars = stars + 1;

Pmatrix = zeros(stars, stars);

% 成功升到下一星概率 p
for i = 1 : stars - 1
    Pmatrix(i, i+1) = p;
end

% 失败，降一星概率 1-p
for i = 2 : stars
    Pmatrix(i, i-1) = 1 - p;
end

% 初始状态概率矩阵归一调整
Pmatrix(1,1) = 1-p;
% 终止状态概率矩阵调整
Pmatrix(stars, stars) = 1;
Pmatrix(stars, stars-1) = 0;

% 起始状态
source = 1;
% 终止状态
target = stars;
% 消耗，此无意义，markovto 方法需要
lcost = ones(1, stars);

% 调用转移矩阵方法
[step, stop, cost] = markovto(Pmatrix, source, target, lcost);

% 返回结果
count = step;

end %-of main
