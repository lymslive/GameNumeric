% struct:
% 返回对象内部的 struct
%
% 如果不是标量对象，默认时返回第一个对象的 struct
% 传入 option = '-cell' 时，
% 返回 cell 数组，对应位置返回对象的 struct
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
