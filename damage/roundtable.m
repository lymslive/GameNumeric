% roundtable:
% 圆桌概率模型
% 给定一组事件的概率，一次掷骰，决定随机发生哪个事件
% 如果排在前面某些事件的概率和超过 1，则排在后面的事实永远不会发生
%
% 输入参数：
% @pvector: 概率向量，一维，不区分横向量或列向量
% 输出参数：
% @index: 根据圆桌概率随机选定的数组索引下标，每次调用结果随机不一样
% 如果计算出现异常，index 返回 0，表示无效的数组下标
%
% maintain: lymslive / 2015-12
function index = roundtable(pvector)

r = rand();
index = 0;
psum = 0;

for i = 1 : length(pvector)
	psum = psum + pvector(i);
	if r <= psum
		index = i;
		return;
	end
end

end %-of main
