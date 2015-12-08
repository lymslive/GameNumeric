% �ӵ�ǰ�п�ʼ����һ�� xmlƬ��
% ���¼��У�ֱ�����һ��Ԫ��
% ���øú�������ڣ�Ӧ�ѽ�����ǰ��ȷ���ǿ�����һ��Ԫ��
% �Դ�Ϊ��㣬����Ԫ�ص�����ת��Ϊһ�� struct
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
