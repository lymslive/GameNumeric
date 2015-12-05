% struct:
% ���ض����ڲ��� struct
%
% ������Ǳ�������Ĭ��ʱ���ص�һ������� struct
% ���� option = '-cell' ʱ��
% ���� cell ���飬��Ӧλ�÷��ض���� struct
%
% maintain: lymslive / 2015-12-04
function st = struct(me, option)

if numel(me) == 1
	st = me.stin_;
else
	if nargin < 2
		st = me(1).stin_;
		warning('user:hstruct:struct', 'only use the first object in array');
	elseif strcmp(option, '-cell')
		st = cell(size(me));
		for i = 1 : numel(me)
			st{i} = me(i).stin_;
		end
	end
end

end %F
