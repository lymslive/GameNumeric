function out = savexml(me, varargin)
% save the struct to xml
%
% usage:
% me.savexml(file, rootname, [mode])
% str = me.savexml(rootname, [mode])
%
% mode:
% -data(1): default, save the data to file_d.xml
% -frame(2): only save the struct-framw to file_f.xml
% -both(3): save tow xml files
%
% dependence:
%   xmlbox/mat2xfrag; mat2xframe;
%
% maintain: lymslive / 2015-12-11
%

if nargout == 0
    file = varargin{1};
    if isempty(file) || ~ischar(file) || size(file, 1) > 1
        error('savexml@hstrut, expect a filename as scalar string');
    end
    varargin(1) = [];
end

narg = length(varargin);
if narg < 1 || isempty(varargin{1})
    rootname = inputname(1);
else
    rootname = varargin{1};
end

if ~isvarname(rootname)
    rootname = 'struct';
end

if narg < 2
    mode = 1;
else
    mode = varargin{2};
    if ~isnumeric(mode)
        try
            if regexpi(mode, '^-d')
                mode = 1;
            elseif regexpi(mode, '^-f')
                mode = 2;
            elseif regexpi(mode, '^-b')
                mode = 3;
            end
        catch
            mode = 1;
        end
    end
end
if mode < 1 || mode > 3
    fprintf('-data(1); -frame(2); or -both(3)\n');
    error('save@hstruct: support only 3 modes');
end

if mode == 1 || mode == 3
    xml = s_savedata(me, rootname);
    if nargout == 0
        if ~rexgexpi(file, '.xml')
            file = [file, '_d.xml'];
        end
        fid = fopen(file, 'w');
        fprintf(fid, xml);
        fclose(fid);
    else
        out = xml;
    end
end

if mode == 2 || mode == 3
    xml = s_saveframe(me, rootname);
    if nargout == 0
        if ~rexgexpi(file, '.xml')
            file = [file, '_f.xml'];
        end
        fid = fopen(file, 'w');
        fprintf(fid, xml);
        fclose(fid);
    else
        if mode == 3
            out = {out; xml};
        else
            out = xml;
        end
    end
end


end %F main

function xml = s_savedata(me, rootname)
xml = mat2xfrag(0, me.struct(), rootname);
end %F sub

function xml = s_saveframe(me, rootname)
xml = mat2xframe(0, me.struct(), rootname);
end %F sub
