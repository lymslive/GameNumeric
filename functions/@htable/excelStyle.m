% excelStyle: Translate between number coordinate and 'A1' style.
%
% usage:
% excelStyle(1) == 'A';
% excelStyle([1,2]) == 'B1';
% excelStyle('A1:B2') == {[1,1]; [2,2]};
%
% 在 excel 风格的索引 A1或R1C1 与数字索引之间互相转换
% 如果输入是标量字符串，认为是excel风格索引，试图转化为数字
% 如果输入是数字，则转化为excel风格的字符串（A1风格）
% 若不能转化，则报错
%
% 输入或输出的标量数字表示列索引，1*2数组则表示行列坐标
%
% 支持范围索引：
% 字符样式如 A1:B2，此时输出是 2*1 cell，每个cell一角的坐标，1*1 或 1*2 索引
% 数字样式的范围输入是提供一个额外数字参数，两个参数必须同维，转为:样式索引
% 因此 excelStyle(1, 2) == 'A:B'; excelStyle([1,2]) == 'B2';
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
    % range index，such as 'A1:B2'
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

% 将一个10进制整数转化为26进制数字
% 输出用数字向量表示每位是第几个字母
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

% 将A-Z字符串转化为十进制数
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
