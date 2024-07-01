clear all, close all, clc

% 第一題
% Define domain
L = pi;
N = 1024;
dx = 2*L/(N-1);
x = -L:dx:L; 
% Define hat function
f = 0*x;
dn = floor(1024/7);
%for i=1:dn    for j = -pi:0.01:-pi/3
%        f(i) = sin(j);
%    end
%end
f(1*dn+1:2*dn) = 1;
%for i=2*dn+1:3*dn
%    for j = pi/3:0.01:pi
%        f(i) = exp(j);
%    end
%end
f(3*dn+1:4*dn) = -1;
%for i=4*dn+1:5*dn
%    for j = 4*pi/3:0.01:5*pi/3
%        f(i) = cos(j);
%    end
%end
f(5*dn+1:6*dn) = 0;
plot(x,f,'-k','LineWidth',3.5), hold on
% Compute Fourier series
% k = 0
CC = jet(20);
A0 = sum(f.*ones(size(x)))*dx/pi;
fFS = A0/2;
for k=1:150
    A(k) = sum(f.*cos(pi*k*x/L))*dx/pi; % Inner product
    B(k) = sum(f.*sin(pi*k*x/L))*dx/pi;
    fFS = fFS + A(k)*cos(k*pi*x/L) + B(k)*sin(k*pi*x/L);
    plot(x,fFS,'-','Color',CC(k,:),'LineWidth',2)
    pause(.1)
end


%% 第二題
clear all, close all, clc

A = imread('dog.jpg');
Bclean = rgb2gray(A);
B_noisy = Bclean + 200 * normrnd(0,1);
figure(1) % 2.1
imagesc(B_noisy); colormap gray
Bt = fft2(B_noisy);    % B is grayscale image from above
Blog = log(abs(fftshift(Bt))+1);
figure(2) % 2.2
% noisy image on a log scale
imshow(mat2gray(Blog),[]);

% Compute the Fast Fourier Transform FFT
n = 1500;
fhat = fft(B_noisy,n);       % Compute the fast Fourier transform
PSD = fhat.*conj(fhat)/n; % Power spectrum (power per freq)
freq = 1/(.001*n)*(0:n); % Create x-axis of frequencies in Hz
L = 1:floor(n/2);   % Only plot the first half of freqs

% Use the PSD to filter out noise
indices = PSD>100;  % Find all freqs with large power
PSDclean = PSD.*indices;  % Zero out all others
fhat = indices.*fhat;  % Zero out small Fourier coeffs. in Y
Blog_clean = log(abs(fftshift(fhat))+1);
figure(3) % 2.3
% noisy image on a log scale
imshow(mat2gray(Blog_clean),[]);
ffilt = ifft(fhat); % Inverse FFT for filtered time signal
figure(4) % 2.4
imagesc(ffilt); colormap gray

%% 第三題
clear all, close all, clc
A = imread('dog.jpg');
B = rgb2gray(A);
figure(1)
subplot(2,2,1)
imshow(B)
title('Oringinal')
% FFT Compression
Bt=fft2(B);    % B is grayscale image from above
Blog = log(abs(fftshift(Bt))+1);

% Zero out all small coefficients and inverse transform
Btsort = sort(abs(Bt(:)));  % Sort by magnitude
counter = 2;
figure(1)
for keep=[.1 .03 .001];
    subplot(2,2,counter)
    thresh = Btsort(floor((1-keep)*length(Btsort)));
    ind = abs(Bt)>thresh;      % Find small indices
    Atlow = Bt.*ind;           % Threshold small indices
    Alow=uint8(ifft2(Atlow));  % Compressed image
    imshow(Alow)      % Plot Reconstruction
    title(['',num2str(keep*100),'%'],'FontSize',10)
    counter = counter + 1;
end

%% 第四題
clear all, close all, clc
load 'data.csv'

atrue = data(:,1)\data(:,2);
hold on 
xlabel('x')
ylabel('y')
xgrid = -2:.01:2;
axis([-2 2 -8 2])
% 4.1
scatter(data(1:29,1),data(1:29,2),100,'ko','MarkerFaceColor','b')
scatter(data(31:end-1,1),data(31:end-1,2),100,'ko','MarkerFaceColor','b')
scatter(data(50,1),data(50,2),100,'ko','MarkerFaceColor','r')
scatter(data(30,1),data(30,2),100,'ko','MarkerFaceColor','r')
legend('Data','Data','Outlier','Outlier')
%% 4.2
cvx_begin;       % L1 optimization to reject outlier
    variable aL1;     % aL1 is slope to be optimized 
    minimize( norm(aL1*data(:,1)-data(:,2),1) );     % aL1 is robust
cvx_end;

hold on
xlabel('x')
ylabel('y')
scatter(data(1:29,1),data(1:29,2),100,'ko','MarkerFaceColor','b')
scatter(data(31:end-1,1),data(31:end-1,2),100,'ko','MarkerFaceColor','b')
scatter(data(50,1),data(50,2),100,'ko','MarkerFaceColor','r')
scatter(data(30,1),data(30,2),100,'ko','MarkerFaceColor','r')
plot(xgrid,xgrid*aL1,'b','LineWidth',2)    % L1 fit
legend('Data','Data','Outlier','Outlier','L1 fit')
%% 4.3 % L2 fit
aL2 = data(:,1)\data(:,2);
hold on
xlabel('x')
ylabel('y')
scatter(data(1:29,1),data(1:29,2),100,'ko','MarkerFaceColor','b')
scatter(data(31:end-1,1),data(31:end-1,2),100,'ko','MarkerFaceColor','b')
scatter(data(50,1),data(50,2),100,'ko','MarkerFaceColor','r')
scatter(data(30,1),data(30,2),100,'ko','MarkerFaceColor','r')
plot(xgrid,xgrid*aL2,'r--','LineWidth',2)
legend('Data','Data','Outlier','Outlier','L2 fit')
%% 4.4 
cvx_begin;       % L1 optimization to reject outlier
    variable aL1;     % aL1 is slope to be optimized 
    minimize( norm(aL1*data(:,1)-data(:,2),1) );     % aL1 is robust
cvx_end;
hold on
xlabel('x')
ylabel('y')
scatter(data(1:29,1),data(1:29,2),100,'ko','MarkerFaceColor','b')
scatter(data(31:end-1,1),data(31:end-1,2),100,'ko','MarkerFaceColor','b')
plot(xgrid,xgrid*aL1,'r--','LineWidth',2)    % L1 fit
legend('Data','Data','L1 fit')





