[note, Fs] = audioread('note.wav');
[harmonic] = audioread('harmonic.wav');
[string] = audioread('Mi.wav');


note = note(1*Fs:3*Fs);
harmonic1 = harmonic(3*Fs:5*Fs); %change between 2 and 3 in order to take / remove the attack
% the attack shows a more randomic behavior in the frequency domain, which
% is coherent with the difficulty of pitch detection over impulse/fast
% attack signals (as drums ecc...) as shown in Signal processing and computer music
% systems 

string = string(2*Fs:4*Fs);

sound(note,Fs);
pause(3);
sound(harmonic1,Fs);
pause(3);
sound(string,Fs);

N = 2^ceil(log2(length(note)));
N1 = 2^ceil(log2(length(harmonic1)));
N2 = 2^ceil(log2(length(string)));

fft_note=fft(note,N);
fft_harmonic1 = fft(harmonic1,N1);
fft_string=fft(string,N2);

faxes = Fs/N*(0:N/2-1);
faxes1 = Fs/N1*(0:N1/2-1);
faxes2 = Fs/N2*(0:N2/2-1);


spectrum_fig = figure();
subplot(3,1,1);
semilogx(faxes,db(abs(fft_string(1:end/2))),'DisplayName','S');
title('Open string, fundamental at 329.63 Hz');
xlabel('f [Hz]');
ylabel('Magnitude [dB]');
xlim([100,Fs/2]);
grid on;

subplot(3,1,2);
semilogx(faxes1,db(abs(fft_harmonic1(1:end/2))),'DisplayName','S');
title('5° fret harmonic');
xlabel('f [Hz]');
ylabel('Magnitude [dB]');
xlim([100,Fs/2]);
grid on;

subplot(3,1,3);
semilogx(faxes2,db(abs(fft_note(1:end/2))),'DisplayName','S');
title('5° fret note');
xlabel('f [Hz]');
ylabel('Magnitude [dB]');
xlim([100,Fs/2]);
grid on;

harmonic2= harmonic(2*Fs:5*Fs);
N3 = 2^ceil(log2(length(harmonic2)));
fft_harmonic2 = fft(harmonic2,N3);
faxes3 = Fs/N3*(0:N3/2-1);

figure();
subplot(2,1,1);
semilogx(faxes3,db(abs(fft_harmonic2(1:end/2))));
title('with attack');
xlabel('f [Hz]');
ylabel('Magnitude [dB]');
xlim([100,Fs/2]);
grid on;

subplot(2,1,2);
semilogx(faxes1,db(abs(fft_harmonic1(1:end/2))),'DisplayName','S');
title('without attack');
xlabel('f [Hz]');
ylabel('Magnitude [dB]');
xlim([100,Fs/2]);
grid on;

%% filtering 




