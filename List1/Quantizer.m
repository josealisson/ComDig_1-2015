function [Qx] = Quantizer(x, L, mp)
%==========================================================================
% This function quantizes a signal x in L levels with mp 
%
% x -> input signal
% L -> number of levels of the quantizer
% mp -> maximum level of the quantizer

% floor(x) rounds each element of X to the nearest integer less
% than or equal to that element.
Qx = mp*(1/(L/2))*floor((L/2)*(x/mp)); % t/mp will take values
% between [-1, 1] and (L/2)*(t/mp) will take [-(L/2), (L/2)]
% and cover all the L values
end
