function [ is_general ] = is_more_general_than_or_equal( hypothesis_1, hypothesis_2 )
%is_more_general_than Checks to make sure the hypothesis_1 is more general
%than or equal to hypothesis 2

% For each attribute i
for i = 1:length(hypothesis_2)
    % For the bin in hypothesis_2
    % Check to see if the bin in hypothesis_2 is in hypothesis_1
    if isequal(hypothesis_1{1, i}{1,1}, -1)
        continue;
    elseif isequal(hypothesis_1{1, i}{1,1}, hypothesis_2{1,i}{1,1})
        continue;
    end
    is_general = false;
    return;
end

is_general = true;

end

