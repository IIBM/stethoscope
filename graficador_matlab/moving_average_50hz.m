function e = moving_average_50hz(ecg, fs)
m=fs/50;

a=1;
b=1/m*ones(1,m);

e=filter(b,a,ecg);

end
