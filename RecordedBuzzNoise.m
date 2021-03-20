clear all
clc
set(0,'defaultfigurecolor','w');

[y_buzz,Fs_buzz]=audioread('Audio recording 2018-02-28 17-16-38.wav');

N1=0.1*Fs_buzz;
N2=3*Fs_buzz; 
figure(5)
subplot(2,1,1)
plot(1e3*(1/44.1e3*(1:length(y_buzz(N1:N2)))+N1/Fs_buzz),1e3*y_buzz(N1:N2),'k')
xlabel ('Time[ms]');
ylabel ('Output [mV*V]');
xlim([1186,1246]);
set(gca,'xtick',[1186 1196 1206 1216 1226 1236 1246],'xticklabel',{'0','10', '20', '30','40','50','60'}) 
% x_label1={'0','10', '20', '30','40','50','60'};
% set(gca,'xticklabel',x_label1);
N1=1.185*Fs_buzz;
N2=1.245*Fs_buzz;
L=length(y_buzz(N1:N2));
X=1*(y_buzz(N1:N2));
Fs=Fs_buzz;
Y = fft(1e3*X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
FF=db(P1,'power');

figure(5)
subplot(2,1,2)
plot(f/1e3,FF,'k')
xlim([0,20]);
ylim([-30,0]);
ylabel ('Amplitude [dBm]');
xlabel ('Frequency [KHz]');
