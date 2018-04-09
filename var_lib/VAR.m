function [B, S] = VAR(X, p)

% Assuming first dimension (rows) run along time indices.
% Assuming second dimension (columns) run along variable indices.
% Assuming contiguous time series (no NaNs in the middle of the series).
% Assuming contiguous lags, i.e., j \in {1, 2, 3, ..., p}.

% Steps:
% 1) constructing the companion form
% 2) running ols

%% Step 1: constructing the companion form

N = size(X, 2);

tmp = lead(lagcat(X, p), p);
x1 = tmp(:, 1:end-N);
x0 = tmp(:, N+1:end);


%% Step 2: running OLS

[B, S] = ols(x1, x0);


end
