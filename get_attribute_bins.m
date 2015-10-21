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
        start_value = sorted_data_array(i, column);
        prev_end = start_value;
        end_value = start_value;
        
        start_class = sorted_data_array(i, answer_column);
    elseif start_class ~= sorted_data_array(i, answer_column) && end_value == sorted_data_array(i, column)
        if start_value ~= end_value
            bins{1, length(bins) + 1} = [start_value prev_end];
        end
        
        i = i + 1;
        while end_value == sorted_data_array(i, column) && i <= length(data_array)
            i = i + 1;
        end
        if i >= length(data_array)
            break;
        end
        bins{1, length(bins) + 1} = [end_value end_value];
        
        start_value = sorted_data_array(i, column);
        prev_end = start_value;
        end_value = start_value;
        start_class = sorted_data_array(i, answer_column);
    end
    
    i = i + 1;
end

bins{1, length(bins) + 1} = [start_value sorted_data_array(i-1, column)];

end

