function [ hypothesis_set, nodes_visited ] = list_then_eliminate( data_array, answer, answer_column, bins_of_attributes )
%List then eliminate concept learning. 
%   List all possible hypothesis. Then, for each hypothesis, check to see
%   if it classifies all positive examples as positive, and all negative
%   examples as negative. Does this recursively

  
hypothesis = {};
for i = 1:length(bins_of_attributes)
    hypothesis{1, i} = {-1};
end

[hypothesis_set, nodes_visited] = list_then_eliminate_helper_recursive(hypothesis, data_array, bins_of_attributes, answer_column, answer)

end

