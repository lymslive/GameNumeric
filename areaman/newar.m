% newpar: new area
% ��������Ŀ�ű�
% 
% �ڵ�ǰĿ¼�½�һ�� area������ newar_fun() ��ɴ󲿷ֹ���
% Ȼ��򿪸���Ŀ
%
% �½���Ŀ���ڵ�ǰĿ¼�����������ļ�
% *_ar.mat, *_ws.mat, * ǰ׺���ǵ�ǰĿ¼��
%
% ����Ŀ�����ڵ�ǰ����������һ�� Area_ ����
%
% �����ǰĿ¼�Ѿ��� *_ar.mat ���򲻻��½���Ŀ
%
% maintain: lymslive / 2015-11

if length(dir('*_ar.mat')) > 0
	disp('Area already exists, use `openar` to open it');
else
	newar_fun();
	openar;
end
