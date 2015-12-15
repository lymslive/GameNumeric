function st = sstruct(varargin)
% a quick constructor of struct from string input with nature syntax
%
% For example:
%  1. s = sstruct('a = 1, b=2'); or s = sstruct('a=1', 'b=2')
%     get a struct s, s.a = 1, s.b = 2;
%  2. sstruct a=1 b=2<CR> in command line return the struct to ans
%     ans.a=1, ans.b=2
%     if you are interest in the result, assign ans to a variable
%     x = ans;
%
% Input:
%  one or more string like 'name=val'.
%  name should be valid varname, used for fieldname of result struct.
%  val is also passed as string first, but try to parse into number.
%  so the value of field will be a number or string.
%  if val is ommited as 'name1=, name2=val', the first field value is 
%  treated as emplty string ''.
%  the delimiter between 'name=val' pairs canbe , or ;
%  in command form, the space seperate multiply string input, so before and
%  after = sign cann't have space, but in function call no matter.
%  in function call, usaully one string input is more convinient.
%
% See also:
%  struct() builtin function to build any complex struct
%
% lymslive / 2015-12-15

st = struct;
for i = 1 : length(varargin)
    arg = strtrim(varargin{i});
    pairs = regexp(arg, '\s*[,;]\s*', 'split');
    for j = 1 : length(pairs)
        pair = regexp(pairs{j}, '\s*=\s*', 'split');
        name = pair{1};
        if length(pair) >= 2
            val = pair{2};
        else
            val = '';
        end
        num = str2num(val);
        if ~isempty(num)
            val = num;
        end

        st.(name) = val;
    end
end

end %F
