function [xtm1, xt] = lag(x, p)

% Assuming first dimension (rows) run along time indices.
% Assuming second dimension (columns) run along variable indices.
%
% Given column vectors x (or set of columns in a matrix), returns the lagged
% version of it.

if nargin == 1
    p = 1;
end

xtm1 = x(1:end-p, :);

if nargout > 1
    xt = x(1+p:end, :);
end

end