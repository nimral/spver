
% This function records 3 seconds of a person speaking.
% input is person who speaks and what digit he/she says
% returns vector of samples


function f = RecordVoice(person, digit,number)
delay_constant=.4;
% USING MARIO SOUNDS FOR BEGIN/END RECORD (need 2 mario files)
% start_signal=wavread('mario_jump');
% stop_signal=wavread('mario_pipe');
% mario_fs=48000;

fs=16000;
bits=24;
stereo=1; 
channel=1;



% countdown and record
recobj = audiorecorder(fs,bits,stereo,channel);
% burst energy
record(recobj); pause(delay_constant)
% stop(recobj);

fprintf('say %d in:\n3\n',digit); %sound(start_signal,mario_fs); 
pause(delay_constant);
disp('2'); %sound(start_signal,mario_fs); 
pause(delay_constant);
disp('1'); %sound(start_signal,mario_fs); 
pause(delay_constant);
% record(recobj);
disp('talk');
pause(1.5); %CHANGE NUMBER OF SECONDS TO RECORD HERE
disp('done talking'); stop(recobj);% sound(stop_signal,mario_fs); 

% return normalized samples
T=getaudiodata(recobj); T=T(round(fs*4*delay_constant):length(T));
T=T(:,1); T=T./(max(T)*1.05);
f=T;

wav_name = sprintf('%s_recording_%d_%d', person,digit,number);

wavwrite(T,fs,bits,wav_name);

% % % below is the code for RecordVoice without mario sounds


end

