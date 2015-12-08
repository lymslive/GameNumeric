% 跳过文件开始的一些行，定位到根元素实际开始的行
% 包含根元素的行已被扫描，保存了根元素名
% 当前行指针指向下一行
function lineno = skipRoot(obj)
	while ~obj.eof()
		obj.parseLine();
		if obj.stline.open
			obj.rootName = obj.stline.tag;
			break;
		end
		obj.next();
	end
	lineno = obj.tell();
	obj.headlines = lineno - 1;
	if obj.eof()
		warning('Not found any xml root!');
	end
end %-of main
