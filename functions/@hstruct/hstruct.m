% hstruct: hanldle of struct
% �ṹ��İ�װ��
% �ص㣺
% ���ô��Σ�����ֵ���ݿ���
% �޷��ʿ��ƣ��� struct һ������������
% һ���ñ������󣬶�Ӧһ�� mat �����ļ�
% ������󲻱�֤ÿ�������ڲ��� struct �ṹ��һ��
% ���ֻ�б��������� struct �ź�һһ��Ӧ
%
% ������
% stin_: �ڲ�����һ�� struct
%
% ���캯����
% me = hstruct(st)
% ����һ�� struct ������������ذ�װ��Ķ���
% �ɿղΣ��� struct ���飬�򷵻� hstruct ����ͬά����
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
