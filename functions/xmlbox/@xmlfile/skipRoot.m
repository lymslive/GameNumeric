% �����ļ���ʼ��һЩ�У���λ����Ԫ��ʵ�ʿ�ʼ����
% ������Ԫ�ص����ѱ�ɨ�裬�����˸�Ԫ����
% ��ǰ��ָ��ָ����һ��
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
