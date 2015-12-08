% 根据 xpath 提取或设置 xml 部分结点的值
% 输入参数：
%   xml: 已解析的 dom 对象，或文件名字符串，（.xml 后缀可忽略）
%   xpath: 合法的 xpath 表达式，字符串，路径末尾不要'/'，除非只有'/'表示root
%   incell: 要修改的值，double-array，or cellstr-array，一维数组
%          省略第3个参数表示查询（get），提供第3参数表示修改（set）
% 输出参数：
%   xcell：xpath 查询到的值，或修改前的旧值
%   doc:   表示 xml 的 dom 对象，若输入参数 xml 已是 dom，则返回原 xml 对象
%   nodeList: 由 xpath 查询到的结点列表
% 典型用法：
%   可用于查询与设置一“列”属性数据，不可查设复杂数据类型，含子元素的xml结点

% 参考：xpath_example.m

function [xcell doc nodeList] = qxml(xml, xpath, incell)

% Import the XPath classes
import javax.xml.xpath.*

if (nargin < 2)
	help qxml;
	return;
end

setit = 1;
if nargin < 3 
	incell = [];
end
if isempty(incell)
	setit = 0;
end

if isa(xml, 'org.apache.xerces.dom.DeferredDocumentImpl') || isa(xml, 'org.apache.xerces.dom.DeferredElementImpl')
	% input is a java xml object
	doc = xml;
else
	if (exist(xml,'file') == 0)
		% xml extension may be omitted from the file name
		if (isempty(strfind(file,'.xml')))
			xml = [xml '.xml'];
		end

		if (exist(xml,'file') == 0)
			error(['The file ' xml ' could not be found']);
		end
	end
	%read the xml file and construct the DOM.
	doc = xmlread(xml);
end


% Create an XPath expression.
factory = XPathFactory.newInstance;
xpathEng = factory.newXPath;
expression = xpathEng.compile(xpath);
% Apply the expression to the DOM.
nodeList = expression.evaluate(doc, XPathConstants.NODESET);

n = nodeList.getLength;
xcell = cell(n, 1);

% chess set input-values
if setit == 1
	ncell = numel(incell);
	if n > ncell
		disp('Warning: not enough input value to modify xml by xpath');
	elseif n < ncell
		disp('Warning: more input values than xpath will be ommitesd');
	end
	if ~iscellstr(incell)
		value = s_wrapCell(incell);
	end
else
	ncell = 0;
	value = [];
end

% Iterate through the nodes that are returned.
for i = 1 : n

	node = nodeList.item(i-1);
	rnd = []; % node to be set
	res = ''; % read node value

	% get value of the firstChild of elementNoe, or value of the node itself
	switch node.getNodeType
		case node.ELEMENT_NODE
			children = node.getChildNodes;
			if (children.getLength == 1)
				rnd = children.item(0);
				res = char(rnd.getNodeValue);
			else
				res = '';
			end
		otherwise
			rnd = node;
			res = char(node.getNodeValue);
	end

	xcell{i} = res;
	if setit == 1 && i <= ncell & ~isempty(rnd)
		val = value{i};
		rnd.setNodeValue(val);
	end

end %-of nodeList

% 试图将 string-cell-array 转化为数值矩阵，或标量字符串
xcell = s_stripCell(xcell);

end %-of main function

%% -------------------------------------------------- %%

% 剥除一层 cell
% 输入：c, a cell array or matrix
% 输出：d, possible double matrix, or single string, else return c itself
function d = s_stripCell(c)

if numel(c) == 1 && ischar(c{1})
	d = c{1};
	return;
end

%Try to convert everything to numeric
onlyNumeric = str2double(c);

if any(isnan(onlyNumeric))
	%all were not numeric, so return txtdata after injecting the actual numbers into it
	d = c;
	for i = 1:numel(onlyNumeric)
		if ~isnan(onlyNumeric(i))
			d{i} = onlyNumeric(i);
		end
	end
else
	d = onlyNumeric;
end

end %-of s_stripCell

% 将数组包装成字符串元胞数组
% 不能识别元胞内容非数字非字符的输入

function c = s_wrapCell(d)

if iscellstr(d)
	c = d;
	return
end

if ischar(d)
	c = cellstr(d);
	return;
end

if isnumeric(d)
	n = numel(d);
	c = cell(n, 1);
	for i = 1 : n
		c{i} = num2str(d(i));
	end
	return;
end

if iscell(d)
	n = numel(d);
	c = d;
	for i = 1 : n
		v = d{i};
		if ischar(v)
			c{i} = v;
		elseif isdouble(v)
			c{i} = num2str(v);
		else
			c{i} = '';
			disp('Warning: cell content require char or double');
		end
	end
	return;
end

c = [];
disp('Warning: can not warp input as cell-string');

end %-of s_wrapCell
