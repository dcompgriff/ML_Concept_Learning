function [ hypothesis ] = find_s( data_array, answer, answer_column, bins_of_attributes )
%find_s The find_s function finds the most specific hypothesis
%   That works with the concept space

% Initialize the hypothesis to the nil h
hypothesis = {};
for i = 1:length(bins_of_attributes)
    hypothesis{1, i} = {};
end

% Iterate through the data array
for i = 1:length(data_array)
    % Check to see if the example is a positive one
    if data_array(i, answer_column) == answer
        % Check to see if the example is in the hypothesis
        for j = 1:length(bins_of_attributes)
            is_in_hypothesis = false;
            for k = 1:length(hypothesis{1, j})
                if data_array(i, j) >= hypothesis{1,j}{1,k}(1) && data_array(i,j) <= hypothesis{1,j}{1,k}(2)
                    is_in_hypothesis = true;
                end
            end
            
            % If not in hypothesis, then we have to make the hypothesis
            % more general
            if ~is_in_hypothesis
                for k = 1:length(bins_of_attributes{1, j})
                    if data_array(i, j) >= bins_of_attributes{1,j}{1,k}(1) && data_array(i,j) <= bins_of_attributes{1,j}{1,k}(2)
                        hypothesis{1, j}{1, length(hypothesis{1, j}) + 1} = bins_of_attributes{1,j}{1,k};
                    end
                end
            end 
        end        
    end
end


end

