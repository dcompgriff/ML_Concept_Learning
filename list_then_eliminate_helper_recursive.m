function [ consistent_hypotheses, nodes_visited ] = list_then_eliminate_helper_recursive( current_hypothesis, data_set, bins_of_attributes, answer_column, answer)
%list_then_eliminate_helper_recursive 

nodes_visited = 1;
consistent_hypotheses = {};
is_consistent = true;
for i = 1:length(data_set)
    if classify_example(current_hypothesis, data_set(i, 1:(answer_column-1))) ~= (data_set(i, answer_column) == answer)
        is_consistent = false;
    end
end

if is_consistent
    consistent_hypotheses{1} = current_hypothesis;
end

for attrib = 1:length(current_hypothesis)
    if current_hypothesis{1,attrib}{1,1} == -1
        for bin = 1:length(bins_of_attributes{1, attrib})
            new_hypothesis = current_hypothesis;
            new_hypothesis{attrib} = {bins_of_attributes{1, attrib}{1, bin}};
            [new_consistent_hypotheses, new_nodes_visited] = list_then_eliminate_helper_recursive(new_hypothesis, data_set, bins_of_attributes, answer_column, answer);
            consistent_hypotheses = [consistent_hypotheses new_consistent_hypotheses];
            nodes_visited = new_nodes_visited + nodes_visited;
            if nodes_visited > 1000
                nodes_visited
            end
        end
    end
end



end

