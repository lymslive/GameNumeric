% isfield: 
% �ж�һ�� name �� cellstr �Ƿ������ṹ�����
%
% maintain: lymslive / 2015-12-09
function tf = isfield(me, name)

Names = me.fieldnames();
tf = ismember(name, Names);

end %F
