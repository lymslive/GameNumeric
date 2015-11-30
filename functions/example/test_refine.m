% ����Ŀ¼��������·�������Ը�Ŀ¼д�ĺ���
addpath([pwd, filesep, '..']);

% ����ĳ���ӣ��ȳ����趨�10����20������100����Ҫ������
% Ȼ��ݴ˾���ϸ����ÿ��������Ҫ����ʱ�䣬ʱ�������Ǿ�������Ļ���
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

disp('��������ߣ��޶�һЩ�ؼ��ڵ�');
display(rough);

% ϸ�����ǲ�ֵ�����⣬���ø�Ŀ¼�е� refine ���������ڲ���ҪҲ�ǵ��� interp1
fine = refine(rough);
disp('ֱ�ӵ���ϸ��������> fine = refine(rough);');
disp('�����ڹ������鿴���� fine ��ֵ���� plot ��ͼ���ӻ��۲���');

% fine �õ��Ľ���Ǵ�10����100������Ҫ����ʱ�䣬���еı��
% ������ plot ��ͼ�鿴���
figure(1);
plot(fine(:,1), fine(:,2));

pause = input('���س�������');

% ���ƶ���ѡ���ʼ����ԭ�㣬��ֱ�ӻ�ͼ
disp('% ���ƶ���ѡ���ʼ����ԭ�㣬��ֱ�ӻ�ͼ');
option.addorigin = true;
option.plot = true;
figure(2); % ������һ��ͼ����
fine = refine(rough, option);

pause = input('���س�������');

% ʹ��������ֵ��������������ֵ
disp('������ʽ��ֵ��ʽ��option.method = spline');
option.method = 'spline';
figure(1);
fine = refine(rough, option);

pause = input('���س�������');

% ע�⣬��ʱ����� fine ��������ʱ��
% �����Ҫ�õ���ÿ��������һ����ʱ�䣬ֻ���λ��ȥ��һ�е�ֵ��������һ��
disp('��λ������õ�ÿ������ʱ��');
uptime = fine([1:end-1], 1);
uptime(:, 2) = fine([2:end], 2) - fine([1:end-1], 2);
figure(2);
plot(uptime(:,1), uptime(:,2));

% ʾ��������ȡ����Ŀ¼·��
disp('ʾ������');
rmpath([pwd, filesep, '..']);
