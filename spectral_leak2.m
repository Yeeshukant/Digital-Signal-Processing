% refer to example section 7.4 page 488 proakis 4ed
fs = 1e3;

n=0:1/fs:((1e5-1)/fs);

x_n=cos(2*50*pi*n);
X_k=fft(x_n)/length(n);

f = fs*(1:length(n))/length(n);

figure(1)
plot(n,x_n);
%axis([0 0.1 -1.2 1.2])
%%
figure(2)
%stem((2*pi*f),abs(X_k));
stem((f),abs(X_k));
%axis([200 210 -0.01 0.51])
%%
w=ones(1,1010);
n1=[w (zeros(1,length(n)-length(w)))+1];
%%
x_n1=x_n.*n1;
X_k1=fft(x_n1)/length(n1);

figure(3)
plot(n1,x_n1);
%axis([0 0.1 -1.2 1.2])

figure(4)
stem(abs(X_k1));
%axis([150 250 -0.01 0.51])

% intgeral multiple of 20 will make signal periodic and no leakage