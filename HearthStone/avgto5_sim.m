% 从20级打到5级平均需要多少局
% 用模拟方法求解
% 返回单次模拟所需的局数
% 为求准确值，需多次模拟求平均，可用 approachmean 驱动

% 输入参数：
%   p 单局胜率，默认 0.5
%   starts 共需升星数，默认 60
%     20-15 每级3星，15-10每级4星，10-5每级5星
%     假设连胜2之后，第3局开始暴击升2星
%   maxsim, 最大模拟次数，避免可能死循环
% 输出参数：
%   平均局数
function count = avgto5_sim(p, stars, maxsim)

if nargin < 2
    stars = 60;
end

if nargin < 1
    p = 0.5;
end

if ~(p >= 0 && p <= 1)
    error('p should in [0 1] range');
end

% 已模拟局数
game = 0;
mystar = 0;

% 前置连胜次数
winprev = 0;

% 最大模拟次数，避免死循环
MAX_SIM_TIME = 1e6;
if nargin >= 3
    MAX_SIM_TIME = maxsin;
end

% 逐步模拟每一局
while game < MAX_SIM_TIME
    game = game + 1;

    % 本局是否胜利
    if rand() <= p
        win = 1;
        winprev = winprev + 1;
        if winprev >= 3
            mystar = mystar + 2;
        else
            mystar = mystar + 1;
        end

        if mystar >= stars
            break;
        end
    else
        win = 0;
        winprev = 0;
        mystar = mystar - 1;

        if mystar < 0
            mystar = 0;
        end
    end
end

% 返回结果
if mystar >= stars
    count = game;
else
    count = 0;
end

end %-of main
