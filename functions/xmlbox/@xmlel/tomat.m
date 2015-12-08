% 将一个元素数组，转化为一个 matlab 变量
% 算法：
%   1. 如果输入列表有多种元素，则返回一个 struct，以各元素名为域
%   2. 单种元素，试图返回一个属性值矩阵（或 cell 矩阵）
%   3. 没有属性而有子元素时，递归转化子元素，分别保存在 cell 中
%   4. 如果子元素也有多种元素名，试图转化为 struct 数组
%   5. 文本元素将转化为 cellstr
% 注意：
%   1. 该实现暂不支持元素既有属性值，又有子元素的情况
%   2. 同种元素的属性名及顺序一致，参考 atMatrix
function val = tomat(obj)

names = obj.count('names');
len = numel(names);

if len > 1
	val = struct;
	for i = 1 : len
		name = names{i};
		curObj = obj.getElement(name);
		val.(name) = curObj.tomat();
	end
	return;
end

val = obj.atMatrix();

if isempty(val)

	val = {};
	for i = 1 : numel(obj)
		iobj = obj(i);
		if iobj.isTextNode();
			val{i, 1} = iobj.getText();
		elseif ~isempty(iobj.child)
			val{i, 1} = iobj.child.tomat();
		else
			val{i, 1} = [];
		end
	end

	if iscellstruct(val)
		cs = val;
		try
			val = cs{1};
			for i = 2 : numel(cs)
				val = [val; cs{i}];
			end
		catch
			val = cs;
		end
	end

end

end %F
