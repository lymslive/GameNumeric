% casttable:
% �ٲ�����ģ��
% ����һ���¼��ĸ��ʣ���������������ÿ���¼��Ƿ���
% һ��ĳ���¼�������ֹͣ����
% ֻҪ��һ���ʲ����� 1���б���ÿ���¼����п��ܷ���
%
% ���������
% @pvector: ����������һά�������ֺ�������������
% ���������
% @index: �����ٲ��������ѡ�������������±꣬ÿ�ε��ý�������һ��
% �����������쳣��index ���� 0����ʾ��Ч�������±�
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
