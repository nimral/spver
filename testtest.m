% stuffz
% 
% 
% thresholds
%     1.6076    1.6084    1.6054
%     1.6216    1.6185    1.6298
%     
%     fnrs =
% 
%          0    0.4000    0.4000



dirname = '../audio_data/labeled/AdamJonatanMatej/';
g=1;
for dig = 1:9
    % dig != digit
    listings = dir(strcat(dirname, 'jonatan', '_recording_', int2str(dig), '_*.wav'));
    listings2 = dir(strcat(dirname, 'adam', '_recording_', int2str(dig), '_*.wav'));
    i = 1;
    for file = listings'
        for file2 = listings2'
            jonadam_nochop(g)=dtw(mfcc(strcat(dirname, file.name), 1, 0), mfcc(strcat(dirname, file2.name), 1, 0));
            jonadam_chop(g)=dtw(mfcc(strcat(dirname, file.name), 1, 1), mfcc(strcat(dirname, file2.name), 1, 1));
            difference_vector(g)=jonadam_chop(g)-jonadam_nochop(g);
            g=g+1;
        end
    end
end

difference_vector
return





% test unchopped
choice=0; %0 = no chopping, 1 = chopping
adam_and_adam=dtw(mfcc('..\audio_data\labeled\AdamJonatanMatej\adam_recording_0_2.wav',1,choice),mfcc('..\audio_data\labeled\AdamJonatanMatej\adam_recording_0_3.wav',1,choice))
adam_and_jonatan=dtw(mfcc('..\audio_data\labeled\AdamJonatanMatej\adam_recording_0_2.wav',1,choice),mfcc('..\audio_data\labeled\AdamJonatanMatej\jonatan_recording_0_3.wav',1,choice))






% chopped   1.6417
% unchopped 1.6049

% unchopped
% adam_and_adam =
%     1.6049
% adam_and_jonatan =
%     1.6536
% total difference = 1.6536- 1.6049 =  0.0487

% chopped
% adam_and_adam =
%     1.6417
% adam_and_jonatan 
%     1.7258
% total difference = 1.7258- 1.6417 = 0.0841

% THIS IS GOOD, it means chopping increases relative between person difference