function display(me, maxdisp)
% display cList object.
% the first line print summary information, count and type of element in list.
% and if all the element type is number or string, print then each in one
% line. Optional input 'maxdisp' control print how many elements, 10 default.
% print in stack style, print top first.
%
% maintain: lymslive / 2015-12-09

if nargin < 2
    maxdisp = 10;
end

t = me.type();
if ~t
    t = 'Mixed';
end

fprintf('=cList object, with [%d] elements of <%s> type.\n', me.count, t);

if ~strcmp(t, 'Mixed')
    if isnumeric(me.top())
        s_listNumber(me, maxdisp);
    elseif ischar(me.top())
        s_listString(me, maxdisp);
    end
end

end %F

%% sub functions
% list number content, in reverse order, that
% the top element print first, the bottom last.
% print at most 'maxel' element, if provide the optional input
function s_listNumber(me, maxel)

n = 0;
for i = me.count : -1 : 1
    fprintf('%d:\t%s\n',  i, num2str(me.top(i)));
    n = n + 1;
    if n >= maxel
        break;
    end
end

end %F

% list string content
function s_listString(me, maxel)

n = 0;
for i = me.count : -1 : 1
    str = me.top(i);
    if size(str, 1) > 1
        str = '<NON Scalar String>';
    end
    if length(str) > 72
        str = str(1:72);
    end

    fprintf('%d:\t%s\n',  i, str);

    n = n + 1;
    if n >= maxel
        break;
    end
end

end %F
