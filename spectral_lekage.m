fs = 1e3;

n=0:1/fs:(5079/fs)-1;

x_n=sin(2*50*pi*n);
X_k=fft(x_n)/length(n);

figure(1)
plot(n,x_n);
axis([0 0.1 -1.2 1.2])

figure(2)
stem(abs(X_k));
axis([200 210 -0.01 0.51])

n1=0:1/fs:(5099/fs)-1;
x_n1=sin(2*50*pi*n1);
X_k1=fft(x_n1)/length(n1);

figure(3)
plot(n1,x_n1);
axis([0 0.1 -1.2 1.2])

figure(4)
stem(abs(X_k1));
%axis([150 250 -0.01 0.51])

% intgeral multiple of 20 will make signal periodic and no leakage