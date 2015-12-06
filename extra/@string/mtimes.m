% mtimes: she = me * he
% join me(string array) with he, return she as a salar string object
% default he is ' ', that means split me string by a space;
%
% maintain: lymslive / 2015-12-06
function she = mtimes(me, he)

if numel(me) == 1
    she = me;
    return;
end

if nargin < 2
    he = ' ';
end
he = char(he);

shestr = me(1).str_;
for i = 2 : numel(me)
    shestr = [shestr, he, me(i).str_];
end
she = string(shestr);

end %F
