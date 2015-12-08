% xwsave：脚本，不是函数，保存当前工作区的变量至一个 xml 文件中
% 仅支持矩阵，简单内容的元胞矩阵，字符串，与struct
% 因无法提供参数，保存在默认文件名中 mworkspace.xml
% 本脚本新增变量采用前后缀 _ 以示区别
%
% see also: xsave, 函数式保存，需提供待保存变量
% lymslive / 2015-01

x_who_ = whos;

x_file_ = 'mworkspace.xml';
x_root_ = 'Matlab';

x_m_ = length(x_who_);
x_args_ = {};
for x_i_ = 1 : x_m_
	switch x_who_(x_i_).class
	case {'char', 'double', 'cell', 'struct', 'logical'}
		x_args_ = [x_args_, {eval(x_who_(x_i_).name), x_who_(x_i_).name, ''}];
	otherwise
		disp(['undealabel variabel is igored: ' x_who_(x_i_).name]);
	end
end

xsave(x_file_, x_root_, x_args_{:});

% cleal all variables x_xxx_
clear('-regexp', '^x_.*_$');
