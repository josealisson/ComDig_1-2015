%==========================================================================
% José Alisson de Albuquerque Pinto
% 10/0107974
%
% This code quantizes a signal and plots its SNR with different values of
% bits and p.
%==========================================================================

clc
close all;
clear all;

fc = 5e3; % Signal frequency
fs = 500e3; % Sampling frequency
NCycles = 2; % Number of cycles
Am = 7; % Amplitude of the signal
p = 20/100; % Percentage of input
bits = 5; % Number of bits
L = 2^bits; % Number of quantized levels

%--------------------------------------------------------------------------
% Create a signal

t = 0:1/fs:NCycles*(1/fc);
x1 = Am*p*sin(2*pi*fc*t);

%--------------------------------------------------------------------------
% Quantize the signal

mp = max(abs(x1)); % Máximum level of the quantizer
% floor(x) rounds each element of X to the nearest integer less than or equal to that element.
Qx = mp*(1/(L/2))*floor((L/2)*(x1/mp)); % t/mp will take values between [-1, 1]
% and (L/2)*(t/mp) will take [-(L/2), (L/2)] and cover all the L values
figure(1), plot(t, x1, t, Qx, '-') % Plot the MSG and the quantized MSG

%--------------------------------------------------------------------------
% Do the calculation and plot the PSD of the signal

pxx = pwelch(x1);
PSD = dspdata.psd(pxx, 'fs', fs);
S1 = (norm(x1)^2)/length(x1);
sprintf('Power of input signal is %f W', S1)
figure(2), plot(PSD) % Plots the power spectral density
QxError = (mp^2)/L;
for b = [1, 2, 4, 8, 16]
    SNR_quant = (3*power(4, b)*S1)/(mp^2);
    SNR = 10*log10(SNR_quant);
end
figure(3), plot(b, SNR)
