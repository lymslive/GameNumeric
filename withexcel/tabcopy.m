% ���ɾ������ݿ���ϵͳ���а壨�޷���ֵ�����޸���ϵͳ���а壩
% clipboard('copy', data) �� mat2str ת���ַ�����
% ������ [8 1 6;3 5 7;4 9 2] ���ַ���������Ϊ matlab ���������
% �÷���������ת��Ϊ�� \t \n �ָ����ַ��鿽��������ճ���� excel ���ⲿӦ��
%
% ���Ϊ excel ��װ�� Spreadsheet Link EX ���
% �� excel ��һ���ܽϺõ�ֱ�Ӵ� matlab ��������������
% Ȼ��÷������ü��а廹�ܷ����ճ��������Ӧ�ó�����
%
% Ŀǰ֧�����ͣ���ά����cell table
% logical תΪ���� 0/1
%
% maintain: lymslive / 2015-12-07
function tabcopy(data)

if nargin < 1
	error('����������һ������');
end

cstr = '';
TAB = 9;
CR = 10;
% TF = {'false', 'true'};

if isnumeric(data) || islogical(data)
	[m, n] = size(data);
	for i = 1 : m
		for j = 1 : n - 1
			cstr = [cstr num2str(data(i,j)) TAB];
		end
		cstr = [cstr num2str(data(i, end))];
		cstr = [cstr CR];
	end

elseif iscell(data)
	[m, n] = size(data);
	for i = 1 : m
		for j = 1 : n
			val = data{i, j};

			sval = '';
			if isnumeric(val) || islogical(val)
				sval = num2str(val);
			elseif ischar(val)
				sval = val;
			else
				try
					sval = char(val);
				catch
					sval = class(val);
				end
			end

			if j < n
				cstr = [cstr sval TAB];
			else
				cstr = [cstr sval];
			end
		end
		cstr = [cstr CR];
	end

elseif istable(data)
	tabcopy(table2cell(data));
end %if numeric

% ����ϵͳ���а�
clipboard('copy', cstr);

end %of main
