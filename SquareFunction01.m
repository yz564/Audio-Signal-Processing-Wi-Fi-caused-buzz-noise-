clear
clc


[y_buzz,Fs_buzz]=audioread('Audio recording 2017-11-23 11-25-10.wav');

N1=2*Fs_buzz;
N2=5*Fs_buzz;
L=length(y_buzz(N1:N2));
X=1*(y_buzz(N1:N2));
Fs=Fs_buzz;
Y = fft(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f1 = Fs*(0:(L/2))/L;
FF=db(P1);

FFF1=envelope(FF,100,'peak');
ff=0:0.5:2205000;
FFF=interp1(f1,FFF1,ff);

figure(3)
subplot(2,1,2)
plot(ff/1e3,FFF,'b')
xlim([0,20]);
hold on
% 
% clc



format long

x1=-370;
x2=-1370;
x3=+630;
x4=-2370;
x5=+1630;
x6=-3370;
x7=+2630;

y1=-1.85;
y2=8.51;
y3=8.51;
y4=-26.70;
y5=-26.70;
y6=-30;
y7=-30;

p1=0;
p2=0;
p3=0;

f1=5e9+x1;
f2=5e9+x2;
f3=5e9+x3;
f4=5e9+x4;
f5=5e9+x5;
f6=5e9+x6;
f7=5e9+x7;

A1=sqrt((10^(y1/10))*0.05);
A2=sqrt((10^(y2/10))*0.05);
A3=sqrt((10^(y3/10))*0.05);
A4=sqrt((10^(y4/10))*0.05);
A5=sqrt((10^(y5/10))*0.05);
A6=sqrt((10^(y6/10))*0.05);
A7=sqrt((10^(y7/10))*0.05);


Fs=4410000;
T=1/Fs;
L=Fs*2;
t=(0:L-1)*T;


y1=A1*cos(2*pi*f1*t+p1);
y2=A2*cos(2*pi*f2*t+p2);
y3=A3*cos(2*pi*f3*t+p3);
y4=A4*cos(2*pi*f4*t);
y5=A5*cos(2*pi*f5*t);
y6=A6*cos(2*pi*f6*t);
y7=A7*cos(2*pi*f7*t);

y=-(y1+y2+y3+y4+y5+y6+y7).^2;   %square function
%y=-abs(hilbert(y1+y2+y3+y4+y5+y6+y7));


 Fs0=44100;
 T0=1/Fs0;
 L0=Fs0*2;
 t0=(0:L0-1)*T0;
 [P,Q]=rat(Fs0/Fs);
 y0=resample(y,P,Q);
 f_y0=fft(y0);
 f_y10=f_y0;
 f0=Fs0*(0:(L0/2))/L0;
 for i=1:size(f0)
    if f0(i)<20
        f_y10(i)=0;
    elseif f0(i)>20e3
        f_y10(i)=0;
    else
        f_y10(i)=f_y0(i);
    end
end
 P20=abs(f_y0/L0);
 P10=P20(1:L0/2+1);
 y0=ifft(f_y10);
% 
% f_y=fft(y);
% P2=abs(f_y/L);
% P1=P2(1:L/2+1);
% f=Fs*(0:(L/2))/L;
% 
% figure (1)
% subplot(2,1,2)
% plot(f,20*log10(P1),'b');
% ylabel('Mag [dBV]');
% xlabel('Freq [Hz]');
% 
% 
% figure (1)
% subplot(2,1,1)
% plot(t,y,'-*r')
% ylabel('Voltage [V]');
% xlim([0 2e-3]);
% xlabel('Time [s]');

%y0=abs(hilbert(y));

f_y=fft(y);
f_y1=f_y;
f=Fs*(0:(L/2))/L;

for i=1:size(f)
    if f(i)<20
        f_y1(i)=0;
    elseif f(i)>20e3
        f_y1(i)=0;
    else
        f_y1(i)=f_y(i);
    end
end

P2=abs(f_y1/L);
P1=P2(1:L/2+1);
y=ifft(f_y1);            

figure (3)
subplot(2,1,2)
plot(f/1e3,20*log10(P1),'b');
xlim([0 20]);
%xlim([5e9-5e3 5e9+5e3]);
%ylim([-400 20]);
ylabel('Voltage [dBV]');
xlabel('Frequency [KHz]');

figure (3)
subplot(2,1,1)
plot(t0*1e3,y0*1e3,'b')
ylabel('Voltage [mV]');
%ylim([-70 70]);
xlim([1 9]);

xlabel('Time [ms]');
%x_label={'0','0.5', '1', '1.5','2','2.5', '3', '3.5','4'};