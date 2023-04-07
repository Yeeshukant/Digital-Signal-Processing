% Name - Yeeshukant
% Rollno. - 200002082
% DCT for compression

% Initial Signal Setup
% Load audio file
[x_n,fs]=audioread('music.wav');
L = length(x_n)-1;
X_k=dct(x_n);

figure(1)
plot(X_k);
title('DCT of original signal')
xlabel('No. of sample')

% Zonal Compression
% 95% compression
err0=calcErrorZonal(x_n,5);

% 90% compression
err1=calcErrorZonal(x_n,10);

% 80% compression
err2=calcErrorZonal(x_n,20);

% 70% compression
err3=calcErrorZonal(x_n,30);

% 60% compression
err4=calcErrorZonal(x_n,40);

% 50% compression
err5=calcErrorZonal(x_n,50);

% 40% compression
err6=calcErrorZonal(x_n,60);

% 30% compression
err7=calcErrorZonal(x_n,70);

% 20% compression
err8=calcErrorZonal(x_n,80);

% 10% compression
err9=calcErrorZonal(x_n,90);

figure(2)
stem([5 10 20 30 40 50 60 70 80 90],[err0,err1,err2,err3,err4,err5,err6,err7,err8,err9]);
title('Mean Squared Error plot (DCT Zonal Compression)')
xlabel('% Coefficients Retained')
ylabel('MSE value')

[Err0, coeffpc0] = thresError(x_n,96);
[Err1, coeffpc1] = thresError(x_n,96.5);
[Err2, coeffpc2] = thresError(x_n,97);
[Err3, coeffpc3] = thresError(x_n,97.5);
[Err4, coeffpc4] = thresError(x_n,98);
[Err5, coeffpc5] = thresError(x_n,98.5);
[Err6, coeffpc6] = thresError(x_n,99);
[Err7, coeffpc7] = thresError(x_n,99.5);
[Err8, coeffpc8] = thresError(x_n,99.8);
[Err9, coeffpc9] = thresError(x_n,99.9);

coeff=[coeffpc0,coeffpc1,coeffpc2,coeffpc3,coeffpc4,coeffpc5,coeffpc6,coeffpc7,coeffpc8,coeffpc9];
ERR = [Err0,Err1,Err2,Err3,Err4,Err5,Err6,Err7,Err8,Err9];

figure(3)
stem(coeff,ERR)
title('Mean Squared Error plot (DCT Threshold Compression)')
xlabel('% coeffs.')
ylabel('MSE value')
snapnow

function [error,thres] = thresError(x_n,Threshold)
X_k = dct(x_n);
[XX, ind] = sort(abs(X_k),'descend');
index=1;
while norm(X_k(ind(1:index)))/norm(X_k)<Threshold/100
    index=index+1;
end

coeffpc = index/length(X_k)*100;

X_k(ind(index+1:end)) = 0;
reconx = idct(X_k);
error = immse(reconx,x_n);
thres=coeffpc;
end

function error = calcErrorZonal(x_n,coeffRetain)
X_k = dct(x_n);
L=length(X_k)-1;
fil=[ones(1,L*coeffRetain/100),zeros(1,(L+1-(L*coeffRetain/100)))];
newX_k=X_k.*fil';
reconx=idct(newX_k);

error=immse(reconx,x_n);
end