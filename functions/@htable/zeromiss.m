function me = zeromiss(me, varargin)
% replace all missing value with zero
% me.zeromiss(varargin)
% any argin is passed to ismissing, to select the missing value
%
% lymslive / 2015-12

me.tab_{:,:}(ismissing(me.tab_, varargin{:})) = 0;
end %F main
