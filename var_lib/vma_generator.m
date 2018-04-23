function Y = vma_generator(T, W)

% Generates artificial data from a VMA(q+1) process
% T: number of obs over time
% W: Wold coefficients - [N x N x q+1] array - such that
%    W(:, :, 1) are coeffs for the contemporaneous innovations
%    W(:, :, q) are the coeffs for the q-th past innovations

N = size(W, 1);

if size(W, 2) ~= N
    error('Matrices of Wold coefficients must be square.')
end

q = size(W, 3);

TT = T * 3;  % to ameliorate reliance on initial condition

y = zeros(TT, N);
e = randn(TT, N);

for t = q+1 : TT
    new_obs = e(t, :) * W(:, :, 1);
    for j = 1 : q
        new_obs = new_obs + e(t-j, :) * W(:, :, j+1);
    end
    y(t, :) = new_obs;
end

Y = y(end-T:end, :);

end
