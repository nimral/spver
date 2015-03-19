% computes MFCC for recordings in the database and saves it to database.mat

function database = create_database()
    names = {'adam', 'jonatan', 'matej'};

    database = {};
    for n = 1:length(names)
        for dig = 0:9
            digit = dig;
            if dig == 0
                digit = 10;
            end

            dirname = '../audio_data/labeled/AdamJonatanMatej/';

            % dig != digit
            listings = dir(strcat(dirname, names{n}, '*_', int2str(dig), '_*.wav'));
            i = 1;
            for file = listings'
                database{n}{digit}{i} = mfcc(strcat(dirname, file.name));
                i = i+1;
            end
        end
    end

    %for n = 1:length(names)
        %for dig = 0:9
            %digit = dig;
            %if dig == 0
                %digit = 10;
            %end

            %dirname = '../audio_data/labeled/AdamJonatanMatejNoise/';

            %% dig != digit
            %listings = dir(strcat(dirname, names{n}, '_noise_recording_', int2str(dig), '_*.wav'));
            %i = 1;
            %for file = listings'
                %database{n+3}{digit}{i} = mfcc(strcat(dirname, file.name));
                %i = i+1;
            %end
        %end
    %end

    %n = length(names)+1+3;
    %for dig = 0:9
        %digit = dig;
        %if digit == 0
            %digit = 10;
        %end

        %dirname = '../audio_data/labeled/from-TIDIGITS/';
        
        %% dig != digit
        %listings = dir(strcat(dirname, '*_', int2str(dig), '*wav'));

        %i = 1;
        %for file = listings'
            %database{n}{digit}{i} = mfcc(strcat(dirname, file.name));
            %i = i+1;
        %end
    %end

    %n = n+1;
    %for dig = 0:9
        %digit = dig;
        %if digit == 0
            %digit = 10;
        %end

        %dirname = '../audio_data/labeled/Cuave/';
        
        %% dig != digit
        %listings = dir(strcat(dirname, int2str(dig), '*wav'));

        %i = 1;
        %for file = listings'
            %database{n}{digit}{i} = mfcc(strcat(dirname, file.name));
            %i = i+1;
        %end
    %end


    save('database.mat', 'database');
    database = modify_database(database);
    save('database_split.mat', 'database');
end
