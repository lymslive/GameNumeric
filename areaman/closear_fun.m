% closear_fun: close area function 
% �ر���Ŀ�ĺ�����һ���� closear �ű�����
% 
% ��Ҫ������
% �Ƴ���ӵ� .subpath, �ָ� Matlab ·��
%
% maintain: lymslive / 2015-11
function closear(prj)

if isfield(prj, 'subpath') && iscellstr(prj.subpath)
	for i = 1 : length(prj.subpath)
		sub = prj.subpath{i};
		fullpath = [prj.base, filesep, sub];
		warning('off','MATLAB:rmpath:DirNotFound');
		rmpath(fullpath);
		warning('on','MATLAB:rmpath:DirNotFound');
	end
end

end %-of main
