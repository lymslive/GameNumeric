% txtfile: 用元胞字符串表示一个文本文件对象
% 不储存行末换行符

classdef txtfile < handle
	
	properties (Access = public)
		fullpath; % assioate with a phyical file
	end

	properties (Access = protected)
		content; % cell array of string, m*1
		lineno;  % current line number, act as pointer
	end

	properties (Dependent, SetAccess=private)
		count;     % how many lines
		filename;  % filename with extention but path
	end

	properties (Constant)
		preview = 10; % perview lines when head or tail called
	end

	methods

		% constructor:
		% obj = txtfile(fullpath as char)
		% obj = txtfile(content as cellstr)
		function obj = txtfile(varargin)
			if nargin == 0
				obj.content = cell(0, 1);
				obj.fullpath = '';
				obj.lineno = 1;
				return;
			end
			arg = varargin{1};
			if ischar(arg)
				obj.fullpath = arg;
				obj.read();
				obj.lineno = 1;
			elseif iscellstr(arg)
				obj.content = arg(:);
				obj.fullpath = '';
				obj.lineno = 1;
			else
				error('txtfile object require filepath or content cellstr!');
			end
		end

		function count = get.count(obj)
			count = length(obj.content);
		end

		function filename  = get.filename(obj)
			[pathstr, name, ext] = fileparts(obj.fullpath);
			filename = [name ext];
		end

		function obj = set.lineno(obj, lineno)
			if lineno > obj.count
				lineno = obj.count + 1;
			end
			if lineno < 1
				lineno = 0;
			end
			obj.lineno = lineno;
		end

		% read in from the file, return 0 if success, otherwise 1
		% you can provid anthor file, and update the properties after read.
		function ST = read(obj, file)
			ST = -1;
			if nargin < 2 || isempty(file)
				file = obj.fullpath;
			end
			if isempty(file)
				error('A filename(path) should provid!');
			end

			[fid msg] = fopen(file);
			if ~isempty(msg)
				error(['Cannot open the file: ' file])
			end

			obj.content = cell(0,1);
			tline = fgetl(fid);
			i = 1;
			while ischar(tline)
				obj.content{i, 1} = tline;
				i = i + 1;
				tline = fgetl(fid);
			end
			fclose(fid);
			obj.lineno = 1;
			ST = 0;

			if nargin >= 2
				obj.fullpath = file;
			end
		end

		function ST = write(obj, file)
			ST = -1;
			if nargin < 2 || isempty(file)
				file = obj.fullpath;
			end
			if isempty(file)
				error('A filename(path) should provid!');
			end

			[fid msg] = fopen(file, 'w');
			if ~isempty(msg)
				error(['Cannot open the file: ' file])
			end

			for i = 1 : obj.count
				fprintf(fid, '%s\n', obj.content{i});
			end
			ST = 0;
			fclose(fid);

			if nargin >= 2
				obj.fullpath = file;
			end
		end

		function tf = ready(obj)
			if isempty(obj.fullpath);
				tf = false;
				return;
			end
			if exist(obj.fullpath, 'file') == 2
				tf = true;
			else
				tf = false;
			end
		end

		% line() return current line string
		% line(no) return anthor line string
		% line(start, stop) return a range lines as cellstr
		function [str msg] = line(obj, start, stop)
			if nargin >= 3;
				if start < 1
					start = 1;
				end
				if stop > obj.count
					stop = obj.count;
				end
				str = obj.content(start:stop);
				return;
			end

			if nargin == 2
				lineno = start;
			else
				lineno = obj.lineno;
			end
			if lineno < 1 || lineno > obj.count
				str = '';
			else
				str = obj.content{lineno};
			end

			if nargout > 1
				if lineno < 1
					msg = 'BOF';
				elseif lineno > obj.count
					msg = 'EOF';
				else
					msg = '';
				end
			end
		end

		function str = next(obj, step)
			str = obj.line();
			if nargin < 2
				step = 1;
			end
			obj.lineno = obj.lineno + step;
		end

		function str = prev(obj, step)
			str = obj.line();
			if nargin < 2
				step = 1;
			end
			obj.lineno = obj.lineno - step;
		end

		function vlines = view(obj, start, stop)
			if nargin < 2 || start < 1
				start = 1;
			end
			if nargin < 3 || stop > obj.count
				stop = obj.count;
			end
			for i = start : stop
				fprintf('%s\n', obj.content{i});
			end
			vlines = stop - start + 1;
		end

		function vlines = head(obj, num)
			if nargin < 2
				num = txtfile.preview;
			end
			vlines = obj.view(1, num);
		end

		function vlines = tail(obj, num)
			if nargin < 2
				num = txtfile.preview;
			end
			vlines = obj.view(obj.count - num + 1);
		end

		function tf = eof(obj)
			if obj.lineno > obj.count
				tf = true;
			else
				tf = false;
			end
		end

		function tf = bof(obj)
			if obj.lineno < 1
				tf = true;
			else
				tf = false;
			end
		end

		function lineno = rewind(obj, arg)
			if nargin < 2 || arg == 1
				obj.lineno = 1;
			elseif arg == -1
				obj.lineno = obj.count;
			else
				error('txtfile.rewind: 1 jump to bof, or -1 jump to eof');
			end
			lineno = obj.tell();
		end

		function [lineno msg] = tell(obj, newpos)
			lineno = obj.lineno;
			if nargin >= 2
				obj.lineno = newpos;
			end
			if nargout > 1
				if lineno < 1
					msg = 'BOF';
				elseif lineno > obj.count
					msg = 'EOF';
				else
					msg = '';
				end
			end
		end

		function ST = seek(obj, offset, origin)
			ST = -1;
			if nargin < 3
				origin = 'cof';
			end
			if nargin < 2
				offset = 0;
			end
			switch origin
			case 'bof'
				cof = 0;
			case 'eof'
				cof = obj.count;
			case 'cof'
				cof = obj.lineno;
			otherwise
				error('txtfile.seek accept only: bof cof eof!');
			end
			obj.lineno = cof + offset;
			ST = 0;
		end

		function oldstr = edit(obj, newstr, lineno)
			if nargin < 3
				lineno = obj.lineno;
			end
			oldstr = obj.content{lineno};
			obj.content{lineno} = txtfile.chomp(newstr);
		end

		function oldstr = delete(obj, lineno)
			if nargin < 2
				lineno = obj.lineno;
			end
			if lineno >=1 && lineno <= obj.count
				oldstr = obj.content{lineno};
				obj.content(lineno) = [];
				if lineno < obj.lineno
					obj.lineno = obj.lineno - 1;
				end
			else
				oldstr = '';
			end
		end

		function lines = insert(obj, newstr, lineno)
			if nargin < 3
				lineno = obj.lineno;
			end

			if ischar(newstr)
				newline = {txtfile.chomp(newstr)};
				lines = 1;
			elseif iscellstr(newstr)
				newline = newstr(:);
				lines = numel(newline);
			else
				error('txtfile.insert only accept str or cellstr!');
			end

			if lineno <= 1
				obj.content = [newline; obj.content];
			elseif lineno > obj.count
				obj.content = [obj.content; newline];
			else
				obj.content = [obj.content(1:lineno-1);  ...
					newline; obj.content(lineno:end)];
			end

			if lineno <= obj.lineno
				obj.lineno = obj.lineno + lines;
			end
		end

		function lines = append(obj, newstr, lineno)
			if nargin < 3
				lineno = obj.lineno;
			end
			lines = obj.insert(newstr, lineno + 1);
		end

		% concatenate anthor string, or cells of string;
		function lines = cat(obj, newstr)
			if isa(newstr, 'txtfile')
				obj.content = [obj.content; newstr.content];
				lines = newstr.count;
			else
				lines = obj.insert(newstr, obj.count + 1);
			end
		end

		function str = char(obj)
			str = '';
			for i = 1 : obj.count
				str = sprintf('%s%s\n', str, obj.content{i});
			end
		end

		function disp(obj)
			str = sprintf('\tText File: "%s" with %d lines\n', ...
				obj.filename, obj.count);
			disp(str);
		end

		% bug: other method must have and only have one argout
		function sref = subsref(obj, s)
			switch s(1).type
			case '{}'
				sref = builtin('subsref', obj.content, s);
			otherwise
				sref = builtin('subsref', obj, s);
			end
		end

		function obj = subsasgn(obj, s, val)
			switch s(1).type
			case '{}'
				if ischar(val)
					val = txtfile.chomp(val);
					obj.content = builtin('subsasgn', obj.content, s, val);
				else
					error('txtfile{} asignment only accept string!');
				end
			otherwise
					obj = builtin('subsasgn', obj, s, val);
			end
		end

		function c = plus(a, b)
			if isa(a, 'txtfile') && isa(b, 'txtfile')
				c = txtfile([a.content; b.content]);
			else
				error('txtfile can only plus with another txtfile!');
			end
		end

		function st = saveobj(obj)
			st.fullpath = obj.fullpath;
			st.content = obj.content;
		end

	end %-of primary method

	methods (Static)

		function obj = loadobj(st)
			obj = txtfile(st.content);
			obj.fullpath = st.fullpath;
		end

		% remove the \r\n at the end of line
		% \r = return = CR = 13 = '\x0d'
		% \n = newline= LF = 10 = '\x0a'
		function newstr = chomp(str)
			n = length(str);
			i = n;
			while i > 0
				if str(i) ~= 13 && str(i) ~= 10
					break;
				end
				i = i - 1;
			end
			if i <= 0
				newstr = 0;
			else
				newstr = str(1 : i);
			end
		end

	end %-of Static methods

end %-of classdef
