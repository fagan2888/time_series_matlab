function irfs = IRF(h, B, S, identification)

% B is the estimated coefficient of the (companion form) VAR
% S is the estimated var-covar matrix of the residuals
% ident...tion is the orthogonalization scheme (currently supported: shortrun)

if nargin < 3
    error('Not enough input arguments.')
elseif nargin == 3
    identification = 'short-run';
end

N = size(B, 1);

irfs = zeros(N, N, h);

switch identification
   
    case 'short-run'
        G = chol(S, 'lower');
        
        for j = 1 : h
            irfs(:, :, j) = G * B^(j-1);
        end
        
        
    case 'long-run'
        error('Currently unsupported identification scheme.')


end
