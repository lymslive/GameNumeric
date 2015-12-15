function tf = iscellof(c, name)
% test if all the content in cell c is the same datatype
%
% Usege:
%  tf = iscellof(c, classname)
%  tf = iscellof(c, checkfun)
%
% Input:
%  c, is a cell variable, or return tf = false.
%  name; is a classname, char array('double') or function handle (@isnumeric)
%
% Ountput:
%  tf, ture/false
%
% maintain: lymslive / 2015-12-15

error(nargchk(2, 2, nargin));

tf = true;

if ~iscell(c)
    tf = false;
    return;
end

validateattributes(name, {'function_handle', 'char'}, ...
    {}, mfilename, 'name', 2);

for i = 1 : numel(c)
    if isa(name, 'function_handle')
        if ~name(c{i})
            tf = false;
            return;
        end
    else
        if ~strcmp(class(c{i}), name)
            tf = false;
            return;
        end
    end
end


end %F
