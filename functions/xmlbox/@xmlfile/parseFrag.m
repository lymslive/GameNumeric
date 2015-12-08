% 从当前行开始解析一个 xml片断
% 往下几行，直到完成一个元素
% 调用该函数的入口，应已解析当前行确定是开启了一个元素
% 以此为起点，将该元素的起迄转化为一个 struct
function st = parseFrag(obj)

	st = struct;
	st.AT = [];
	st.TT = [];

	obj.pushTag(obj.stline.tag);
	stName = obj.topTag();

	if ~isempty(obj.stline.at)
		at = obj.parseAttr(obj.stline.at);
		st.AT = at;
	end
	if ~isempty(obj.stline.text)
		st.TT = obj.stline.text;
	end

	if obj.stline.close
		obj.popTag(obj.stline.tag);
		return;
	end

	obj.next();
	while ~obj.eof()

		obj.stline = obj.parseLine();

		if obj.stline.close
			if strcmp(obj.stline.tag, stName)
				obj.popTag(obj.stline.tag);
				return;
			end
		end

		if obj.stline.open
			subname = obj.stline.tag;
			subst = obj.parseFrag();
			% store child element as struct or struct array or cell struct
			if isfield(st, subname)
				if iscell(st.(subname))
					st.(subname){end+1, 1} = subst;
				else
					try
						st.(subname)(end+1, 1) = subst;
					catch
						st.(subname) = cellstruct(st.(subname));
						st.(subname){end+1, 1} = subst;
					end
				end
			else
				st.(subname) = subst;
			end
		end

		obj.next();

	end
end %-of main
