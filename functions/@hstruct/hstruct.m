% hstruct: hanldle of struct
% 结构体的包装类
% 特点：
% 引用传参，减少值传递开销
% 无访问控制，像 struct 一样自由增减域
% 一般用标量对象，对应一个 mat 数据文件
% 数组对象不保证每个对象内部的 struct 结构都一样
% 因此只有标量对象与 struct 才好一一对应
%
% 数据域：
% stin_: 内部保存一个 struct
%
% 构造函数：
% me = hstruct(st)
% 接收一个 struct 输入参数，返回包装后的对象
% 可空参，可 struct 数组，则返回 hstruct 对象同维数组
%
% maintain: lymslive / 2015-12-04
classdef hstruct < handle

properties (Access = protected)
stin_;
end %P

methods
function me = hstruct(st)

if nargin == 0
	st.Class_ = 'hstruct';
elseif ~isstruct(st)
	error('user:hstruct:ctor', 'hstruct ctor expects struct');
end

if numel(st) == 1
	me.stin_ = st;
else
	for i = numel(st) : -1 : 1
		me(i, 1).stin_ = st(i);
	end
	me = reshape(me, size(st));
end

end %ctor
end %M

methods (Static)
hst = loadmat(file, className);
end %M


end %-C main
