%% I. ��������

clear all   % ���Workspace�е����б���
clc         % ���Command Window�е���������
doc         % �鿴�ĵ�
who         % �鿴���б���
whos        % �鿴���б�������ϸ��Ϣc
save hello.mat v    % ������v���浽�ļ���
save hello.txt v -ascii

%% II. MATLAB��������

%%
% 1. ����

2 + 3

%%
% 2. �ַ����ַ���

s = 'a'
abs(s)
char(65)
num2str(65)

str = 'I Love MATLAB & Machine Learning.'

length(str)

doc num2str

%%
% 3. ����

A = [1 2 3; 4 5 2; 3 2 7]
B = A'
C = A(:)		% ��Aת����һ��������[1 2 3 4 5 2 3 2 7]'
D = inv(A)
A * D
%%
% 

E = zeros(10,5,3)
E(:,:,1) = rand(10,5)
E(:,:,2) = randi(5, 10,5)
E(:,:,3) = randn(10,5)

%%
% 4. Ԫ������

A = cell(1, 6)
A{2} = eye(3)
A{5} = magic(5)
B = A{5}

%% III. MATLAB�������

%%
% 1. ����Ķ����빹��

A = [1 2 3 5 8 5 4 6]
B = 1:2:9
C = repmat(B, 3, 1)
D = ones(2, 4)

%%
% 2. �������������

A = [1 2 3 4; 5 6 7 8]
B = [1 1 2 2; 2 2 1 1]
C = A + B
D = A - B
E = A * B'
F = A .* B
G = A / B     % B * G = A
H = A ./ B

%%
% 3. ������±�

A = magic(5)

B = A(2,3)
B([1 3], :)     % ȡ�±�Ϊ1��3����

C = A(3,:)
D = A(:,4)
D(:)            % ��Dת����һ��������

[m, n] = find(A > 20)


%% VI. MATLAB������ͼ����

%%
% 0. ��ͼ
x = (0:0.01:0.98)
y = sin(2*pi*x*8)
plot(x,y)

hold on;            % ��ԭͼ���ϼ�����

y2 = cos(2*pi*x*8)
plot(x,y2,'r')

axis([30, 100, 30, 100])	% ���ú������������

xlabel('time')          % x������
ylabel('value')         % y������
legend('sin','cos')     % ÿ�����ߵĺ���
title('my plot')
print -dpng 'myPlot.png'

close                   % �رմ���


%%
% 1. ��άƽ���ͼ

x = 0:0.01:2*pi;
y = sin(x);
figure
plot(x, y)
title('y = sin(x)')
xlabel('x')
ylabel('sin(x)')
xlim([0 2*pi])

x = 0:0.01:20;
y1 = 200*exp(-0.05*x).*sin(x);
y2 = 0.8*exp(-0.5*x).*sin(10*x);
figure
[AX,H1,H2] = plotyy(x,y1,x,y2,'plot');
set(get(AX(1),'Ylabel'),'String','Slow Decay')
set(get(AX(2),'Ylabel'),'String','Fast Decay')
xlabel('Time (\musec)')
title('Multiple Decay Rates')
set(H1,'LineStyle','--')
set(H2,'LineStyle',':')

%%
% 2. ��ά�����ͼ

t = 0:pi/50:10*pi;
plot3(sin(t),cos(t),t)
xlabel('sin(t)')
ylabel('cos(t)')
zlabel('t')
grid on
axis square

%%
% 3. ͼ�εı����뵼��

% (1) Edit �� Copy Figure
% (2) Toolbar �� Save
% (3) print('-depsc','-tiff','-r300','picture1')
% (4) File �� Export Setup

%% VII. MATLAB�ļ�����

%%
% 1. mat��ʽ

save data.mat x y1 y2
clear all
load data.mat

%%
% 2. txt��ʽ

M = importdata('myfile.txt');

S = M.data;
save 'data.txt' S -ascii
T = load('data.txt');

isequal(S, T)

%%
% 3. xls��ʽ

xlswrite('data.xls',S)
W = xlsread('data.xls');
isequal(S, W)

xlswrite('data.xlsx',S)
U = xlsread('data.xlsx');
isequal(S, U)

%%
% 4. csv��ʽ

csvwrite('data.csv',S)
V = csvread('data.csv');
isequal(S, V)