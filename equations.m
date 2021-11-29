% 선형 연립 방정식의 해를 찾기
A = [-1 4 1; 2 -2 3; 3 1 -2];
c = [4; 7; -1];
x = A\c

% 함수의 근 찾기
% roots 함수
fx1=roots([1, 0, 0, 7, 10])

% fzero
% 첫째, 대략적인 근의 위치를 위해 그래프를 그린다.

x = [-3:0.1:3];
y=2*x+exp(-x)-2;
plot(x,y)
hold

y1=zeros(1,61);
plot(x,y1)
xlabel('x')
ylabel('y')

%둘째, 사용자 정의함수를 만든다.
%function y=F2(x)
%y=2*x+exp(-x)-2;

%셋째, fzero 함수를 이용하여 대략적인 위치의 값을 넣어 해를 구한다

x1 = fzero('F2',0.5)

x2 = fzero('F2',-1.5)

% polyval 함수
% f(x)=x^3-2x^2+x2+1
a=[1,-2,2,1];
x=[-2:0.01:4];
fx=polyval(a,x);
plot(x, fx)
xlabel('x')
ylabel('fx')