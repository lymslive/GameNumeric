% startup.m: called by %MATLABROOT/toolbox/local/matlabrc.m in searth path

startdir = 'd:/MATLAB/work';
% startdir = '~/.matlab';
cd(startdir);

% get time and transform to yyyymmdd
ct=now;
yy=datestr(ct, 10);
md=datestr(ct,6);
md=regexprep(md,'/','');
ymd=[yy md];
ti=datestr(ct,13);

% record log with filename based on date
logPath = [pwd filesep 'log'];
if exist(logPath, 'dir') ~= 7
    mkdir('log');
end
logName=[logPath filesep 'matlab' ymd '.log'];
diary(logName);
disp(['% Now is: ' datestr(now) 'MATLAB work BEGIN...']);
clear;

% load last workspace saveed in recent.mat, and cd to last work directory
load recent lastpath_;
try
	cd (lastpath_);
catch
	disp('can not cd to last path!');
end
load recent;
clear lastpath_;

% show current
disp(pwd);
whos;

% additional path
% addpath('d:/MATLAB/work/toolbox/xml');
% addpath('d:/MATLAB/work/toolbox/xml/xml_io_tools');
