function Hd = highpass
%HIGHPASS Returns a discrete-time filter object.

%
% MATLAB Code
% Generated by MATLAB(R) 8.0 and the Signal Processing Toolbox 6.18.
%
% Generated on: 16-Mar-2017 09:03:16
%

% Butterworth Highpass filter designed using FDESIGN.HIGHPASS.

% All frequency values are in Hz.
Fs = 250;  % Sampling Frequency

Fstop = 1;           % Stopband Frequency
Fpass = 4;           % Passband Frequency
Astop = 80;          % Stopband Attenuation (dB)
Apass = 1;           % Passband Ripple (dB)
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.highpass(Fstop, Fpass, Astop, Apass, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);

% [EOF]