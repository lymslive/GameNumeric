% 解析一行，当前行，返回一个结构信息
% 包含域名：
%   .tag: char, 元素标签名，否则为空
%   .open: logical, 是否开启元素
%   .close: logical, 是否关闭元素
%   .at: char, 属性字符串
%   .alone: logical, 是否自封装元素
%   .text: char, 元素文本内容
%   一般地，如果在同一行同时开关，要么是自封闭元素，要么有简单文本内容
% 只处理以下四种格式情状：
% 1. 自封元素行：<tag name="value" ... />
% 2. 单行简单元素: <tag name="value"...>text</tag>
% 3. 关闭元素行：</tag>
% 4. 开启元素行：<tag name="value"...>
% 5. 裸文本行：没有 <> 标签
function st = parseLine(obj)

	st.tag = '';
	st.open = false;
	st.close = false;
	st.at = '';
	st.alone = false;
	st.text = '';

	str = obj.line();
	tok = regexp(str, obj.patAlone, 'tokens', 'once');
	if ~isempty(tok)
		st.tag = tok{1};
		st.open = true;
		st.close = true;
		st.at = strtrim(tok{2});
		st.alone = true;
		st.text = '';
		obj.stline = st;
		return;
	end

	tok = regexp(str, obj.patInline, 'tokens', 'once');
	if ~isempty(tok)
		st.tag = tok{1};
		st.open = true;
		st.close = true;
		st.at = strtrim(tok{2});
		st.alone = false;
		st.text = strtrim(tok{3});
		obj.stline = st;
		return;
	end

	tok = regexp(str, obj.patClose, 'tokens', 'once');
	if ~isempty(tok)
		st.tag = tok{1};
		st.close = true;
		obj.stline = st;
		return;
	end

	tok = regexp(str, obj.patOpen, 'tokens', 'once');
	if ~isempty(tok)
		st.tag = tok{1};
		st.open = true;
		st.at = strtrim(tok{2});
		obj.stline = st;
		return;
	end

	if isempty(regexp(str, '<.*>'))
		st.text = strtrim(str);
		st.tag = '#Text';
		st.open = true;
		st.close = true;
		obj.stline = st;
		return;
	end

	obj.stline = st;
end
