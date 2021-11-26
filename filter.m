% 실습1
% 평균필터

clear, clc

% mtlb 소리 파일을 불러오고 x에 저장한다.
load mtlb;
x = mtlb';

% 소리 출력
soundsc(x, Fs);

% 필터의 계수를 지정한다.
% 10개의 샘플을 평균하는 필터
N = 10;
h = ones(1, N) / N;

% 입력 데이터ㅇ X와 필터 계수 h를 컨볼루션한다.
y = conv(x, h);


% 원 소리와 필터 통과한 신호의 그래프

figure,
subplot(211), plot(x), grid, ylabel('Input')
subplot(212), plot(y), grid, ylabel('Output')

% 필터 통과한 신호 확인
soundsc(y, Fs);


% 실습1 - 주파수
% Fast Fourier Transform(fft)
% DFT의 고속 연산 버전
% Fourier Transform으로 주파수 대역 계산
% 모두 양수로 계산하여 음의 주파수 값이 양의 주파수 옆으로 붙어있는다.

N = 1024;
X = fft(x, 1024)

f = (0:1/N:1-1/N)*Fs;

figure,
plot(f, abs(X))

% 필터 통과한 신호 y의 fft 그래프
% Low frequency 부분은 통과
% High frequency 부분은 제거

y = fft(y, 1024)

figure,
plot(f, abs(Y))

% 필터 계수 h의 fft 그래프
% Low frequency 부분은 1에 가깝다.
% High frequency 부분은 0에 가깝다.

% 실습2
% HPF
h2 = ((-1).^(1:10)) / 10;

% convolution 및 소리 확인
y2 = conv(x, h2)

figure,
subplot(211), plot(x), grid, ylabel('Input')
subplot(212), plot(y2), grid, ylabel('Output')

% 필터 통과한 신호 y2의 fft 그래프
% High frequency 부분은 통과
% Low frequency 부분은 제거

Y2 = fft(y2, 1024)

figure,
plot(f, abs(Y2))

% 필터 통과한 신호 h2의 fft 그래프
% High frequency 부분은 1에 가깝다.
% Low frequency 부분은 0에 가깝다.

H2 = fft(h2, 1024)

figure,
plot(f, abs(H2))

% 실습3 - 아이유 3단 고음
clear, clc, close all;

load 3단고음.mat
x = data(:,1); % 2채널 스테레오에서 하나의 채널소리만 저장한다.

soundsc(x, fs); % Hear the sound

% 다른 목소리와 멜로디가 있는 소리 신호에서 fft만으로 분석하기 어렵다
% 시간에 따른 주파수 분석도 어렵다
% batch processing(일괄처리)의 한계

N = 1024;
X = fft(x,N);
f = (0:1/N:1-1/N)*fs;

figure,
plot(f, abs(X))

% 시간에 따른 주파수 그래프
% Spectrogram
% 여기에서는 간단히 분석 용도로

figure,
spectrogram(x, hamming(2^12),2^11,2^12,fs,'yaxis'),ylim([0 1]);

% 2 ~ 8 : 658.26Hz
% 8 ~ 10 : 698.46Hz
% 10 ~ 12 : 739.99Hz

% 필터의 계수
% 원하는 주파수의 cos함수를 필터로 만들기
% 샘플 개수 : 1024개

n = 1/fs:1/fs:1024/fs;
f = 659.26;
h = cos(2*pi*f*n);
plot(h)


y = conv(x, h, 'same');
figure,
spectrogram(y, hamming(2^12),2^11,2^12,fs,'yaxis'), ylim([0 1]);
