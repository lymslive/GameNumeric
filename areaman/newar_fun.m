% newpar_fun: new area function
% 创建新项目
%
% Input:
%   @name: 项目名称，字符串类型，将以 name 为名称在当前目录下创建子目录，
%    所以 name 须是合法的目录名，与 matlab 变量名；
%    省略时，将试图在当前目录下创建项目，以当前目录名作为项目名称。
%
% output:
%   @area: 如果顺利，将返回一个表示项目的对象（结构体）
%    并在项目目录下保存一个项目信息文件 ${name}_ar.mat，
%    及工作区数据文件 ${name}_ws.mat
%
% struct: 项目文件数据 area 包含的信息
%   .base: 目录名路径
%   .name: 项目名称
%   .project: 保存项目的文件名 *_ar.mat
%   .subpath: 需要加入到 Matlab 搜索路径的项目子目录，cellstr
%   .workspace: 保存项目工作区的文件名称 *_ws.mat
%   .filter: 需要保存的工作区的变量名，正则表达式过滤
%            默认是 4 个字母以上纯字母变量
%
% maintain: lymslive / 2015-11

function area = newar_fun(name)

prj = struct;

if nargin >= 1

    if ~isdir(name)
        [status, message] = mkdir(name);
        if ~status
            error(message);
        end
    end

    cd(name);
    prj.base = pwd;
    prj.name = name;

else
    prj.base = pwd;
    [pathstr, name, ext] = fileparts(prj.base);
    prj.name = name;
end

prj.project = [name, '_ar.mat'];

% 当前路径也加入路径，让 Matlab 进入子目录时仍可用
prj.subpath = {};
prj.subpath{1} = '.';

% 如果子目录有 .m 或 .mat ，则添加到 .subpath
% 只搜索直接子目录，不递归
sublist = dir();
for i = 1 : length(sublist)
    sub = sublist(i);
    if sub.isdir && ~strcmp(sub.name, '.') && ~strcmp(sub.name, '..')
        if length( dir([sub.name, filesep, '*.m']) ) > 0 ... 
            || length( dir([sub.name, filesep, '*.mat']) ) > 0 
            prj.subpath{end+1} = sub.name;
        end
    end
end

prj.workspace = [name, '_ws.mat'];
prj.filter = '^[a-zA-Z]{4,}$';

% 保存项目信息文件 
save(prj.project, '-struct', 'prj');
disp(['Create and saved: ', prj.project]);

% 保存工作区数据文件，新项目初始只有示例 ans 变量
ans = ['New area: ' name];
save(prj.workspace, 'ans');
disp(['Create and saved: ', prj.workspace]);

area = prj;

end %-of main
