function c = cellin(varargin)
% put any variable in cell, element by element, or input by input.
%
% Useage:
%  c = cellin(array); 
%    put each element in array to each cell in c, which has the same size.
%  c = cellin(arg1, arg2, argi, ...);
%    put each argin to a cell row vector, whoes length is nargin.
%
% Remark:
%  1. if the only input arg is already cell, return itself
%  2. if no input at all, return a empty cell, as called cell(0)
%  3. if the only input arg is char matrix, call cellstr
%
% Seealso:
%  num2cell dose nearly the same thing, but the name is confuse, as
%  it convert not only number but any other array to cell array.
%
% maintain: lymslive / 2015-12-15

switch nargin
case 0
    c = cell(0);

case 1
    arg = varargin{1};
    if iscell(arg)
        c = arg;
    elseif ischar(arg)
        c = cellstr(arg);
    else
        n = numel(arg);
        c = cell(n, 1);
        for i = 1 : n
            c{i} = arg(i);
        end
        c = reshape(c, size(arg));
    end

otherwise
    c = cell(1, nargin);
    for i = 1 : nargin
        c{i} = varargin{i};
    end

end %switch

end %F main
