function [xtp1, xt] = lead(x, p)

% Assuming first dimension (rows) run along time indices.
% Assuming second dimension (columns) run along variable indices.
%
% Given column vectors x (or set of columns in a matrix), returns the led
% version of it.

if nargin == 1
    p = 1;
end

xtp1 = x(p+1:end, :);

if nargout > 1
    xt = x(1:end-p, :);
end

end
