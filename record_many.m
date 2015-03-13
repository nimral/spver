function [ f ] = record_many( name,no_recordings )

    for i=1:no_recordings
       for digit=0:9
           RecordVoice(name,digit,i);
       end
    end
f=0;
end

