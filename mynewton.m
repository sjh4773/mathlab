% mynewton.m
%
% This program finds a root of function func1().

x = input('Type initial guess --> ');

fx = func1(x);
dx = 1e-8;

i = 0;

while (abs(fx) > 1e-10)

    i = i + 1;
    fx = func1(x);
    dfx = (func1(x+dx) - fx) / dx;

    x = x -fx/dfx;
end