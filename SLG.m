function L = SLG(key0, u0, t)
global N
% key0 is initial value of Logistic map,
% u0 is system parameter of Logistic map,
% t is a parameter (t ~= 0, 0.5, 1), t is a member of F_N

% L is SOLS of order N.

% step1:
    L = zeros(N,N);

    x = zeros(1,N);
    x(1) = key0;
    for n = 1:N-1
        x(n+1) = u0*x(n)*(1-x(n));
    end

% step2:
    [~, lx] = sort (x);
    m = log2(N);
    e = repmat([0:2^m-1],2^m,1);
    f = gf(e,m);         % Create a Galois Matrix.
    
    AddGF8 = f + f'; % Add f to its own matrix transpose.
    MulGF8 = f.* f'; % Add f to its own matrix transpose.
    AddGF=uint16(AddGF8.x);
    MulGF=uint16(MulGF8.x);   
    
    for i=1:N
        for j=1:N
            L(i,j)= AddGF( MulGF(t+1,lx(i))+1, MulGF(AddGF(2,t+1)+1,lx(j))+1);
        end
    end


