% function z = sinus_uydur(Y)
% function z = sinus_uydur(Y)
% 
% Y'de sabit kalan yerlere sinus uydur
% Fikir veren yonu min veya max degerinde >2 ardi ardina elemanin gelmesi
% oncesi ve sonrasindaki bolgeye ikinci dereceden egri uydur.

% Y = Y';

mnv = min(Y);
mxv = max(Y);

% a) min olanlar
idx = find(Y == mnv);

figure(11)
plot(Y)
hold on,    
    plot(Y, 'k+')
    plot(idx, Y(idx), 'r*');    
hold off

% a.1) ikil gosterim
% http://www.mathworks.com/support/solutions/en/data/1-3W7N3H/index.html?product=ML&solution=1-3W7N3H
N = length(Y);
pat = zeros(N, 1);
pat(idx) = 1;
pat = pat';

% a.2) 0-1-0 filtrele
id = strfind(pat, [0 1 0]) + 1;
pat(id) = 0;

% a.3) 0-1 ve 1-0 gecisleri
g01 = strfind(pat, [0 1]) + 1;
g10 = strfind(pat, [1 0]);

% a.4) pik noktalari
pp = (g01 + g10) / 2;

% a.5) pik degeri
% y = a (x - x0)^2 + b
% 
% x0 = pp
% x = g01 -> y = f(x) = Y(x) = Y(g01)
% 
% iki nokta: g01 ve g01-1
% 
% a = (Y(x - 1) - mnv|mxv) / ((x - 1 - x0)^2 - (x - x0)^2)
% b = mnv - a (x - x0)^2
% 
% x=x0 -> pv = y = b
x0 = pp;    x = g01;

a = (Y(x - 1) - mnv) ./ ((x - 1 - x0).^2 - (x - x0).^2);
b = mnv - a .* (x - x0).^2;

pv = b;

mn.pp = [pp id];
mn.pv = [pv Y(id)];

% b) max olanlar
idx = find(Y == mxv);

figure(11)
plot(Y)
% hold on,    
%     plot(Y, 'k+')
%     plot(idx, Y(idx), 'r*');    
% hold off

% b.1) ikil gosterim
% http://www.mathworks.com/support/solutions/en/data/1-3W7N3H/index.html?product=ML&solution=1-3W7N3H
N = length(Y);
pat = zeros(N, 1);
pat(idx) = 1;
pat = pat';

% b.2) 0-1-0 filtrele
id = strfind(pat, [0 1 0]) + 1;
pat(id) = 0;

% b.3) 0-1 ve 1-0 gecisleri
g01 = strfind(pat, [0 1]) + 1;
g10 = strfind(pat, [1 0]);

% b.4) pik noktalari
pp = (g01 + g10) / 2;

% b.5) pik degeri
% y = a (x - x0)^2 + b
% 
% x0 = pp
% x = g01 -> y = f(x) = Y(x) = Y(g01)
% 
% iki nokta: g01 ve g01-1
% 
% a = (Y(x - 1) - mnv|mxv) / ((x - 1 - x0)^2 - (x - x0)^2)
% b = mxv - a (x - x0)^2
% 
% x=x0 -> pv = y = b
x0 = pp;    x = g01;

a = (Y(x - 1) - mxv) ./ ((x - 1 - x0).^2 - (x - x0).^2);
b = mxv - a .* (x - x0).^2;

pv = b;

mx.pp = [pp id];
mx.pv = [pv Y(id)];

hold on
    plot(mn.pp, mn.pv, 'ko', mx.pp, mx.pv, 'ro');
hold off

