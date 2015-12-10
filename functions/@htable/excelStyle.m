% excelStyle: Translate between number coordinate and 'A1' style.
%
% usage:
% excelStyle(1) == 'A';
% excelStyle([1,2]) == 'B1';
% excelStyle('A1:B2') == {[1,1]; [2,2]};
%
% �� excel �������� A1��R1C1 ����������֮�以��ת��
% ��������Ǳ����ַ�������Ϊ��excel�����������ͼת��Ϊ����
% ������������֣���ת��Ϊexcel�����ַ�����A1���
% ������ת�����򱨴�
%
% ���������ı������ֱ�ʾ��������1*2�������ʾ��������
%
% ֧�ַ�Χ������
% �ַ���ʽ�� A1:B2����ʱ����� 2*1 cell��ÿ��cellһ�ǵ����꣬1*1 �� 1*2 ����
% ������ʽ�ķ�Χ�������ṩһ���������ֲ�����������������ͬά��תΪ:��ʽ����
% ��� excelStyle(1, 2) == 'A:B'; excelStyle([1,2]) == 'B2';
%
% maintain: lymslive / 2015-12-08
function out = excelStyle(in, varargin)

AZ = ['A' : 'Z'];

% number index --> string index
if isnumeric(in)
    len = numel(in);
    if len == 1
        out = s_To26(in);
        out = AZ(out);
    elseif len == 2
        out = s_To26(in(2));
        out = AZ(out);
        out = [out num2str(in(1))];
    else
        error('as [x, y] index, tow number at most!');
    end

    if nargin >= 2
        arg = varargin{1};
        if ~isnumeric(arg)
            error('The other corner should bu numer index also!');
        end
        if length(arg) ~= len
            error('The tow corners index must be the same size!'); 
        end
        another = htable.excelStyle(arg);
        out = [out ':' another];
    end

% string index --> number index
elseif ischar(in) && size(in, 1) <= 1
    in = upper(in);

    sep = strfind(in, ':');
    % range index��such as 'A1:B2'
    if ~isempty(sep)
        if length(sep) > 1
            error('index range contain one ":" at most!');
        end
        leftup = in(1 : sep - 1);
        rightbt = in(sep + 1 : end);
        if isempty(leftup) || isempty(rightbt)
            error('The ":" in index range must in middle!');
        end
        out = cell(2, 1);
        out{1} = htable.excelStyle(leftup);
        out{2} = htable.excelStyle(rightbt);
        if length(out{1}) ~= length(out{2})
            error('The tow corner between ":" is inconsistent!');
        end
        return;
    end

    % try R1C1 style
    fc = in(1);
    if fc == 'R'
        match = regexp(in, '^R(\d+)C(\d+)', 'tokens', 'once');
        if ~isempty(match)
            out = [str2double(match{1}), str2double(match{2})];
            return;
        end
    end

    fc = in(end);
    % try A10 sytle
    if fc >= '0' && fc <= '9' 
        match = regexp(in, '^([A-Z]+)(\d+)', 'tokens', 'once');
        out = zeros(1, 2);
        out(2) = s_To10(match{1});
        out(1) = str2double(match{2});
    else % only A column index
        out = s_To10(in);
    end

else
    error('expects integer or "A1" style string!');
end

end %F-main

%% --- sub function --- %%

% ��һ��10��������ת��Ϊ26��������
% ���������������ʾÿλ�ǵڼ�����ĸ
function idx = s_To26(n)

if n <= 0
    error('index must be positive!');
end

divs = n;
left = mod(divs, 26);
if left <= 0
    left = 26;
end

idx = left;
divs = ceil(divs/26) - 1;
while divs > 0
    left = mod(divs, 26);
    if left <= 0
        left = 26;
    end
    idx = [left idx];
    divs = ceil(divs/26) - 1;
end

end %F-to26

% ��A-Z�ַ���ת��Ϊʮ������
function idx = s_To10(str)

if length(str) > 3
    warning('excelStyle@htable: try to convert more than 3 letters to number');
end

AZ = ['A' : 'Z'];
% str = upper(str);
base = 'A';

idx = 0;
for i = 1 : length(str)
    c = str(i);
    d = c - base + 1;
    if d > 26 || d < 1
        error('Only A-Z char is valid index!');
    end
    idx = idx * 26 + d;
end

end %F-to10
