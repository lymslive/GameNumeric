% hash 算法
% 类似 33 进制算法
% 为防 double 溢出，根据 key 字符长度取不同进制，也可调用指定 base
function code = hashcode(key, base)

if ~sHash.isstrkey(key)
	key = sHash.tostrkey(key);
end

len = length(key);
if nargin < 2 || base == 0
	base = 1;
	if len < 10
		base = 33;
	elseif len < 20
		base = 7;
	elseif len < 30
		base = 5;
	elseif len < 40;
		base = 3;
	else
		base = 1;
	end
end

seq = [1 : len]';
mbase = base .^ seq;
code = double(key) * mbase;

end %F-main
