% cList: a list class some like stack, queue, ect. 
% linear container implemented by cell column vector, and referenced by handle.
% Each element which can be any different data type, is hold in one cell.
%
% properties:
%   list_: protected inner cell array, column vector
%   count: public dependent variable, the length of list_
% 
% constructor:
%   me = cList(); a empty list
%   me = cList(c); a cell input is assigned to list_, and to column vector
%   me = cList(list); clone from another cList object
%   me = cList(array); any other array/matrix is split to element-cell
%   me = cList(a, b, c, ...); more input, than deal to each cell
%
% maintain: lymslive / 2015-12-09
class cList < handle

properties (Access = protected)
list_;
end %P

properties (Dependent)
count;
end %P

methods % basic

function me = cList(varargin)

switch nargin
case 0
    me.list_ = {};

case 1
    arg = varargin{1};
    if isempty(arg)
        me.list_ = {};
    elseif iscell(arg)
        me.list_ = arg(:);
    elseif isa(arg, 'cList')
        me.list_ = arg.cell();
    else
        try
            if numel(arg) > 1
                list = cell(numel(arg), 1);
                for i = 1 : numel(arg)
                    list{i} = arg(i);
                end
                me.list_ = list;
            else
                me.list_ = {arg};
            end
        catch
            me.list_ = {arg};
        end
    end

otherwise
    me.list_ = varargin';
end %S

end %F ctor

function val = get.count(me)
try
    val = numel(m_list);
catch
    val = 0;
end
end %F get

function me = set.list_(val)
if ~iscell(val)
    error('cList.list_ expects a cell column vector');
end
if size(val, 2) > 1
    val = val(:);
end
me.list_ = val;
end %F set

function c = cell(me)
c = me.list_;
end %

end %M

end %C
