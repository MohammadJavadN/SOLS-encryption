clc
clear
close all
%% 3. encryption
global N 
P = imread('lena256.bmp');
N = length(P);
t = 3;
K = [0.12345678, 3.99999, 0.12345678, 3.99999];
tic;
[C, L] = OE(P, K, t);
fprintf('Encryption Time = %f\n',toc);

% decryption
tic
P_2 = D(C, K, t);
fprintf('\nDecryption Time = %f\n\n',toc);

%% ploting result
figure();
subplot(2,2,1)
imshow(P)
title('Plaint image')

subplot(2,2,2)
imshow(C)
title('ciphertext image')

subplot(2,2,3)
imshow(P_2)
title('recovered plaintext image')

%% 4. Simulation results and security analysis
% 4.1.2.(1) Key sensitivity analysis in encryption stage
fprintf('\nKey sensitivity analysis in encryption stage:\n')
K2 = [0.12345678 + 10^-14, 3.99999, 0.12345678, 3.99999];
[C2, L2] = OE(P, K2, t);


subplot(1,2,1)
imshow(C)
title('C1 image')
subplot(1,2,2)
imshow(C2)
title('C2 image')
fprintf('percent of diffrent pixel = ')
showPercentOfDiffrentPixel(C, C2);

%% 4.1.2.(2) Key sensitivity analysis in decryption stage
fprintf('\nKey sensitivity analysis in decryption stage:\n')
E0 = C;
K = [0.12345678, 3.99999, 0.12345678, 3.99999];
P1 = D(E0, K, t);

K2 = [0.12345678 + 10^-14, 3.99999, 0.12345678, 3.99999];
P2 = D(E0, K2, t);

figure()
subplot(1,2,1)
imshow(P)
title('original image')
subplot(1,2,2)
imshow(P1)
title('decrypted image using the correct key')
fprintf('The percentage of different pixels between the two images (using the correct key) = ')
showPercentOfDiffrentPixel(P, P1);

figure()
subplot(1,2,1)
imshow(P)
title('original image')
subplot(1,2,2)
imshow(P2)
title('decrypted image using the modified key')
fprintf('The percentage of different pixels between the two images (using the modified key) = ')
showPercentOfDiffrentPixel(P, P2);

%% 4.2. Histogram analysis
figure()
subplot(2,2,1)
imshow(P)
title('original image')

subplot(2,2,2)
imhist(P)
title('original image histogram')

subplot(2,2,3)
imshow(C)
title('ciphertext image')

subplot(2,2,4)
imhist(C)
title('ciphertext image histogram')

%% 4.3. Correlation analysis
fprintf('\nCorrelation analysis:')
AdjancyCorrPixelRandNew(P,C);
%% 4.4. Information entropy analysis
disp(['Entropy values of Lena  = ', num2str(entropy(P))])
disp(['Entropy values of Lena in the Proposed algorithm = ', num2str(entropy(C))])

%% 4.5. Differential attack analysis
% % %Encryption and Decryption for 1 bit change in Plain Image
fprintf('\nNPCR and UACI Test:')

P1bit=P;      %Image size 256*256;
pos1=1+floor(rand(1)*N);
pos2=1+floor(rand(1)*N);

fprintf('\nBefore change 1 bit of PlainImage at location (%d,%d) = %d',pos1,pos2,P1bit(pos1,pos2));
P1bit(pos1,pos2) =mod(P1bit(pos1,pos2)+1,255);
%PlainImg1bit(pos3,pos4) = mod(PlainImg1bit(pos3,pos4)-1,255);
fprintf('\nAfter change 1 bit of PlainImage at location (%d,%d) = %d\n',pos1,pos2,P1bit(pos1,pos2));
[C1bit, ~] = OE(P1bit, K, t);
[npcr,uaci] = NPCR_UACI(uint8(C), uint8(C1bit));
fprintf('\nNPCR = %f   UACI=%f \n',npcr, uaci);






