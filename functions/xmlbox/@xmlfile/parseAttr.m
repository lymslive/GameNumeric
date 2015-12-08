% ��̬����������һ��"����=ֵ"��
% ����һ�� struct
% ���������������ԣ�ֵ����ת��Ϊdouble������ char
% ��������� notrans Ϊ ture, ��ת������ֵ
function st = parseAttr(str, notrans)

	if nargin < 2
		notrans = false;
	end

	tok = regexp(str, xmlfile.patAttris, 'tokens');
	if isempty(tok)
		st = [];
		return;
	else
		for i = 1 : length(tok)
			pair = tok{i};
			name = pair{1};
			value = pair{2};

			if ~notrans
				dval = str2double(value);
				if ~isnan(dval)
					value = dval;
				end
			end

			st.(name) = value;
		end
	end
end
