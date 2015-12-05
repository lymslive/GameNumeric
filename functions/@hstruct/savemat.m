% savemat: save struct to mat file
% 保存内含 struct 至文件中
%
% 输入参数：
% @file: 文件名路径，可省 .mat 后缀，自动添加，若有.mat后缀则不重复添加
%  不提供 file 则使用 stin_.File_ 域值
%  如果也没有 File_ 域，则使用对象的变量名，或者用 ans
%
% 输出参数：
% @file: 实际保存的路径全名, 
%
% 保存的文件会更新 File_ 变量，但对象本身的 stin_.File_ 域不更新
%
% maintain: lymslive / 2015-12-05
function file = savemat(me, file)

if isempty(me.stin_)
	file = [];
	disp('The object seems empty, no need to save');
	return;
end

if nargin < 2 || isempty(file)
	file = me.get('File_');
	if isempty(file)
		file = inputname(1);
	end
	if isempty(file)
		file = 'ans';
	end
end

if ~ischar(file) || size(file, 1) > 1
	error('user:hstruct:savemat', 'expect a string as filename');
end

if length(file) < 5 || ~strcmp(file(end-3:end), '.mat')
	file = [file, '.mat'];
end

st = me.struct();
if ~strcmp(me.get('File_'), file)
	st.File_ = file;
end
save(file, '-struct', 'st');

end %F
