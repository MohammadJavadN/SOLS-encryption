function P = D(C, K, t)
L = SLG(K(1), K(2), t);
P2 = ipermutation2(C, L);
P1 = iXOR(P2, L, K);
P = ipermutation1(L, P1);
P = iXOR(P, L, K);
end

function P2 = iXOR(m, L, K)
global N
m = double(m);
p = double(zeros(1, N*N));
l = double(reshape(L, 1, N*N));
u1 = K(4);
k1 = K(3);
m_1 = mod((u1 * k1 * (1 - k1) * 10^14), 256);
fm = (u1 * (m_1/1000) * (1 - m_1/1000));
M = mod(fm * 1000 + l(1), 256);
p(1) = bitxor(m(1), floor(M));
for i = 1: N*N - 1
    fm = (u1 * (m(i)/1000) * (1 - m(i)/1000));
    M = (mod(fm * 1000 + l(i+1), 256));
    p(i+1) = bitxor(m(i+1), floor(M));
end
P2 = uint8((reshape(p, N, N)));
end

function P = ipermutation1(L, P1)
P = uint8(ones(size(P1)));
for i = 1:size(P1, 1)
    for j = 1:size(P1, 2)
        P(L(i,j)+1, L(j, i)+1) = P1(i, j);
    end
end
end

function P2 = ipermutation2(C, L)
global N
k2=1;
for j=1:N
    for i=1:N
        P3(L(i, k2)+1, j) = C(i, j);
    end
    k2 = C(N, j)+1;
end
k1=1;
for i=1:N
    for j=1:N
        P2(i, L(k1, j)+1) = P3(i, j);
    end
    k1 = P3(i, N)+1;
end
end
