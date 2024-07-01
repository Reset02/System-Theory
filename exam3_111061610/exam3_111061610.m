clear all, close all, clc
% 第一題
% 1.
load testSys.mat
% 2. Plot Hankel singular values
hsvs = hsvd(sysFull); % Hankel singular values
r = 10;  % Reduced model order
figure(1)
subplot(1,2,1)
semilogy(hsvs,'k','LineWidth',2)
hold on, grid on
semilogy(r,hsvs(r),'bo','LineWidth',2)
subplot(1,2,2)
plot(0:length(hsvs),[0; cumsum(hsvs)/sum(hsvs)],'k','LineWidth',2)
hold on, grid on
plot(r,sum(hsvs(1:r))/sum(hsvs),'bo','LineWidth',2)
% 3. Choose a reduced model order
r = 7;  % Reduced model order
figure(2)
subplot(1,2,1)
semilogy(hsvs,'k','LineWidth',2)
hold on, grid on
semilogy(r,hsvs(r),'bo','LineWidth',2)
subplot(1,2,2)
plot(0:length(hsvs),[0; cumsum(hsvs)/sum(hsvs)],'k','LineWidth',2)
hold on, grid on
plot(r,sum(hsvs(1:r))/sum(hsvs),'bo','LineWidth',2)
fprintf('r = 7 that the reduced model can capture over 80 percent of the input-output energy')
% 4. Exact balanced truncation
r1 = 10;
sysBT_10 = balred(sysFull,r1);  % Balanced truncation
r2 = 7;
sysBT_7 = balred(sysFull,r2);
% Plot impulse responses for all methods
figure(3)
Tend=50;
impulse(sysFull,0:1:Tend), hold on;
impulse(sysBT_10,0:1:Tend), hold on ;
impulse(sysBT_7,0:1:Tend)
legend('Full model, n=150','Balanced truncation, r=10','Balanced truncation, r=7')
% 5.Plot the step responses
figure(4)
Tend=50;
step(sysFull,0:1:Tend), hold on;
step(sysBT_10,0:1:Tend), hold on ;
step(sysBT_7,0:1:Tend)
legend('Full model, n=150','Balanced truncation, r=10','Balanced truncation, r=7')
%% 第二題 specs= steady-error = 5% , 44 <= P.M. <= 46°
dt = 0.001;
PopSize = 25;
MaxGenerations = 10;
s = tf('s');
Gs = 1/(s^2+12s+36);
figure(5)
margin(Gs)
K = 0.9;
omega_c = 14.5; % center frequency x-(-180) = 45 x=-135 從Phase圖上點找出
attenuation_db = -47.8; % 再從GAIN圖wn=14.5點找出Magnitude大小
z = omega_c/10;
alpha = 10^(attenuation_db/20);
p = z/alpha;
G = tf([1 z],[1 p]);
L = K * (p/z) * G * Gs;
figure(6)
margin(L)
% options = optimoptions(@ga,'PopulationSize',PopSize,'MaxGenerations',MaxGenerations,'OutputFcn',@myfun);
% [x,fval] = ga(@(K)pidtest(G,dt,K),3,-eye(3),zeros(3,1),[],[],[],[],[],options);


