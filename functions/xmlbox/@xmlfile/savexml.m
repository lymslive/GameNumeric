% ���� sroot ��ʾ��xml���ļ������ content Ԫ����
% д�������ļ��� write
function ST = savexml(obj)
	ST = -1;

	cs = xmlfile.fst2xml(obj.sroot.(obj.rootName), obj.rootName);
	obj.content = [obj.content(1 : obj.headlines); cs];

	ST = 0;
end %-of main
