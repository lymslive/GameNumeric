% Area: a class drived from hstruct to manage a project .mat file
%
% maintain: lymslive / 2015-12-09
classdef Area < hstruct

methods % basic methods
function me = Area(st)

if nargin == 0
    st.Class_ = 'Area';
end
me@hstruct(st);

end %F ctor
end %M

methods % addon methods

% add subpath base on my project to Matlab search path
% return the successfully added subpath
% if no extra input when called by me.addpath()
% add the path save in the subpath
function n = addpath(me, varargin)

n = 0;
if nargin < 2
    subpath = me.get('subpath');
    if isempty(subpath) || ~iscellstr(subpath)
        return;
    end
    for i = 1 : length(subpath)
        fullpath = [me.get('base'), filesep, subpath{i}];
        if exist(fullpath, 'dir') == 7
            addpath(fullpath);
            n = n+1;
        end
    end
end

for i = 1 : nargin - 1
    arg = varargin{i};
    if ischar(arg) && size(arg, 1) <= 1
        fullpath = [me.get('base'), filesep, arg];
        if exist(fullpath, 'dir') == 7
            addpath(fullpath);
            n = n+1;
            try
                subpath = me.get('subpath');
                if ~ismember(arg, subpath)
                    subpath{end+1} = arg;
                end
                me.set('subpath', subpath);
            catch
                me.set('subpath', {arg});
            end
        else
            error('addpath@Area: path Not exist: %s', fullpath);
        end
    else
        error('addpath@Area: expects sacalar string as subpath');
    end
end

end %F

% save project file
% cannot save workspace since this is object methods
function tf = save(me)
tf = false;
if  ~strcmp(me.get('Class_'), 'Area')
    me.set('Class_',  'Area');
end
try
    filename = [me.get('base'), filesep, me.get('project')];
    st = me.struct();
    save(filename, '-struct', 'st');
    disp(['save project to : ', filename]);
    tf = true;
catch
    disp(['Cannot save project to file']);
end
tf = true;
end %F

end %M

end %C
