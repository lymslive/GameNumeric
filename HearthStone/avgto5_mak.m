% 从20级打到5级平均需要多少局
% 用状态转移矩阵法计算
% 调用 markovto.m 函数

% 输入参数：
%   p 单局胜率，默认 0.5
%   starts 共需升星数，默认 60
%     20-15 每级3星，15-10每级4星，10-5每级5星
%     假设连胜2之后，第3局开始暴击升2星，故暴击概率为 p^3
%     (暴击非独立事件？可否用马氏链转移矩阵？)
% 输出参数：
%   平均局数
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

% 状态数比要升星的应多1
stars = stars + 1;

% 构建状态矩阵
Pmatrix = zeros(stars, stars);

for i = 1 : stars
    if i == 1
        % 初始1星时，失败不降星
        Pmatrix(i, i+1) = p;
        Pmatrix(i, i) = 1-p;

    elseif i == 2
        % 2 星时还不可能有连胜
        Pmatrix(i, i+1) = p;
        Pmatrix(i, i-1) = 1-p;

    elseif i == stars
        % 最后一星修整为汇点
        Pmatrix(i, i) = 1;

    elseif i == stars - 1
        Pmatrix(i, i+1) = p;
        Pmatrix(i, i-1) = 1-p;

    else
        % 中间星级，有连胜机制
        Pmatrix(i, i-1) = 1-p;
        Pmatrix(i, i+2) = p^3;
        Pmatrix(i, i+1) = p - p^3;
    end
end

% 检查矩阵归一性
if any(abs(sum(Pmatrix, 2) - 1) > 1.0e6)
    count = sum(Pmatrix, 2); % 将错误矩阵每行和返回，让上层可查
    error('Pmatrix is bad');
end

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
