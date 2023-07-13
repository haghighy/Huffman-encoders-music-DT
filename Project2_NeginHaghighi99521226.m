% Negin Haghighi - 99521226
clear, clc;
set(gcf, 'position',  [150, 50, 800, 500])
[y, framePerSec] = audioread('music_bikalam_Negin.wav');
%my_audioP = audioplayer(y, framePerSec);
%play(my_audioP);
y = y(:, 1);
[msSize, X] = size(y);
fprintf('The music data size is: %d\n', msSize)
fprintf('Frame per second is: %d\n', framePerSec);
% duration of data
fprintf('Duration is: %f\n', msSize/framePerSec);
histogram(y, 'FaceColor', 'blue');
grid on;
probability = hist(y) / sum(hist(y));
enthropy = -sum(probability .* log2(probability));
fprintf("Enthropy of source is: %f\n", enthropy);
fprintf("Can compress: %f KB\n", msSize*enthropy/8000);
D = huffmandict(hist(y), probability);
signal = randsrc(msSize, 1, [hist(y);probability]);
Cmp = huffmanenco(signal, D);
Cmp = Cmp';
audiowrite('encoded_music_Negin.wav', Cmp, framePerSec);
[x, sizeCmp] = size(Cmp);
fprintf("Size of signal before encoding is: %f KB.\n", msSize/8000);
fprintf("Size of signal after encoding is: %f KB.\n", sizeCmp/8000);
