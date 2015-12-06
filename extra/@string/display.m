% function display(me)
% display object in the command window
%
% for scalar me:
% disp the str_ dircetly if it's length < 80, or
% [string: $len] <head part of the string>
%
% for array we:
% first line : [m n] string array, then the next lines:
% var(i): <disp each scala me>
% for very long string list, only disp 10 strings
%
% can receive a output argument:
% return the displayed string incase sacalar me, 
% or the displayed lines count in case of array we.
% but actually no disp message to screen.
%
% optional input argument:
% @maxlen: default 80 character (single string length)
% @maxline: default 10 lines (string object)
%
% maintain: lymslive / 2015-12-06
function out = display(me, maxlen, maxline)

if nargin < 2
    maxlen = 80;
end
if nargin < 3
    maxline = 10;
end

prefix = '[string: %d] ';

if numel(me) == 1
    if me.len <= maxlen
        line = me.str_;
    else
        head = sprintf(prefix, me.len);
        left = me.len - length(head);
        line = [head, me.str_(1:left)];
    end
    if isempty(line)
        line = '<empty string>';
    end
    if nargout == 0
        disp(line);
    else
        out = line;
    end

else
    nme = numel(me);
    name = inputname(1);
    if isempty(name)
        name = 'ans';
    end
    fprintf('%s = %s string object array\n', name, mat2str(size(me)));

    for i = 1 : min(nme, maxline)
        head = sprintf('%s{%d}: ', name, i);
        left = me(i).display(maxlen - length(head));
        line = [head, left];
        if nargout == 0
            disp(line);
        else
            out = i;
        end
    end
end %if me

end %F
