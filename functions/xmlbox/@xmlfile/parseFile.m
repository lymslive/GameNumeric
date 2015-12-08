% 解析整个 xml 文件，转化为一个 struct
% struct 结构大致参照 xml2mat，但是属性保持源文件顺序
% 属性结点简写为 AT，文本结点简写为 TT，排在子元素结点前面
% 其余结点按源文件的元素标签名
% st 有一个唯一域，就是xml文件的根元素
function ST = parseFile(obj, output)

	ST = -1;

	if nargin < 2
		output = 1;
	end
	if ischar(output)
		if strcmp(output, 'struct')
			output = 1;
		elseif strcmp(output, 'xmlel')
			output = 2;
		else
			error('xmlfile.parseFile: unkonw output type!');
		end
	else
		if output ~= 1 || output ~= 2
			error('xmlfile.parseFile: unkonw output type!');
		end
	end

	obj.rewind();
	obj.sroot = struct;
	obj.cxpath = cell(1, 0);
	obj.stline = struct;

	% 定位根元素
	obj.skipRoot();
	if obj.eof()
		return;
	end

	if output == 1
		obj.sroot.(obj.rootName) = obj.parseFrag();
		obj.parsed = 1;
	else
		obj.xroot = obj.parseXmlel();
		obj.xroot.rootas();
		obj.parsed = 2;
	end

	ST = 0;

end %-of main
