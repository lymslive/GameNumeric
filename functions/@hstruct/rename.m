function tf = rename(me, oldfield, newfield)
% rename a field in the struct.
% the old and new field names must be vaild string for varname
%
% maintain: lymslive / 2015-12-11

tf = false;

if nargin < 3
    error('rename@hstruct: require two extra input as old and new field names');
elseif ~isvarname(oldfield) || ~isvarname(newfield)
    error('rename@hstruct: expects scalar string for valid field name');
end

val = me.get(oldfield);
if isempty(val)
    fprintf('rename@hstrunt: No such field: %s\n', oldfield');
    return;
end

if ~isempty(me.get(newfield))
    fprintf('rename@hstrunt: Already have the field: %s\n', newfield');
    return;
end

try
    me.set(newfield, val);
    me.set(oldfield, []);
    fprintf('rename@hstrunt: Rename field %s --> %s\n', oldfield, newfield');
    tf = true;
catch
    fprintf('rename@hstrunt: Fails to rename field %s --> %s\n', oldfield, newfield');
end

end %F
