function ST = saveas(obj, filename)
ST = 1;

if nargin < 2
	filename = obj.file;
end

fid = fopen(filename, 'w', 'n', 'UTF-8');
fprintf(fid, '%s', obj.root.char());
fclose(fid);

if nargin >= 2
	obj.file = filename;
end

ST = 0;
end %F-main
