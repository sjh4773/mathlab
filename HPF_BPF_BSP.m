clear all, clc, close all;

load mtlb;

x = mtlb;

% HPF 실습

% 차수 : 20
% cut off 주파수 대역 : 0.2
b = fir1(20, 0.2, 'high');
figure,
stem(b)

% 차수가 높아질수록 필터가 촘촘히 설계된다.
b1 = fir1(20, 0.2, 'high');
b2 = fir1(44, 0.2, 'high');
b3 = fir1(100, 0.2, 'high');

figure,
subplot(311), stem(b1)
subplot(312), stem(b2)
subplot(313), stem(b3)

% fvtool 확인
% 주파수 대역에서 확인해도 높은 차수에서 더 촘촘하게 필터 설계가 되었다.
fvtool(b1);
fvtool(b2);
fvtool(b3);

% 각 차수마다 필터 적용한 출력 그래프
% 큰 차이가 없는 것처럼 보인다.
% 샘플주파수가 낮고 차수의 차이도 적어 큰 차이가 없다.
% 이렇게 꼭 높은 차수를 사용하지 않아도 된다

out1 = filter(b1, 1, x); % 20차 Filtering
out2 = filter(b2, 1, x); % 44차 Filtering
out3 = filter(b3, 1, x); % 100차 Filtering

figure,
subplot(411), plot(x), grid
ylabel('Input')
subplot(412), plot(out1), grid
ylabel('20차 Output')
subplot(413), plot(out2), grid
ylabel('44차 Output')
subplot(414), plot(out3), grid
ylabel('100차 Output')

% 소리 출력
soundsc(x, Fs);
soundsc(out1, Fs);
soundsc(out2, Fs);
soundsc(out3, Fs);

% fdesign
% matlab에서 원하는 필터의 성능을 입력, 가장 좋은 필터를 추천
% 알맞은 차수를 찾아준다.

% fdesign 파라미터
% Fpass : 통과 시키고 싶은 주파수
% Fstop : 통과 하지 못하는 주파수
% Apass : Pass band에서의 리플의 양
% Astop : Stop Band에서 감소량

% fdesign.highpass 함수
% Fp, Fst, Ap, Ast 인수를 입력하면 최적의 필터 object 변수로 출력
% 최적의 필터 길이(차수)까지 추천

% design 함수
% fdesign에서 만든 object의 임펄스 응답을 출력

f1 = fdesign.highpass('Fst, Fp, Ast, Ap', 0.15, 0.25, 60, 1);

d1 = design(f1); % Execute design

% Filter 함수
% 생성된 design object와 원복 데이터를 입력하면 적용된 데이터가 출력

% 필터가 된 그래프 (Output)
% 주파수 변화가 작은 부분은 0으로 사라지고, 주파수 변화가 있는 부분은 더 커졌다.

y = filter(d1, x); % Filtering

figure,
subplot(211), plot(x), grid,
ylabel('Input')
subplot(212), plot(y), grid,
ylabel('Output')

soundsc(x, Fs)

soundsc(y, Fs)

% design된 필터의 계수값 그래프
% 0을 제외하고 Sinc 함수가 반전된 형태

figure,
h = d1.Numerator;
stem(h)

% 필터 계수의 fft 그래프
% 계수가 45개 이므로 임펄스 응답도 원래 45개만 표현

H = fft(h);
figure,
stem(abs(H)) %plot(20*log10(abs(N)))

% LPF-HPF 변환
% HPF는 LPF가 주파수(w) 파이만큼 이동했다고 볼 수 있다.
% LPF 필터 계수에 (-1)^n를 곱한다.
lpf = fir1(50, 1/4) % 50차, cutoff : 0.5
figure,
stem(lpf)

nn = 1:51;
hpf = lpf.*(-1).^(nn);
figure,
stem(hpf)

out_lpf = filter(lpf, 1, x);
out_hpf = filter(hpf, 1, x);

figure,
subplot(311), plot(x), grid,
ylabel('Input')
subplot(312), plot(out_lpf), grid,
ylabel('LPF Output')
subplot(313), plot(out_hpf), grid,
ylabel('HPF Output')

% LPF 통과한 데이터 소리
soundsc(out_lpf, Fs) % lpf 소리

% HPF 통과한 데이터 소리
soundsc(out_hpf, Fs); % hpf 소리

% 주파수 도메인 확인
% fft 사용

OUT_LPF = fft(out_lpf);
OUT_HPF = fft(out_hpf);

figure, plot(abs(OUT_LPF)), xlim([1 2000])
figure, plot(abs(OUT_LPF)), xlim([1 2000])

% Band Pass Filter 실습
% 특정 주파수 대역의 주파수 신호만 통과하는 필터
% 특정 주파수의 크기는 1을 곱하고 나머지는 0을 곱한다.

% fir1 함수
% 차수와 통과 대역 주파수만 입력하여 맞는 필터를 설계해준다.
% 차수 : 20, cut off 주파수 대역 : 0.2

b = fir1(20, [3/8 5/8], 'bandpass');
figure,
stem(b)

% 필터 크기 응답 확인
fvtool(b)

l = length(x);

f1 = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',1/4,3/8,5/8,3/4,60,1,60);

d1 = design(f1);  % Execute design

y = filter(d1, x);

figure,
subplot(211), plot(x), grid,
ylabel('Input')
subplot(212), plot(y), grid,
ylabel('Output')

soundsc(x, Fs);
soundsc(y, Fs);

% design 된 필터 계수값
figure,
h = d1.Numerator;
stem(h)

% 필터 계수의 fft 그래프
% 계수가 37개이므로 임펄스 응답도 37개만 표현

N = fft(h);
figure,
stem(abs(H)) %plot(20*log10(abs(H)))

% LPF - BPF 변환
% BPF는 LPF가 주파수(w) 대역에서 +π/2만큼 이동한 것과 -π/2만큼
% 이동한 것을 더한 것과 같다.

lpf =fir1(50, 1/4);
figure,
stem(lpf)

nn = 1:51;
bpf = lpf*2.*cos(pi*nn/2);
figure,
stem(bpf)

% Band Stop Filter
% 특정 주파수 대역의 주파수 신호만 제거하는 필터
% 특정 주파수의 크기는 0을 곱하고 나머지는 1을 곱한다.

b = fir1(20, [3/8 5/8], 'stop');
figure,
stem(b)

% 필터 크기 응답 확인
fvtool(b)

l = length(x);

f1 = fdesign.bandstop('Fp1,Fst1,Fst2,Fp2,Ap1,Ast,Ap2',2/8,3/8,5/8,6/8,1,60,1);

d1 = design(f1);

% design된 필터의 계수값 그래프

figure,
h = d1.Numerator;
stem(h)

% 필터 계수의 fft 그래프
% 계수가 37개이므로 임펄스 응답도 37개만 표현

N = fft(h);
figure,
stem(abs(N))

% BPF - BSF 변환
% BSF는 1에서 BPF를 뺀 것과 같다.

lpf = fir1(50,1/4);
figure,
stem(lpf)

nn = -25:25;
delta = [zeros(1,25) 1 zeros(1,25)];
bsf = delta - lpf*2.*cos(pi*nn/2);
figure,
stem(bsf)