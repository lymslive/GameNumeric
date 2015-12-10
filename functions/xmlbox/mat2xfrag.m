% mat2xfrag 将一个 matlab 变量，矩阵，保存为 xml-frag 片断
% 输入参数：
%   leader: 前导缩进量，整数，代表缩进几个制表符，也表示层次意义
%   var:  一个 matlabe 变量，仅支持普通矩阵及简单元胞矩阵
%   name: 保存的变量名，即 xml 元素标签
%   atname: 属性名，数据保存于元素的属性下，cellstr
% 输出参数：
%   xmlstr: xml格式化的字符串
%
% 算法说明：
%   1. 输出 xml 片断，无根元素
%   2. 目前支持的变量类型有：字符串，数值矩阵，简单内容的元胞矩阵，简单表
%   3. struct 变量支持递归，此时忽略列名 atname，成员变量仅能用默认列名
%   4. 每个元素一行，行末有换行符"\n"
%
% lymsive / 2015-01

function xmlstr = mat2xfrag(leader, var, name, atname)

Debug = false;
if Debug && nargin < 1
    s_test();
    xmlstr = 'Debug mode test end!';
    return;
end

% 将一个制表符作为缩进
TABchar = 9;
sIndent = TABchar;
if isempty(leader)
    nIndent = 0;
else
    nIndent = leader;
end
indstr  = repmat(sIndent, 1, nIndent);

unknown = '#unknown';

% 默认变量名
if nargin < 3 || isempty(name)
    name = class(var);
end
if nargin < 4
    atname = '';
end

% table 转为 cell 保存
if istable(var)
    if isempty(atname)
        atname = var.Properties.VariableNames;
    end
    var = table2cell(var);
end

[m, n] = size(var);

xmlstr = '';
if ischar(var) % string

    for i = 1 : m
        text = [indstr, '<', name];
        colname = s_getColName(1, atname);
        text = sprintf('%s %s="%s"', text, colname, var(i,:));
        text = sprintf('%s/>\n', text);
        xmlstr = [xmlstr text];
    end

elseif isnumeric(var) || islogical(var) % double matrix etc
    
    for i = 1 : m
        text = [indstr, '<', name];
        for j = 1 : n
            colname = s_getColName(j, atname);
            text = sprintf('%s %s="%g"', text, colname, var(i,j));
        end
        text = sprintf('%s/>\n', text);
        xmlstr = [xmlstr text];
    end

elseif iscell(var)

    if s_simpleCell(var) % simple cell matrix
        for i = 1 : m
            text = [indstr, '<', name];
            for j = 1 : n
                colname = s_getColName(j, atname);
                colvalue = var{i,j};
                if isempty(colvalue)
                    colvalue = '';
                end
                if isnumeric(colvalue) || islogical(colvalue)
                    text = sprintf('%s %s="%g"', text, colname, colvalue);
                elseif ischar(colvalue)
                    text = sprintf('%s %s="%s"', text, colname, colvalue);
                else
                    colvalue = unknown;
                    text = sprintf('%s %s="%s"', text, colname, colvalue);
                    warning('Only simple cell matrix is supported!');
                end
            end
            text = sprintf('%s/>\n', text);
            xmlstr = [xmlstr text];
        end
    else % complex cell
        nIndent = nIndent + 1;
        m = numel(var);
        for i = 1 : m
            subname = 'cell';
            subvar  = var{i};
            head = sprintf('%s<%s>\n', char(indstr), name);
            foot = sprintf('%s</%s>\n', char(indstr), name);
            body = mat2xfrag(nIndent, subvar, subname);
            text = [head body foot];
            xmlstr = [xmlstr text];
        end
    end

elseif isstruct(var) % struct

    nIndent = nIndent + 1;
    m = numel(var);
    for i = 1 : m
        head = sprintf('%s<%s>\n', char(indstr), name);
        foot = sprintf('%s</%s>\n', char(indstr), name);

        body = '';
        subnames = fieldnames(var(i));
        n = length(subnames);
        for j = 1 : n
            subvar = getfield(var(i), subnames{j});
            subxml = mat2xfrag(nIndent, subvar, subnames{j});
            body = [body subxml];
        end

        text = [head body foot];
        xmlstr = [xmlstr text];
    end

else
    xmlstr = sprintf('%s<%s %s="%s"/>\n', char(indstr), name, 'A', unknown);
    warning('Ignore unknow datetype!');
end

end %-of main

%%---- sub function -----%%

% 取出列名
% 默认规则，前26列用A－Z，大于26，则用'C27'格式
function colname = s_getColName(ind, atname)

% 默认列名
defaultName =  ['A' : 'Z'];
colname = '';

if isempty(atname)
    if ind <=26
        colname = defaultName(ind);
    else
        colname = sprintf('C%d', ind);
    end
else
    if ischar(atname)
        colname = atname(ind, :);
    elseif iscellstr(atname)
        colname = atname{ind};
    else
        error('The Attribute Name Require string or cellstr!');
    end
end

end %-of getColName

% 判断是不否简单 cell matrix，只含字符串或数字标量或空值
function tf = s_simpleCell(var)
tf = true;
if ~iscell(var)
    tf = flase;
    return;
end
[m n] = size(var);
for i = 1 : m
    for j = 1 : n
        value = var{i, j};
        if isempty(value)
            continue;
        end

        if ~ischar(value) && ~isnumeric(value) && ~islogical(value)
            tf = false;
            if ischar(value) && ~isrow(value) > 1
                tf = false;
            elseif ~isscalar(value)
                tf = false;
            end
        end

        if ~tf
            return;
        end
    end
end
end %-of simpleCell

%%----- debug test -----%%

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

% a,
% xmlstr = mat2xfrag(0, a, 'varA'),
% b,
% xmlstr = mat2xfrag(0, b, 'varB'),
% c,
% xmlstr = mat2xfrag(1, c, 'magic', {'col1', 'col2', 'col3'}),
% d,
% xmlstr = mat2xfrag(0, d, 'varD', 'value'),
% e,
% xmlstr = mat2xfrag(0, e, 'varE', 'extention'),
% f,
% xmlstr = mat2xfrag(0, f, 'varF'),
% s,
% xmlstr = mat2xfrag(0, s, 'struct'),
s = [s s],
xmlstr = mat2xfrag(0, s, 'struct'),

end %-of test
