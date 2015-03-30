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
NCycles = 4; % Number of cycles
bits = [1, 2, 4, 8, 16]; % Number of bits
p = (10:10:200)/100; % Percentage of input

%--------------------------------------------------------------------------
% Create a signal

t = 0:1/fs:NCycles*(1/fc);
%t = linspace(0, NCycles*(1/fc), length(p))
x1 = sin(2*pi*fc*t);

%--------------------------------------------------------------------------
% Quantize the signal

SNR = zeros(length(p), length(bits)); % Each collum has the SNR for a given
% number of bits with different values of p
mp = max(abs(x1)); % Máximum level of the quantizer
Qx = zeros(1, length(x1));
i=1;

for p_aux=p
    j=1;
    for b=bits
        x_aux = p_aux*x1;
        [Qx] = Quantizer(x_aux, 2^b, mp); % quantizes the signal
        S1 = (norm(x_aux)^2)/length(x_aux); % Power of input signal
        SNR_quant = (3*power(4, b)*S1)/(mp^2);
        SNR(i,j) = 10*log10(SNR_quant);
        j = j+1;
    end
    i = i+1;
end

figure(1), plot(t, x1, t, Qx, '-')

%--------------------------------------------------------------------------
% Plot the relation between SNR and p and the number of bits

style = ['-or'; '-og'; '-ok'; '-ob'; '-oy'];
for b=1:length(bits)
  figure(2);
  plot(100*p, reshape(SNR(1:end,b), size(p)), style(b,1:end)); hold on;
  legend(sprintf('%i bits', bits(b))); hold on;
end

%--------------------------------------------------------------------------
% Do the calculation and plot the PSD of the signal

pxx = pwelch(x1);
PSD = dspdata.psd(pxx, 'fs', fs);
figure(3), plot(PSD) % Plots the power spectral density






