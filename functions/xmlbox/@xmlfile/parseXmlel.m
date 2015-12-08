% 从当前行开始解析一个 xml 片断，创建 xmlel 对象
% 往下几行，直到完成一个元素
% 调用该函数的入口，应已解析当前行确定是开启了一个元素
% 以此为起点，将该元素的起迄转化为一个 xmlel 元素
% 另参考 parseFrag 解析为结构
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
