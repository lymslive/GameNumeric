function out = hcd(varargin)
% hcd, hot cd or history cd
% same as cd command to change current dirctor, but also maintain a cd
% history, make later cd to some recent path more convenient.
%
% usge:
% - hcd(); list the recent 8 directories
% - hcd(newdir); cd to newdir, and add newdir to history
% - hcd(number); cd to the nth dir in history list
% - hcd(-number); remove the nth path in history list
%
% hcd history:
% hcd_ls.mat is in the same dirctory as this script file, hcd.m, and
% in the .mat file contain s cellstr variable named `hcdhistory`.
% hcdhistory, hold 16 itms at most, each is a absolut fullpath.
% The recent used directory push to hcdhistory, has highest index,
% but in user list view, as hcd(), hcdhistory is in reverse order, that
% the more recnet dir list first, seam as it's index is 1.
%
% attention:
% Can use in command stype > hcd newdir
% and in command stype, number such as 1 is pass in string aslo '1'
% if newdir is pwd, add pwd to history, but not triggle cd command.
%
% output:
% outpus is optional
% return the newdir in fullpath, or the nth recent path
% out = hcd(); return full cellstr, in reverse order
% in output case, only return value, but not cd actually.
%
% maintain: lymslive / 2015-12-13

thisfile = mfilename('fullpath');
pathstr = fileparts(thisfile);
matfile = [pathstr, filesep, 'hcd_ls.mat'];

maxlist = 8;
maxsave = 16;

try
    saved = load(matfile);
catch
    saved.hcdhistory = {};
end

if nargin == 0
    if nargout == 0
        n = 1;
        for i = numel(saved.hcdhistory) : -1 : 1
            fprintf('%d: %s\n', n, saved.hcdhistory{i});
            n = n + 1;
            if n > maxlist
                break;
            end
        end
    else
        out = [saved.hcdhistory(end : -1 : 1)];
    end
    return;
end

arg = varargin{1};

if ischar(arg)
    num = str2num(arg);
    if ~isempty(num) && numel(num) <= 1
        arg = num;
    end
end

if ischar(arg)
    validateattributes(arg, {'char'}, {'row'}, ...
    mfilename, 'hisnumber', 1);

    olddir = pwd;
    if isempty(arg) || strcmp(arg, '.');
        fullpath = pwd;
    else
        try
            cd(arg);
            fullpath = pwd;
        catch
            fprintf('hcd cannot cd to dir: %s\n', arg);
            return;
        end
    end

    list = cList(saved.hcdhistory);
    num = list.of(fullpath, @strcmp);
    if num > 0
        list.up(num);
    else
        list.push(fullpath);
    end

    if nargout > 0
        out = pwd;
        cd(olddir);
    end

    if list.count > maxsave
        list.pop(1);
    end
    hcdhistory = list.cell();
    save(matfile, 'hcdhistory');

elseif isnumeric(arg)
    validateattributes(arg, {'numeric'}, {'integer', '>=', -8, '<=', 8, 'nonzero'}, ...
    mfilename, 'hisnumber', 1);

    list = cList(saved.hcdhistory);
    if abs(arg) > list.count
        error('hcd: no such more history directory');
    end

    if arg > 0
        if arg > 1
            list.up(list.count - arg + 1);
        end
        if nargout == 0
            cd(list.top());
        else
            out = list.top();
        end

    elseif arg < 0
        arg = -arg;
        old = list.pop(list.count - arg + 1);
        if nargout == 0
            for i = 1 : min(list.count, maxlist)
                rn = list.count - i + 1;
                fprintf('%d: %s\n', i, list.top(rn));
            end
        else
            out = old;
        end
    end

    if arg ~= 1
        hcdhistory = list.cell();
        save(matfile, 'hcdhistory');
    end

else
    error('hcd expector a scalar string or number([1,8])');
end

end %F main
