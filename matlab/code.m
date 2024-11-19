clear all;
clc;
close all;

% input
a1 = 10;
a2 = 0.01;
f1 = 200;
f2 = 205;
f3 = 300;
t_gen = 1;
fd = 2000;
N = 200;
t = 0:1/fd:t_gen-1/fd;

y1 = a1*sin(2*pi*f1*t) + a2*sin(2*pi*f3*t);
y2 = a1*sin(2*pi*f2*t) + a2*sin(2*pi*f3*t);

figure;
plot(t, y1);
title('y1');
xlabel('Time');
ylabel('Amplitude');

figure;
plot(t, y2);
title('y2');
xlabel('Time');
ylabel('Amplitude');


rect_signal = zeros(size(t));
window = (length(t)/2 - ceil(N/2)+1):(length(t)/2 + ceil(N/2));
rect_signal(window) = 1;

figure;
plot(t, rect_signal, 'LineWidth', 3);
xlabel('Time');
ylabel('Amplitude');
title('Rectangular Signal');
grid on;

y1_rect = y1.*rect_signal; % window overlay

figure;
plot(t, y1_rect);
title('y1 Rectangular');
xlabel('Time');
ylabel('Amplitude');
xlim([0.3, 0.7]);

y2_rect = y2.*rect_signal; % window overlay

figure;
plot(t, y2_rect);
title('y2 Rectangular');
xlabel('Time');
ylabel('Amplitude');
xlim([0.3, 0.7]);


%4

Y1 = fft(y1);
Y2 = fft(y2);

f = (0:length(Y1)-1)*fd/length(Y1);

% spectre of y1
figure;
plot(f, abs(Y1));
title('Spectrum of Signal y1');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% spectre of y2
figure;
plot(f, abs(Y2));
title('Spectrum of Signal y2');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

%y1
new_sign = y1_rect(window);
f_new = (0:length(new_sign)-1)/length(new_sign)*fd;
figure;
stem(f_new, abs(fft(new_sign)), 'r');
hold on;
plot(t*fd, abs(fft(y1_rect)));

title('Spectrum of Limited Signal (Stem Plot) y1');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
xlim([0 400]);

%y2
new_sign = y2_rect(window);

figure;
stem(f_new, abs(fft(new_sign)), 'r');
hold on;
plot(t*fd, abs(fft(y2_rect)));
title('Spectrum of Limited Signal (Stem Plot) y2');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
xlim([0 400]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Blackman-Harris Window
rect_signal_bh = zeros(size(t));
rect_signal(window) = blackmanharris(length(window));

y2_rect_bh = y2.*rect_signal;

figure;
plot(t, y2_rect_bh);
title('y2 Rectangular');
xlabel('Time');
ylabel('Amplitude');
xlim([0.3, 0.7]);

%spectre

Y2_bh = fft(y2_rect_bh);
figure;
plot(f, abs(Y2_bh));
title('Spectrum of Signal y2 Blackman-Harris Window');
xlabel('Frequency (Hz)');
ylabel('Amplitude(dB)');

semilogy(f,abs(Y2_bh))

figure;
plot(f, abs(Y2_bh));
title('Spectrum of Signal y2 Blackman-Harris Window xlim=400');
xlabel('Frequency (Hz)');
ylabel('Amplitude(dB)');

semilogy(f,abs(Y2_bh))
xlim([0 400]);

%%%%%%%%%%%%%%%%%

Y2_rect = fft(y2_rect);
semilogy(f,abs(Y2_rect))

figure;
plot(f, abs(Y2_rect));
title('Spectrum of Signal y2 Blackman-Harris Window xlim=400');
xlabel('Frequency (Hz)');
ylabel('Amplitude(dB)');

semilogy(f,abs(Y2_rect))
xlim([0 400]);
