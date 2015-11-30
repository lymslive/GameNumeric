% 将父目录加入搜索路径，测试父目录写的函数
addpath([pwd, filesep, '..']);

% 假设某个坑，先初步设定填到10级、20级……100级需要多少天
% 然后据此精算细化，每级升级需要多少时间，时间需求是经验需求的基础
rough = [
10, 1;
20, 2;
30, 4;
40, 8;
50, 15;
60, 25;
70, 40;
80, 60;
90, 90;
100, 150;
];

disp('初设的曲线，限定一些关键节点');
display(rough);

% 细化就是插值的问题，调用父目录中的 refine 方法，它内部主要也是调用 interp1
fine = refine(rough);
disp('直接调用细化函数：> fine = refine(rough);');
disp('可以在工作区查看变量 fine 的值，或 plot 绘图可视化观察结果');

% fine 得到的结果是从10级到100级各需要多少时间，两列的表格
% 可以用 plot 绘图查看结果
figure(1);
plot(fine(:,1), fine(:,2));

pause = input('按回车继续：');

% 定制额外选项，起始插入原点，并直接绘图
disp('% 定制额外选项，起始插入原点，并直接绘图');
option.addorigin = true;
option.plot = true;
figure(2); % 绘在另一个图窗上
fine = refine(rough, option);

pause = input('按回车继续：');

% 使用其他插值方法，如样条插值
disp('改用样式插值方式：option.method = spline');
option.method = 'spline';
figure(1);
fine = refine(rough, option);

pause = input('按回车继续：');

% 注意，此时计算的 fine 是升级总时间
% 如果需要得到从每级升到下一级的时间，只需错位减去上一行的值，最后会少一行
disp('错位相减，得到每级升级时间');
uptime = fine([1:end-1], 1);
uptime(:, 2) = fine([2:end], 2) - fine([1:end-1], 2);
figure(2);
plot(uptime(:,1), uptime(:,2));

% 示例结束，取消父目录路径
disp('示例结束');
rmpath([pwd, filesep, '..']);
