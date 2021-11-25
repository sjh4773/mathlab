syms t

f = 5;
x = cos(2*pi*f*t)

fplot(x), axis([0 1 -1.5 1.5]), grid on
fs = 100;
ts = 0 : 1 /fs : 1 - 1/fs;


xs = cos(2*pi*f*ts);

hold on
plot(ts, xs, 'r*'), axis([0 1 -1.5 1.5]), grid on
hold off