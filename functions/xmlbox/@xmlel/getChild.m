% getChild: 按索引或按名字取出一个子元素或属性
% 返回元素对象，或属性值字符串
% 支持对象数组调用
% 算法说明：
% 1. 无参数，返回所有元素的所有子元素
% 2. 单参数，可以是整数索引或元素名，或属性名
% 3. 第一参数是元素名时，还可以再加一个索引参数
function node = getChild(obj, arg, idx)

if ~xmlel.isscalarval(arg)
	error('expect a scalar number or string!');
end

enode = xmlel.empty();
anode = {};

for i = 1 : numel(obj)
	ie = obj(i);
	if nargin < 2
		if ~isempty(ie.child)
			enode = [anode; ie.child];
		end
	elseif isnumeric(arg)
		if ~isempty(ie.child) && numel(ie.child >= arg)
			enode = [enode; ie.child(arg)];
		end
	elseif ischar(arg)
		if strcmp(arg(1), '@')
			name = arg(2:end);
			if isfield(ie.at, name)
				anode = [anode; ie.at.(name)];
			end
		else
			name = arg;
			if ~isempty(ie.child)
				ch = ie.child.getElement(name);
			else
				ch = [];
			end
			if ~isempty(ch)
				if nargin >= 3 && idx > 0
					enode = [enode; ch(idx)];
				else
					enode = [enode; ch];
				end
			elseif isfield(ie.at, name)
				anode = [anode; ie.at.(name)];
			end
		end
	end
end

if ~isempty(enode)
	node = enode;
elseif ~isempty(anode)
	node = anode;
else
	node = [];
end

end %F-main
