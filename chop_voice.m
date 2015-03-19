function [ chopped_file ] = chop_voice( unchopped_file )
% chop only once!!

fs=16000;
window_size=100;
threshold=1.8;


% FIND MEAN VALUES
testwins=sound2windows(unchopped_file,window_size,window_size,16000); %in many rows
for i=1:size(testwins,1)
   meanvalues(i)=mean(abs(testwins(i,:)));
end

% FIND STARTING POINT
start_point=1;
for i=1:size(testwins,1)-1
    if (meanvalues(i+1)/meanvalues(i)) > threshold
        start_point=max(i-1,1);
        break;
    end
end
% FIND ENDING POINT
maxlength=size(testwins,1);
end_point=maxlength;
for i=0:maxlength-2
    if meanvalues(maxlength-i-1)/meanvalues(maxlength-i) > threshold
        end_point=min(maxlength-i+1,maxlength);
        break;
    end
end

if end_point < start_point
    chopped_file = unchopped_file;
else
    chopped_file=unchopped_file(max(1,window_size*(start_point-1)/1000*fs):window_size*end_point/1000*fs);
end
end

