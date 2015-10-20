function [ bins ] = get_attribute_bins( data_array, column, answer_column)
%get_attribute_bins Finds the categorical bins for the Concept Learner
%   By discretizing continuous data

bins = {};

sorted_data_array = sortrows(data_array, column);
start_value = sorted_data_array(1, column);
prev_end = start_value;
end_value = start_value;

start_class = sorted_data_array(1, answer_column);
i = 2;
while i <= length(data_array)
    if start_class == sorted_data_array(i, answer_column)
        if end_value ~= sorted_data_array(i, column)
            prev_end = end_value;
        end
       
        end_value = sorted_data_array(i, column);
    elseif start_class ~= sorted_data_array(i, answer_column) && end_value ~= sorted_data_array(i, column)
        bins{1, length(bins) + 1} = [start_value end_value];
        start_value = sorted_data_array(i, column)
        prev_end = start_value;
        end_value = start_value;
    elseif start_class ~= sorted_data_array(i, answer_column) && end_value == sorted_data_array(i, column)
        bins{1, length(bins) + 1} = [start_value prev_end];
        i = i + 1;
         
    end
        
    
    % Our bin termination case
    if sorted_data_array(i, answer_column) 
end

end

