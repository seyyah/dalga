% main program
dbg = true;

db = '../db/';
fnm = strcat(db, 'aluminyum.txt');

data = csvread(fnm);
X = data(:,1);
Y = data(:,2);

if ~dbg
    figure(1);  plot(X, Y);
end

fd = fftshift(fft(Y));
fd = log(abs(fd));

if dbg
    figure(2);  plot(fd);
end