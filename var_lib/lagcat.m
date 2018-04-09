function X = lagcat(x, p)

% Assuming first dimension (rows) run along time indices.
% Assuming second dimension (columns) run along variable indices.
% Assuming contiguous time series (no NaNs in the middle of the series).
% Assuming contiguous lags, i.e., j \in {1, 2, 3, ..., p}.

T = size(x, 1);
N = size(x, 2);

if nargin == 1
    p = 1;
end

if p > T
    error('Requesting too many lags wrt length of time series (p>T).')
end

Xtm1 = zeros(T, N*p);

for j = 1 : p
    Xtm1(:, N*(j-1)+1:j*N) = [nan(j, N); lag(x, j)];
end 

X = [x, Xtm1];

end
