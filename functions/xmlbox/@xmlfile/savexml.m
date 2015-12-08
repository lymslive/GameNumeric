% 保存 sroot 表示的xml至文件对象的 content 元胞中
% 写入物理文件用 write
function ST = savexml(obj)
	ST = -1;

	cs = xmlfile.fst2xml(obj.sroot.(obj.rootName), obj.rootName);
	obj.content = [obj.content(1 : obj.headlines); cs];

	ST = 0;
end %-of main
