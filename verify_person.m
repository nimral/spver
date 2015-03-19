% Scenario: We have already collected recordings of a group
% of people who form our group of interest and we want to
% allow these people access to the system. The collected data
% are stored in database.m.

% Each person in the group is uniquely identified by an id.

% Function takes two optional arguments for automatic testing -- name of the
% person trying to access the system and name of the person they pretend to be.
function y = verify_person(test_person_name, claimed)

id.('adam') = 1;
id.('jonatan') = 2;
id.('matej') = 3;

% Load database
if nargin == 0
    database = load('database.mat');
else
    database = load('database_split.mat');
end
database = database.database;

% Load thresholds for each user and digit
thresholds = load('thresholds.mat');
thresholds = thresholds.thresholds;

% Load false negatives rates for deciding which digits should we ask the tested
% person to utter
fnrs = load('fnrs.mat');
fnrs = fnrs.fnrs;

if nargin >= 2
    claimed_person = claimed;
else
    claimed_person = input('Please enter your name:', 's');
end

% Reject an unknown person early and exit
if isfield(id, claimed_person) == 0
	disp('No such person in the database!');
	return;
end

% Retrieve the id of the person against whom we are going to
% verify the identity of the speaker
claimed_id = id.(claimed_person);

% Get five digits with the best FNR
fnrs_digits = [fnrs(:, claimed_id) [1:9 0]'];
fnrs_digits = sortrows(fnrs_digits);
digits = fnrs_digits(1:5, 2);

% For automatic testing
if nargin >= 1
    test_person = id.(test_person_name);
end

% Prompt the user for this many digits
query_cnt = 5;

% Allow the user to make at most this many 'mistakes'
max_err_cnt = 1;

% 'Mistakes' made so far
err_cnt = 0;

for i = 1:query_cnt
	% Get a random digit
	dig = digits(randi([1, length(digits)]));
    digindex = dig;
    if dig == 0
        digindex = 10;
    end

    features = {};

    if nargin == 0
        % Ask the user to utter the digit dig in 3,2,1 and go
        sample = RecordVoice('', dig, -1, 1);

        % Create a cell array accepted as a parameter by the distance fnc
        % Extract the features from sample
        features{1} = mfcc('', sample);
    else
        % Automatic
        rec = randi([1, length(database{test_person+3}{digindex})]);
        features{1} = database{test_person+3}{digindex}{rec};
    end

	% Query the database with id = claimed_id and digit = dig
	% and retrieve the threshold (for given (speaker, digit) pair)
	threshold = thresholds(digindex, claimed_id);
	
	% Now compute the distance between the recorded sample
	% and all the samples in the database and compute the
	% (average) distance
	min_dist = min_distances(features, database{claimed_id}{digindex});
    %[dig threshold min_dist]
	
	% If distance is above threshold increase err_cnt
	if min_dist > threshold
		err_cnt = err_cnt + 1;
	end
end

% Inform the user (s)he was allowed entrance
if err_cnt <= max_err_cnt
    fprintf('Welcome, %s!', claimed_person);
    y = 1;
else
    disp('You good sir, are a fraud!');
    y = 0;
end

end
