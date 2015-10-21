function [ is_general ] = is_more_general_than_or_equal( hypothesis_1, hypothesis_2 )
%is_more_general_than Checks to make sure the hypothesis_1 is more general
%than or equal to hypothesis 2

% For each attribute i
for i = 1:length(hypothesis_2)
    % For each bin in hypothesis 2
    for j = 1:length(hypothesis_2{1, i})
        % Check to see if the bin in hypothesis_2 is in hypothesis_1
        is_in_hypothesis_1 = false;
        for k = 1:length(hypothesis_1{1, i})
            if isequal(hypothesis_1{1, i}{1, k}, hypothesis_2{1,i}{1,j})
                is_in_hypothesis_1 = true;
                break
            end
        end
        
        if ~is_in_hypothesis_1
            is_general = false;
            return;
        end
    end
end

is_general = true;

end
