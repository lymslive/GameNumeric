% mrdivide: she = me / he
% split me with he, return she as string object array
% default he is '\s+', that means split me string by any white space;
% me must be a scalar string
%
% maintain: lymslive / 2015-12-06
function she = mrdivide(me, he)

if numel(me) > 1
    error(me.msgid('mrdivide'), 'string/substr only support scalar string');
end

if nargin < 2
    he = '\s+';
end

he = char(he);
sp = regexp(me.str_, he, 'split');
she = string(sp);

end %F
