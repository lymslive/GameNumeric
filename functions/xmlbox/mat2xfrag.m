% mat2xfrag ��һ�� matlab ���������󣬱���Ϊ xml-frag Ƭ��
% ���������
%   leader: ǰ�����������������������������Ʊ����Ҳ��ʾ�������
%   var:  һ�� matlabe ��������֧����ͨ���󼰼�Ԫ������
%   name: ����ı��������� xml Ԫ�ر�ǩ
%   atname: �����������ݱ�����Ԫ�ص������£�cellstr
% ���������
%   xmlstr: xml��ʽ�����ַ���
%
% �㷨˵����
%   1. ��� xml Ƭ�ϣ��޸�Ԫ��
%   2. Ŀǰ֧�ֵı��������У��ַ�������ֵ���󣬼����ݵ�Ԫ�����󣬼򵥱�
%   3. struct ����֧�ֵݹ飬��ʱ�������� atname����Ա����������Ĭ������
%   4. ÿ��Ԫ��һ�У���ĩ�л��з�"\n"
%
% lymsive / 2015-01

function xmlstr = mat2xfrag(leader, var, name, atname)

Debug = false;
if Debug && nargin < 1
    s_test();
    xmlstr = 'Debug mode test end!';
    return;
end

% ��һ���Ʊ����Ϊ����
TABchar = 9;
sIndent = TABchar;
if isempty(leader)
    nIndent = 0;
else
    nIndent = leader;
end
indstr  = repmat(sIndent, 1, nIndent);

unknown = '#unknown';

% Ĭ�ϱ�����
if nargin < 3 || isempty(name)
    name = class(var);
end
if nargin < 4
    atname = '';
end

% table תΪ cell ����
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

% ȡ������
% Ĭ�Ϲ���ǰ26����A��Z������26������'C27'��ʽ
function colname = s_getColName(ind, atname)

% Ĭ������
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

% �ж��ǲ���� cell matrix��ֻ���ַ��������ֱ������ֵ
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
