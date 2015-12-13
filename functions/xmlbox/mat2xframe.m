function xmlstr =  mat2xframe(leader, var, name)
% investigate a matlab variable's class, size, struct, and so on,
% and save these infor mation in xml format.
%
% Input:
%   leader, required, how many indention, nest struct level indication;
%   var, required, a sopported matlab variable;
%   name, optional, the name of the variable, scalar string.
%     if ommited, it may use the variable name itself, or it's class.
%
% Ouput:
%   xmlstr, a string in xml format. It would be a valid xml document, 
%   with name as the tag of root, that describe information of the variable,
%   but contain no actually data value.
%
% maintain: lymslive / 2012-12-12

Debug = false;
if Debug && nargin < 1
    s_test();
    xmlstr = '<debug test="true"/>';
    return;
end

if ~isnumeric(leader) || numel(leader) > 1
    error('expects a scalar number');
end

if nargin < 3
    name = inputname(2);
end

clsname = class(var);
if ~isvarname(name)
    name = clsname;
end

strsize = mat2str(size(var));

if isempty(var)
    xmlstr = sprintf('<%s class="%s" isempty="true"/>', name, clsname);
    return;
elseif numel(var) > 1
    openstr = sprintf('<%s class="%s" size="%s"', name, clsname, strsize);
else
    openstr = sprintf('<%s class="%s"', name, clsname);
end

indenstr = char(9);
leadstr = repmat(indenstr, 1, leader);

openline = [leadstr, openstr];

if isstruct(var)
    namelist = fieldnames(var);
    n = numel(namelist);

    openline = sprintf('%s feilds="%d">\n', openline, n);
    xml = cList();
    xml.push(openline);

    leader = leader + 1;
    for i = 1 : n
        xfield = mat2xframe(leader, var(1).(namelist{i}), namelist{i});
        linestr = sprintf('%s\n', xfield);
        xml.push(linestr);
    end

    closeline = sprintf('%s</%s>', leadstr, name);
    xml.push(closeline);

    xmlstr = xml.cat();
    return;

elseif iscell(var)
    openline = sprintf('%s>\n', openline);
    xml = cList();
    xml.push(openline);

    leader = leader + 1;
    for i = 1 : numel(var)
        xcell = mat2xframe(leader, var{i}, 'cell');
        linestr = sprintf('%s\n', xcell);
        xml.push(linestr);
    end

    closeline = sprintf('%s</%s>', leadstr, name);
    xml.push(closeline);

    xmlstr = xml.cat();

elseif exist('istable', 'builtin') == 5 && istable(var)
    openline = sprintf('%s">\n', openline);
    xml = cList();
    xml.push(openline);

    namelist = var.Properties.VariableNames;
    n = numel(namelist);
    leader = leader + 1;
    for i = 1 : n
        xtabvar = mat2xframe(leader, var.(i), namelist{i});
        linestr = sprintf('%s\n', xtabvar);
        xml.push(linestr);
    end

    closeline = sprintf('%s</%s>', leadstr, name);
    xml.push(closeline);

    xmlstr = xml.cat();

% simple variable:
else
    xmlstr = sprintf('%s/>', openline);
end

end %F main

%%----- debug test -----%%
%{ delete the space between % adn { to comment the entire function below
function s_test()

a = 10; b = 3.14;
c = magic(3);
d = 'string';
e = ['mat'; 'exe'; 'xml'];
f = {a, b; d, d};
s.a = a;
s.b = b;
s.c = c;
s.d = d;
s.e = e;
s.f = f;

a,
xmlstr = mat2xframe(0, a, 'varA'),
b,
xmlstr = mat2xframe(0, b, 'varB'),
c,
xmlstr = mat2xframe(1, c, 'magic'),
d,
xmlstr = mat2xframe(0, d, 'varD'),
e,
xmlstr = mat2xframe(0, e, 'varE'),
f,
xmlstr = mat2xframe(0, f, 'varF'),
s,
xmlstr = mat2xframe(0, s, 'struct'),
s = [s s],
xmlstr = mat2xframe(0, s, 'struct'),

end %-of test
%}
