% xmlfile: xml 文本文件对象
% 假设是规范的，格式良好的 xml 文件
classdef xmlfile < txtfile

	properties (Constant)
		% 缩进字符，Tab
		sindent = 9;

		% 正规表达式
		% 开启元素，匹配元素名及所有属性字串（也可能为空）
		patOpen = '<(\w+)(.*?)>';
		% 关闭元素
		patClose = '</(\w+)>';
		% 自关闭独立元素，匹配元素名及属性串
		patAlone = '<(\w+)(.*?)/>';
		% 同行开启关闭元素，匹配元素名、属性串、文本内容
		patInline = '<(\w+)(.*?)>(.*?)</\1>';
		% 匹配属性及其值，属性=值
		patAttris = '(\w+)="(.*?)"';
	end

	% 辅助解析的全局变量
	properties (Transient)
		% 根元素名
		rootName;
		% 当前路径，从根到当前行 lineno 的xpath
		cxpath;
		% 当前行的结构信息，详见 parseLine
		stline;
		% 指示是否已解析，1表示已解析为 struct, sroot 可用
		parsed;
		% 根元素之前的行数
		headlines;
	end

	properties (SetAccess = private, GetAccess = public)
		% 保存解析后的 struct 或 dom 化的的xml数据结构
		sroot;
		% xmlel 对象表示的 xml 模型
		xroot;
		dom;
	end

	methods
		function obj = xmlfile(varargin)
			obj = obj@txtfile(varargin{:});
			obj.parsed = 0;
		end

		function st = get.sroot(obj)
			if obj.parsed == 1
				st = obj.sroot;
			else
				st = [];
			end
		end

		ST = parseFile(obj, output)
	end %-of basic method

	methods (Access = private)
		st = parseFrag(obj)
		lineno = skipRoot(obj)
		st = parseLine(obj)
	end

	methods (Access = private) % path stack

		% 连接 xcpath，用指定分隔符连接，默认点号
		function str = joinPath(obj, sep)
			str = '';
			if nargin < 2
				sep = '.';
			end
			for i = 1 : length(obj.cxpath)
				if isempty(str)
					str = obj.cxpath{i};
				else
					str = [str sep obj.cxpath{i}];
				end
			end
		end

		% 元素入栈操作，返回当前堆栈元素个数，即深度
		function deep = pushTag(obj, tag)
			if iscell(obj.cxpath)
				obj.cxpath{end+1} = tag;
			else
				obj.cxpath = {tag};
			end
			deep = length(obj.cxpath);
		end

		% 元素出栈操作，额外参数表示期望出栈元素名，用于判断一致性
		function tag = popTag(obj, expectTag)
			if length(obj.cxpath) > 0
				tag = obj.cxpath{end};
				obj.cxpath(end) = [];
			else
				tag = '';
			end
			if nargin > 1
				if ~strcmp(tag, expectTag)
					error('Inconsistent tag occured!');
				end
			end
		end

		function tag = topTag(obj)
			if iscell(obj.cxpath)
				tag = obj.cxpath{end};
			else
				tag = '';
			end
		end

	end %-of stack

	methods (Static)
		st = parseAttr(str, notrans)
		cs = fst2xml(stlist, name, deep)
	end

end %-of class
