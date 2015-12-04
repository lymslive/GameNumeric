% weight:
% 模拟一次权重互斥的随机事件
%
% 输入参数：
% @wvector: 权重向量，一维，不限行或列向量
% @rate: 可选，'rate' 或 'roll'，默认或省略是 'roll'
% 输出参数：
% @index:
%  如果是默认 roll 方式，则随机选择一个数组下标返回
%  如果是 rate 方式，则将权重转化为概率向量返回
%
% maintain: lymslive / 2015-12
%
function index = weight(wvector, rate)

pvector = wvector / sum(wvector);

if nargin < 2 || strcmp(rate, 'roll')
	psum = 0;
	r = rand();
	for i = 1 : length(pvector)
		psum = psum + pvector(i);
		if r <= psum
			index = i;
			break;
		end
	end
elseif strcmp(rate, 'rate')
	index = pvector;
else
	error('weight(): only support roll/rate for the 2nd option input');
end

end %-of main
