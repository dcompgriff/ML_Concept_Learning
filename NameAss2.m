bins_of_attributes = {};

for i = 1:4
    bins_of_attributes{1, length(bins_of_attributes) + 1} = get_attribute_bins(Data, i, 5);
end
% 
% %  Find_S for Setosa first
% h_s_setosa = find_s(Data, 1, 5, bins_of_attributes);
% 
% %  Find_S for Versicolor first
% h_s_versicolor = find_s(Data, 2, 5, bins_of_attributes);
% 
% %  Find_S for Virginica first
% h_s_virginica = find_s(Data, 3, 5, bins_of_attributes);
% 
% % Classify an example in Setosa and not Setosa
% classify_example(h_s_setosa, [5.1, 3.5, 1.4, .2]) % setosa
% classify_example(h_s_setosa, [7, 3.2, 4.7, 1.4]) % versicolor
% 
% % Classify an example for Versicolor
% classify_example(h_s_versicolor, [7, 3.2, 4.7, 1.4])
% 
% % Classify an example for Virginica
% classify_example(h_s_virginica, [7.3, 2.9, 6.3, 1.8])
% 
% % Check all of the values, with each of the hypotheses
% c_set = [];
% for i = 1:150
%     c_set(i) = classify_example(h_s_setosa, Data(i, 1:4));
% end
% 
% c_ver = [];
% for i = 1:150
%     c_ver(i) = classify_example(h_s_versicolor, Data(i, 1:4));
% end
% 
% c_vir = [];
% for i = 1:150
%     c_vir(i) = classify_example(h_s_virginica, Data(i, 1:4));
% end


% Candidate Elimination for Setosa
%h_s_setosa = candidate_eliminiation(Data, 1, 5, bins_of_attributes);
[h_s_setosa, nodes_visited] = list_then_eliminate(Data, 1, 5, bins_of_attributes);
