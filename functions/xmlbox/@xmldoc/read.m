function obj = read(obj, filename)

if nargin < 2
	xml = xmlfile(obj.file);
	xmlfile.parseFile('xmlel');
	obj.root = xml.xroot;
else
	xml = xmlfile(filename);
	xmlfile.parseFile('xmlel');
	obj.root = xml.xroot;
	obj.file = filename;
end

end %F-main
