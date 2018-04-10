function [b, s2] = ols(y, x, dof)

% Assuming first dimension (rows) run along time indices.
% Assuming second dimension (columns) run along variable indices.
% Assuming contiguous time series (no NaNs in the middle of the series).
% Assuming contiguous lags, i.e., j \in {1, 2, 3, ..., p}.

T = size(x, 1);
N = size(x, 2);

if nargin < 3
    dof = T - N;
end

if size(y, 1) ~= T
    error('LHS does not have equal amount of obs. as RHS.')
end

ixx = (x' * x) \ eye(N);

b = ixx * (x' * y);

if nargout > 1
    resid = y - x * b;
    s2 = (resid' * resid) ./ dof;
end

end
