% FINISHSAV  Save workspace variables  
%   Change the name of this file to FINISH.M 
%   and put it anywhere on your MATLAB path.
%   When you quit MATLAB this file will be executed.
%   This script saves all the variables in the 
%   work space to a MAT-file.  

%   Copyright 1984-2000 The MathWorks, Inc. 
%   $Revision: 1.4 $  $Date: 2000/06/01 16:19:26 $
%   Autor: lymslive

lastpath_ = pwd;
% startdir = '~/.matlab';
startdir = 'd:/MATLAB/work';
cd(startdir);
disp('Saving workspace data to "recent.mat"');
clear startdir;
save recent;
disp(['% Now is: ' datestr(now) 'MATLAB work END.']);
diary off;

