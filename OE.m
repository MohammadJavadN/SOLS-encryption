function [C, L] = OE(P, K, t)
L = SLG(K(1), K(2), t);
P = XOR(P, L, K);
P1 = permutation1(L, P);
P2 = XOR(P1, L, K);
C = permutation2(P2, L);
end

function P2 = XOR(P1, L, K)
global N
p = double(reshape(P1, 1, N*N));
l = double(reshape(L, 1, N*N));
u1 = K(4);
k1 = K(3);
m = double(zeros(1, N*N));
m_1 = mod((u1 * k1 * (1 - k1) * 10^14), 256);
fm = (u1 * (m_1/1000) * (1 - m_1/1000));
M = mod(fm * 1000 + l(1), 256);
m(1) = bitxor(p(1), floor(M));

for i = 1: N*N - 1
    fm = (u1 * (m(i)/1000) * (1 - m(i)/1000));
    M = (mod(fm * 1000 + l(i+1), 256));
    m(i+1) = bitxor(p(i+1), floor(M));
end
P2 = uint8((reshape(m, N, N)));
end

function P = permutation1(L, I)
P = zeros(size(I));
for i = 1:size(I, 1)
    for j = 1:size(I, 2)
        P(i, j) = I(L(i,j)+1, L(j, i)+1);
    end
end
end

function C = permutation2(P2, L)
global N
k1=1;
for i=1:N
    for j=1:N
        P3(i, j) = P2(i, L(k1, j)+1);
    end
    k1 = P3(i, N)+1;
end
k2=1;
for j=1:N
    for i=1:N
        C(i, j) = P3(L(i, k2)+1, j);
    end
    k2 = C(N, j)+1;
end
end
