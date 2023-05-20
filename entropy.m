function [h] = entropy(x)
global N
x = double(x);
xh = hist( x(:), N);
xh = xh / sum(xh(:));
i = find(xh);
h = - sum(xh(i).*log2(xh(i)));
end
