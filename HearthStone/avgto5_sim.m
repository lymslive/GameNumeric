% ��20����5��ƽ����Ҫ���پ�
% ��ģ�ⷽ�����
% ���ص���ģ������ľ���
% Ϊ��׼ȷֵ������ģ����ƽ�������� approachmean ����

% ���������
%   p ����ʤ�ʣ�Ĭ�� 0.5
%   starts ������������Ĭ�� 60
%     20-15 ÿ��3�ǣ�15-10ÿ��4�ǣ�10-5ÿ��5��
%     ������ʤ2֮�󣬵�3�ֿ�ʼ������2��
%   maxsim, ���ģ����������������ѭ��
% ���������
%   ƽ������
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

% ��ģ�����
game = 0;
mystar = 0;

% ǰ����ʤ����
winprev = 0;

% ���ģ�������������ѭ��
MAX_SIM_TIME = 1e6;
if nargin >= 3
    MAX_SIM_TIME = maxsin;
end

% ��ģ��ÿһ��
while game < MAX_SIM_TIME
    game = game + 1;

    % �����Ƿ�ʤ��
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

% ���ؽ��
if mystar >= stars
    count = game;
else
    count = 0;
end

end %-of main
