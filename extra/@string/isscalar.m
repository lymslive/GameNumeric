% isscalar: if it's a char vector with only one row?
% return a boolean value true/false
%
% the input can also be a cellstr
% then the return value is boolean array with the same size.
%
% maintain: lymslive / 2015-12-06
function tf = isscalar(arg)

if ischar(arg)
    tf = true;
    if size(arg, 1) > 1
        tf = false;
    end
elseif iscellstr(arg)
    for i = numel(arg) : -1 : 1
        tf(i) = string.isscalar(arg{i});
    end
    tf = reshape(tf, size(arg));
else
    tf = false;
end

end %F
