% isfield: 
% 判断一个 name 或 cellstr 是否所含结构体的域
%
% maintain: lymslive / 2015-12-09
function tf = isfield(me, name)

Names = me.fieldnames();
tf = ismember(name, Names);

end %F
