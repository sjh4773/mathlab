x = linspace(0,2*pi);
y = sin(x);
plot(x,y)

xlabel("x")
ylabel("sin(x)")
title("Plot of the Sine Function")

plot(x,y,"r--")

x = linespace(0, 2*pi);
y = sin(x);
plot(x,y)

hold on

y2 = cos(x);
plot(x,y2,":")
legend("sin","cos")

hold off

% 3-D Plots
x = linspace(-2,2,20);
y = x';
z = x .* exp(-x^2, -y.^2);
surf(x,y,z)

% Multiple plots

t = tiledlayout(2,2);
title(t,"Trigonometric Functions")
x = linspace(0,30);

nexttile
plot(x,sin(x))
title("Sine")

nexttile
plot(x,cos(x))
title("Cosine")

nexttile
plot(x,tan(x))
title("Tangent")

nexttile
plot(x,sec(x))
title("Secant")