clear all, close all, clc
% 第3題
A = imread( 'flickr_dog.jpg');
X = double(rgb2gray(A));
nx = size(X,1); ny = size(X,2);
[U,S,V] = svd(X);

figure(1), subplot(2,2,1)
imagesc(X), axis off, colormap gray 
title('Original')

plotind = 2;
for r=[10 50 80];  % Truncation value
    Xapprox = U(:,1:r)*S(1:r,1:r)*V(:,1:r)'; % Approx. image
    subplot(2,2,plotind), plotind = plotind + 1;
    imagesc(Xapprox), axis off
    title(['r=',num2str(r,'%d'),', ',num2str(100*r*(nx+ny)/(nx*ny),'%2.2f'),'% storage']);
end
set(gcf,'Position',[100 100 550 400])
%% 第4題
N = size(X,1);
sigma = 1;
cutoff = (4/sqrt(3))*sqrt(N)*sigma; % Hard threshold
r = max(find(diag(S)>cutoff)); % Keep modes w/ sig > cutoff
Xclean = U(:,1:r)*S(1:r,1:r)*V(:,1:r)';
figure(2), subplot(1,2,1)
imagesc(X), axis off, colormap gray
title('Original') 
subplot(1,2,2)
imagesc(Xclean)
title('Optimal Threshold')
%% 第5題
I = cell(1,50);
alldog = zeros(512*8,512*8);
n = 512;
m = 512;
count = 1;
for i= 2:9
    name = strcat('flickr_dog_00000', num2str(i),'.jpg');
    I = imread(name);
    Z = double(rgb2gray(I));
    figure(3)
    subplot(8,8,i-1)
    imagesc(Z),axis off, colormap gray 

end
for i = 10:42
    name = strcat('flickr_dog_0000', num2str(i),'.jpg');
    I = imread(name);
    Z = double(rgb2gray(I));
    subplot(8,8,i-1)
    imagesc(Z),axis off, colormap gray 
end
for i = 46:53
    name = strcat('flickr_dog_0000', num2str(i),'.jpg');
    I = imread(name);
    Z = double(rgb2gray(I));
    subplot(8,8,i-3)
    imagesc(Z),axis off, colormap gray 
end
name = strcat('flickr_dog_000044.jpg');
I = imread(name);
Z = double(rgb2gray(I));
subplot(8,8,42)
imagesc(Z),axis off, colormap gray 

%% 第6題
r = 50; % Target rank
q = 1;   % Power iterations
p = 5;   % Oversampling parameter
A = imread( 'flickr_dog.jpg');
X = double(rgb2gray(A));
[rU,rS,rV] = rsvd(X,r,q,p); % Randomized SVD
XrSVD = rU(:,1:r)*rS(1:r,1:r)*rV(:,1:r)'; % rSVD approx.
errrSVD = norm(X-XrSVD,2)/norm(X,2);

figure(4)
subplot(1,2,1)
imagesc(X), axis off, colormap gray 
title('Original')
subplot(1,2,2)
imagesc(XrSVD), axis off, colormap gray
title('rSVD')

