% minus: she = me - he
% remove the string he at the end of me, return new string she.
% make + reversible.
% me and she are string object, but he can also be char vector.
%
% option argument:
% -end, default, only remove he at the end
% -begin: only remove he at the beginning
% -both: remove at both end
% -all: remove all occurrences of he at any place
%
% if ommite he or input he as [], set he = ' ' , a white blank;
%
% maintain: lymslive / 2015-12-06
function she = minus(me, he, option)

if nargin < 3
    option = '-end';
end

if numel(me) > 1
    if ~isa(he, 'string')
        he = string(he);
    end
    if numel(he) == 1
        for i = numel(me) : -1 : 1
            she(i) = me(i).minus(he, option);
        end
        she = reshape(she, size(me));
    else
        if any(size(me) ~= size(he))
            error(me.msgid('minus'), ...
            'string me + he, should have the same size');
        end
        for i = numel(me) : -1 : 1
            she(i) = me(i).minus(he(i), option);
        end
        she = reshape(she, size(me));
    end
    return;
end

% for scalar me part:
she = me;
substr = char(he);

if nargin < 2 || isempty(he)
    he = ' ';
end
he = char(he);

start = strfind(me.str_, substr);
if isempty(start)
    return;
end

switch option

case '-end'
    if start(end) - 1 == me.len - length(he)
        she = string(me.str_(1 : start(end)-1));
    end

case '-begin'
    if start(1) == 1
        she = string(me.str_(length(he)+1 : end));
    end

case '-both'
    she = me.minus(he);
    she = she.minus(he, '-begin');

case '-all'
    shestr = strrep(me.str_, he, '');
    she = string(shestr);

otherwise
    error(me.msgid('minus'), 'valid option: -end|-begin|-both|-all');
end

end %F
