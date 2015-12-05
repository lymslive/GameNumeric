% savemat: save struct to mat file
% �����ں� struct ���ļ���
%
% ���������
% @file: �ļ���·������ʡ .mat ��׺���Զ���ӣ�����.mat��׺���ظ����
%  ���ṩ file ��ʹ�� stin_.File_ ��ֵ
%  ���Ҳû�� File_ ����ʹ�ö���ı������������� ans
%
% ���������
% @file: ʵ�ʱ����·��ȫ��, 
%
% ������ļ������ File_ ��������������� stin_.File_ �򲻸���
%
% maintain: lymslive / 2015-12-05
function file = savemat(me, file)

if isempty(me.stin_)
	file = [];
	disp('The object seems empty, no need to save');
	return;
end

if nargin < 2 || isempty(file)
	file = me.get('File_');
	if isempty(file)
		file = inputname(1);
	end
	if isempty(file)
		file = 'ans';
	end
end

if ~ischar(file) || size(file, 1) > 1
	error('user:hstruct:savemat', 'expect a string as filename');
end

if length(file) < 5 || ~strcmp(file(end-3:end), '.mat')
	file = [file, '.mat'];
end

st = me.struct();
if ~strcmp(me.get('File_'), file)
	st.File_ = file;
end
save(file, '-struct', 'st');

end %F
