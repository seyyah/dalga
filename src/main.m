% main program
close all; clear all;   clc;

dbg = true;

db = '../db/';
% fnm = strcat(db, 'ahsap.txt');
fnm = strcat(db, 'aluminyum.txt');

data = csvread(fnm);
ind = 1:length(data);
X = data(ind,1);
Y = data(ind,2);


M = 70; % 0-M arasini kes
X = X(1:M);
Y = Y(1:M);

% 0-sinusler
z = sinus_uydur(Y);

% 1-preprocess
mn = mean(Y);
Y( abs(Y - mn) < 0.05*mn ) = mn;

if dbg
    figure(1);  
    plot(X, Y);     xlabel('t-microsn');    ylabel('V-mV');
    yl = ylim;      ylim([-500 yl(2)]);
end

% 2-local extreme points
[lmnv, idmn] = lmin(Y, 2);
[lmxv, idmx] = lmax(Y, 2);

hold on
plot(X(idmn), lmnv, 'r*');
plot(X(idmx), lmxv, 'k*');
hold off





% %%
% fs = 1e6;
% as = 1000/59.25;
% N = round(length(data)/as);
% i=0:N;
% tt = i*as + 12;
% 
% fd = log(abs(fft(Y)));
% f = linspace(0, fs, length(fd))/1000;
% 
% if dbg
%     figure(2);  plot(f, fd);
%     xlabel('f-kHz');
%     ylabel('A');
% end