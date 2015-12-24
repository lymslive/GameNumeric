function out = approachmean(fun, nview, varargin)
% repeated call a function to investigate it's mean result
%   out = approachmean(fun, nview, varargin)
%
% Input:
%  fun: a function handle or name
%  nview: a int number, or number vector with order
%
% Deal:
%  call fun(varargin{:}) for N times, where N = nview(end),
%  calculate the mean value of it's output result at each step,
%  if the current times reach the one specify in nview vector,
%  save this mean result by now to outarg.
%
%  This function is usually used to drive a simualte fun with random cases,
%  since the N may be large, it won't save the all result in N times,
%  but only capture the interested point times in nview argin.
%  It save memory space but require more run time for large N.
%
%  If nview is input as a sclar number, then it will extend to a vector with
%  linspace(1, nview), or 1:nview if it is smaller than 100.
%
% Output:
%  out: a cell array with the same size of nview vector.
%   the result output of fun, may be a array with unknow size
%   so it's own out use cell to save mean value of fun's result.
%
%   If no nargout, it will automatically plot out with nview, to see the mean
%   result curve along the simulated times. But the `ans` variable is still
%   overwrite by this function.
%
% maintain: lymslive / 2015-12-23

if numel(nview) == 1
    if nview <= 100
        nview = (1 : nview);
    else
        nview = round(linspace(1, nview));
    end
end

maxn = nview(end);
cmean = 0;

out = cell(size(nview));
n = 1;

for i = 1 : maxn
    result = feval(fun, varargin{:});
    cmean = (cmean * (i-1) + result) / i;
    if i == nview(n)
        out{n} = cmean;
        n = n + 1;
    end
end

if nargout == 0
    plot(nview, out);
    xlabel('simulated times');
    ylabel('mean value');
    title(['last value = ' mat2str(out)]);
end

end %F main
