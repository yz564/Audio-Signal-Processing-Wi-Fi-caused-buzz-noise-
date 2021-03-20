clear
clc
A=load('DownconvertedWiFi.csv');
t=A(:,1);
v0=A(:,2);
Fs=100e6;
L=length(t);
Y00=fft(v0);
P20=abs(Y00/L);
P10 = P20(1:L/2+1);
P10(2:end-1) = 2*P10(2:end-1);
f0 = Fs*(0:(L/2))/L;
set(0,'defaultfigurecolor','w');
%The down-converted Wi-Fi signal recorded by the oscilloscope
figure (1)
subplot(2,1,1)
plot(1e3*t,1e3*v0,'b')
ylabel('Voltage [mV]');
xlabel('Time [ms]');
xlim([1e3*0.1 1e3*0.29]);
ylim([-300 300]);
x_label1={'0','20', '40', '60','80','100', '120', '140','160','180'};
set(gca,'xticklabel',x_label1);
figure(1)
subplot(2,1,2)
plot(f0/1e6,db(P10),'b')
xlabel ('Frequency [MHz]');
ylabel ('Magnitude Spectrum [dBV]');
ylim([-120 -50]);

v=v0.*v0; %Square function
Y = fft(1e3*v); %unit: mV*V
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%The signal after square function
figure (2)
subplot(2,1,1)
plot(1e3*t,1e3*v,'b')
ylabel('Squared Voltage [mV*V]');
xlabel('Time [ms]');
xlim([1e3*0.1 1e3*0.29]);
x_label1={'0','20', '40', '60','80','100', '120', '140','160','180'};
set(gca,'xticklabel',x_label1);
figure(2)
subplot(2,1,2)
plot(f0/1e6,db(P1,'power'),'b')
xlabel ('Frequency [MHz]');
ylabel ('Magnitude Spectrum [dBm]')
ylim([-50 0]);

% Create the microphone response in frequency domain
f01=1e-3.*f0(1:10000000);
B=load('MicrophoneResponse.csv');
f_nf=B(:,1);
y_nf=B(:,2);
yy_nf=interp1(f_nf,y_nf,f01)+68;%+68 dB aims at compensate the amplitude level (estimated)
figure (3)
plot(f01,yy_nf);
xlim([0 25]);
ylim([-30 20]);
xlabel ('Frequency [KHz]');
ylabel ('Microphone Response [dB]');

% Apply the microphone response on the squared signal
Y0=Y(1:10000000);
YY0=Y0.*(10.^(yy_nf'/20)); 
YY=zeros(20000000,1);
YY(1)=YY0(1); % The DC component
YY(10000001)=YY0(1);
for j=2:10000000
    YY(j)=YY0(j);
    YY(20000000-j+2)=conj(YY0(j)); % Take the conjugation for the negative frequency component
end
yy=ifft(YY);

P222 = abs(YY/L);
P111 = P222(1:L/2+1);
P111(2:end-1) = 2*P111(2:end-1);

figure (7)
subplot(2,1,1)
plot(1e3*t,1e3*yy,'b')
ylabel('Squared Voltage [mV*V]');
xlabel('Time [ms]');
xlim([1e3*0.1 1e3*0.29]);
x_label1={'0','20', '40', '60','80','100', '120', '140','160','180'};
set(gca,'xticklabel',x_label1);
figure(7)
subplot(2,1,2)
plot(f0/1e6,db(P111,'power'),'b')
xlabel ('Frequency [MHz]');
ylabel ('Magnitude Spectrum [dBm]')
ylim([-50 0]);



%Resampling (converse 50MSa/Sec to 44.1KSa/Sec)
y1=zeros(8822,1);
t1=zeros(8822,1);
for i=1:8822
    y1(i)=yy(2267*i-1000);
    t1(i)=t(2267*i-1000);
end

Fs1=44100;%The sampling rate of Microphone
L1=length(t1);
Y1 = fft(y1);
PP2 = abs(Y1/L1);
PP1 = PP2(1:L1/2+1);
PP1(2:end-1) = 2*PP1(2:end-1);
f1 = Fs1*(0:(L1/2))/L1;

% The reproduced buzz noise
figure (4)
subplot(2,1,1)
plot(1e3*t1,-y1,'b');% Note: the minus sign
ylabel('Output [mV*V]');
xlabel('Time [ms]');
xlim([190 250]);
ylim([-20 20]);
x_label1={'0','10', '20', '30','40','50','60'};
set(gca,'xticklabel',x_label1);
figure (4)
subplot(2,1,2)
plot(f1/1e3,10*log10(PP1),'b');
ylabel('Amplitude [dBm]');
xlabel('Frequency [KHz]');
xlim([0 20]);
ylim([-30 0]);
