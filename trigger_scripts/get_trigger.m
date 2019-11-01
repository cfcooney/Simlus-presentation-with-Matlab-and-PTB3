function epochs = get_trigger(X, pre, pst)
%----------------------------------------------------------------
% Function for extracting epoched data from signal and trigger array.
% Inputs: X (double): recorded EEG data. number of channels -1 is trigger.
%         pre (int): number of samples to extract pre-trigger (positive).
%         pst (int): number of samples to extract post-trigger.  
%
% Output : epochs (double): All channels of EEG data corresponding to task
%          performance. Includes trigger channel with class ids.

[nc,ns] = size(X);

trig = X(nc,:);
trig_ids = find(trig);

sz  = [nc, pst+pre+1, length(trig_ids)];
epochs   = repmat(NaN, [sz(1), sz(2)*sz(3)]); 

segment = X(:,(trig_ids(1) - pre):(trig_ids(1) + pst));

i = 1; %% Need to shift the trigger channel to be returned to begin at 0.
for j = 1:sz(3)
    segment = X(:,(trig_ids(j) - pre):(trig_ids(j) + pst));
    epochs(:, i: sz(2)*j) = segment;

    i = i + sz(2);
end


