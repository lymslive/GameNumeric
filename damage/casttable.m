% casttable:
% 瀑布概率模型
% 给定一组事件的概率，依次掷骰，决定每个事件是否发生
% 一旦某个事件发生，停止掷骰
% 只要任一概率不大于 1，列表中每个事件都有可能发生
%
% 输入参数：
% @pvector: 概率向量，一维，不区分横向量或列向量
% 输出参数：
% @index: 根据瀑布概率随机选定的数组索引下标，每次调用结果随机不一样
% 如果计算出现异常，index 返回 0，表示无效的数组下标
%
% maintain: lymslive / 2015-12
%
function index = casttable(pvector)

index = 0;
for i = 1 : length(pvector)
	r = rand();
	if r <= pvector(i)
		index = i;
		return;
	end
end

end %-of main
