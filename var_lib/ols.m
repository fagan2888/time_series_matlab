function b = ols(y, x)

b = x' * x \ x' * y;

end