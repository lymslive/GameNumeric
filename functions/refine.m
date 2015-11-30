% refine: refine a curve
% 细化曲线
% 根据一个较粗的曲线表，n*2 数组
% 求出一个细化的曲线表，m*2 数组
%
% 输入参数：
% @short: 两列，第2列是第1列的函数，但只有一些离散的点
%  最好第1列要求单调升序，第2列不能有重复的值
%  每行的两个值相当于组成一个数据点
%
% @option: 额外选项，可选参数
%  .method: 插值方法，同interp1 的 method 参数，默认是 'linear'
%  .addorigin: 是否在 short 首行添加零值 [0, 0]，默认 false
%  .plot: 是否绘图查看插值曲线结果
%
% 输出参数：
% @long: 两列，第1列是细化的自变量，范围从 short 的第1行到最后一行
%  步长默认为1，游戏中涉及的曲线的自变量一般是自然数
%  在 short 数组中未指定的中间点，用插值的方式求出
%
% 其他说明：
% 算法主要调用 interp1 插值函数
%
% maintain: lymslive / 2015-11
function long = refine(short, option)

if nargin < 2
	option = struct;
elseif ~isstruct(option)
	error('refine() expect option as a struct');
end

if size(short, 2) ~= 2
	error('refine() expect a tow-column array as input');
end

if isfield(option, 'addorigin') && option.addorigin
	short = [0, 0; short];
end
if isfield(option, 'method')
	method = option.method;
else
	method = 'linear';
end

n = size(short, 1);

start = short(1, 1);
stop = short(n, 1);

x = [start : stop]';
y = interp1(short(:,1), short(:,2), x, method);

long = [x, y];

if isfield(option, 'plot') && option.plot
	plot(x, y, 'b-', short(:, 1), short(:, 2), 'ro');
end

end %-of main
