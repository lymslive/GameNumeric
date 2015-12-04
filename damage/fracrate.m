% fracrate: fraction equation of rate
% 由对抗属性值计算比率或概率的通用公式
% r = m * x / (x + n*x'), 其中 x 与 x' 分别表示互为对抗的属性
%
% 输入参数：
% @attr: 属性值
% @anti: 反向对抗属性值
% @m: 可选的公式系数 m，表示极限，默认 1
% @n: 可选的公式系数 n，表示反向属性缩放率，默认 1
%
% 返回参数：
% @rate: 计算结果，比率
%
% 说明：
% attr, anti, 须是同维大小的数组或标量，结果 rate 也是同维大小的数组
% 所以函数实现中用 .* ./ 运算
% 一般情况下可能用标量调用
%
% maintain: lymslive / 2015-12
%
function rate = fracrate(attr, anti, m, n)

if nargin < 3
	m = 1;
end
if nargin < 4
	n = 1;
end

rate = m .* attr ./ (attr + n .* anti);

end %-of main
