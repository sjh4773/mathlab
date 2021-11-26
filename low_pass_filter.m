% 실습 - fir1 함수

b1 = fir1(20, 0.2);
b2 = fir1(44, 0.2);
b3 = fir1(100, 0.2);

figure,
subplot(311), stem(b1)
subplot(312), stem(b2)
subplot(313), stem(b3)

% 주파수 대역
fvtool(b1);
fvtool(b2);
fvtool(b3);

out1 = filter(b1,1,x); % 20차 Filtering, 1 넣어도 되고 안넣어도 됨
out2 = filter(b2,1,x); % 44차 Filtering
out3 = filter(b3,1,x); % 100차 Filtering

figure,
subplot(411), plot(x), grid, xlim([1 Q])
ylabel('Input')
subplot(412), plot(out1), grid, xlim([1 Q])
ylabel('20차 Input')
subplot(413), plot(out2), grid, xlim([1 Q])
ylabel('44차 Input')
subplot(414), plot(out3), grid, xlim([1 Q])
ylabel('100차 Input')

% 실습2 - fdesign 함수
% matlab에서 원하는 필터의 성능을 입력하면 가장 좋은 필터를 만들 수 있다.
% 알맞은 차수를 찾아준다.
% fdesign 파라미터
% Fpass : 통과시키고 싶은 주파수
% Fstop : 통과 하지 못하는 주파수
% Apass : Pass band에서 리플의 양
% Astop : Stop Band에서 감소량

load mtlb;

x = mtlb;

%fdesign.lowpass 함수
%Fp,Fst,Ap,Ast 인수를 입력하면 최적의 필터 object 변수로 출력
% 최적의 필터 길이(차수)까지 추천

% design 함수
% fdesign에서 만든 object의 임펄스 응답을 출력, 44차

f1 = fdesign.lowpass('Fp, Fst, Ap, Ast', 0.15, 0.25, 1, 60);

d1 = design(f1); % Execute design

% fvtool함수
% 필터 시각화 툴
% design된 인자를 입력하면 설계된 필터를 그려준다.

fvtool(d1,'Fs', Fs)

% Filter 함수
% 생성된 design object와 원복 데이터를 입력하면 필터가 적용된 데이터가 출력
% FIR / IIR 필터 모두 계산 가능
% FIR필터는 conv 함수로도 계산 가능

y = filter(d1, x); % d1 : 매트랩이 추천한 필터, x : 소리

figure,
subplot(211), plot(x), grid, xlim([1 Q])
ylabel('Input')
subplot(212), plot(y), grid, xlim([1 Q])
ylabel('Output')

% design된 필터의 계수값 그래프
% Sinc 함수 형태

figure,
h = d1.Numerator;
stem(h)

y2 = conv(x, h, 'same');

figure,
subplot(311), plot(x), grid, xlim([1 Q])
ylabel('Input')
subplot(312), plot(y), grid, xlim([1 Q])
ylabel('Output')
subplot(313), plot(y2), grid, xlim([1 Q])
ylabel('Output2')