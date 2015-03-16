% Scenario: We have already collected recordings of a group
% of people who form our group of interest and we want to
% allow these people access to the system. The collected data
% are stored in database.m.

% Each person in the group is uniquely identified by an id.
id.('adam') = 1;
id.('jonatan') = 2;
id.('matej') = 3;

claimed_person = input("Please enter your name:","s");

% Reject an unknown person early and exit
if isfield(id,claimed_person) == 0
	disp('No such person in the database!');
	exit(1);
end

% Retrieve the id of the person against whom we are going to
% verify the identity of the speaker
claimed_id = id.(claimed_person);

% Prompt the user for this many digits.
query_cnt = 5;
% Allow the user to make at most this many 'mistakes'
max_err_cnt = 1;
% 'Mistakes' made so far
err_cnt = 0;

for i = 1:query_cnt
	% Get a random digit
	dig = randi([0, 9]);

	% Ask the user to utter the digit dig in 3,2,1 and go
	% sample = RecordVoice('',dig,-1,1);
	sample = wavread('../audio_data/labeled/AdamJonatanMatej/adam_recording_0_3.wav');

	% Create a cell array accepted as a parameter by the distance fnc
	feats = {};
	% Extract the features from sample
	feats{1} = mfcc('',sample);

	% Query the database with id = claimed_id and digit = dig
	% and retrieve the threshold (for given (speaker, digit) pair)
	threshold = 1;
	
	% Now compute the distance between the recorded sample
	% and all the samples in the database and compute the 
	% (average) distance
	dists = distances(database{claimed_id}{dig}, feats);
	avg_dist = mean(dists);
	
	% If distance distance is above threshold increase err_cnt
	if avg_dist > threshold
		err_cnt = err_cnt + 1
	end
	
	% If err_cnt is above max_err_cnt, exit with a message
	% informing about the non-entrance
	if err_cnt > max_err_cnt
		disp('Sorry, you are not allowed access');
		exit(1);
	end
end

% Inform the user (s)he was allowed entrance
fprintf('Welcome, %s!', claimed_person);
