% �ӵ�ǰ�п�ʼ����һ�� xml Ƭ�ϣ����� xmlel ����
% ���¼��У�ֱ�����һ��Ԫ��
% ���øú�������ڣ�Ӧ�ѽ�����ǰ��ȷ���ǿ�����һ��Ԫ��
% �Դ�Ϊ��㣬����Ԫ�ص�����ת��Ϊһ�� xmlel Ԫ��
% ��ο� parseFrag ����Ϊ�ṹ
function st = parseXmlel(obj)

if strcmp('#Text', obj.stline.tag)
	st = xmlel.createTextNode(obj.stline.text);
	return;
else
	st = xmlel();
	subst = xmlel.empty();
end

obj.pushTag(obj.stline.tag);
stName = obj.topTag();
st.name = stName;

if ~isempty(obj.stline.at)
	at = obj.parseAttr(obj.stline.at, true);
	st.at = at;
end
if ~isempty(obj.stline.text)
	subst(end+1, 1) = xmlel.createTextNode(obj.stline.text);
end

if obj.stline.close
	obj.popTag(obj.stline.tag);
	st.pushChild(subst);
	return;
end

obj.next();
while ~obj.eof()

	obj.parseLine();

	if obj.stline.close
		if strcmp(obj.stline.tag, stName)
			obj.popTag(obj.stline.tag);
			st.pushChild(subst);
			return;
		end
	end

	if obj.stline.open
		subname = obj.stline.tag;
		subst(end+1, 1) = obj.parseXmlel();
	end

	obj.next();
end

end %-of main
