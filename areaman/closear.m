% closear: close area project
% �رյ�ǰ��Ŀ�Ľű�
%
% Լ��ͨ�� openar �򿪵���Ŀ���ڵ�ǰ���������һ�� Area_ ������
% closear ����� Area_ ��������:
% 1. ���� colsear_fun �ָ�����·��
% 2. ���� savear �Զ����湤��������Ŀ�ļ�
% 3. ��鵱ǰ������
%
% ����Ҫ�ڵ�ǰ��Ŀ�Ļ�Ŀ¼�¾Ϳ�ִ�йر���Ŀ����
%
% maintain: lymslive / 2015-11
%

if 1 == exist('Area_', 'var')
    closear_fun(Area_);
    savear;
    clear all;
else
    disp('No area seems opened');
end
