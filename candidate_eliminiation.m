function [ s_hypothesis, g_hypothesis ] = candidate_eliminiation( data_array, answer, answer_column, bins_of_attributes )
%candidate_eliminiation Implements the candidate elimination algorithm
% Initialize the s_hypothesis to nil, and the g_hypothesis to the most
% general with {-1} elements. 
s_hypothesis = {};
g_hypothesis = {};

%Make initial hypotheses for s and g set.
init_g = {};
init_s = {};
for i = 1:length(bins_of_attributes)
    init_s{1, i} = {};
    init_g{1, i} = {-1};
end

%Since g is a set of hypotheses, set it to the hypotheses initially
%created. 
g_hypothesis{1, 1} = init_g;
s_hypothesis = init_s;

% Iterate through each data example
for i = 1:length(data_array)
    % Check to see if the example is positive
    if data_array(i, answer_column) == answer
        % Check every hypothesis in G to make sure it is consistent with
        % the positive example
        inconsistent_hypotheses = [];
        for hyp = 1:length(g_hypothesis)
            if ~classify_example(g_hypothesis{hyp}, data_array(i, 1:(answer_column-1)))
                % Mark the incosistent hypothesis to be removed
                inconsistent_hypotheses(length(inconsistent_hypotheses) + 1) = hyp;
            end
        end
        
        % Remove the inconsistent hypotheses
        g_hypothesis(inconsistent_hypotheses) = [];
        
        % Minimally generalize the s_hypothesis to be consistent with the
        % positive example
        % Check to see if the example is in the s_hypothesis
        
        
        %Min generalize steps for conjunctive hypothesis:
        %1) If attrib of hypothesis is {}, then add the bin that the
        %example attrib value falls into.
        %2) If attrib of hypothesis is a bin with two elements {#, #}, then
        %set the attrib of the new hypothesis to {-1}
        for j = 1:length(bins_of_attributes)
            is_in_hypothesis = false;
            
            %Check if hypothesis attrib is {}, {-1}, or if the data
            %value falls into the current hypothesis attrib bin. 
            if isequal(s_hypothesis{1, j}, {})
                is_in_hypothesis = false;
            elseif isequal(s_hypothesis{1, j}, {-1})
                is_in_hypothesis = true;
            elseif data_array(i, j) >= s_hypothesis{1,j}{1,1}(1) && data_array(i,j) <= s_hypothesis{1,j}{1,1}(2)
                is_in_hypothesis = true;
            end
            
            % If not in hypothesis, then minimally generalize the
            % s_hypothesis to include the positive example
            if ~is_in_hypothesis
                if isequal(s_hypothesis{1, j}, {-1})
                    %If most general already, then continue on the process
                    %the next attrib.
                    continue
                elseif isequal(s_hypothesis{1, j}, {})
                    %If current attribute is empty, then find the bin
                    %corresponding to the data element, and add it to
                    %the hypothesis.
                    for k = 1:length(bins_of_attributes{1, j})
                        if data_array(i, j) >= bins_of_attributes{1,j}{1,k}(1) && data_array(i,j) <= bins_of_attributes{1,j}{1,k}(2)
                            %s_hypothesis{1, j}{1, length(s_hypothesis{1, j}) + 1} = bins_of_attributes{1,j}{1,k};
                            %Set the hypothesis attribute to the bin. 
                            s_hypothesis{1, j} = {bins_of_attributes{1,j}{1,k}};
                        end
                    end
                else
                    %If the hypothesis already has a bin, then
                    %generalize that attribute to {-1}
                     s_hypothesis{1, j} = {-1};
                end
            end
        end
        
        % Check to make sure the specific hypothesis is more specific than
        % at least one general hypothesis
        is_more_specific = false;
        for g_hyp = 1:length(g_hypothesis)
           if is_more_general_than_or_equal(g_hypothesis{1, g_hyp}, s_hypothesis)
               is_more_specific = true;
               break;
           end
        end
        
        if ~is_more_specific
            disp('There is no most specific hypothesis that can consistently classify the data.')
            disp('The following training example is inconsistent with learning thus far.')
            data_array(i, :)
            s_hypothesis = {};
            g_hypothesis = {};
            return;
        end
        
    elseif data_array(i, answer_column) ~= answer
        % Check to see if the s_hypothesis is inconsistent with data set
        if classify_example(s_hypothesis, data_array(i, 1:(answer_column-1)))
            disp('There is no most general set of hypotheses that can consistently classify the data.')
            disp('The following training example is inconsistent with learning thus far.')
            data_array(i, :)
            s_hypothesis = {};
            g_hypothesis = {};
            return;
        end
        
        inconsistent_hypotheses = [];
        for hyp = 1:length(g_hypothesis)
            if classify_example(g_hypothesis{hyp}, data_array(i, 1:(answer_column-1)))
                % Mark the incosistent hypothesis to be removed
                inconsistent_hypotheses(length(inconsistent_hypotheses) + 1) = hyp;
            end
        end
        % Copy the inconsistent hypotheses to a temp variable, and
        % remove them from the g_hypothesis
        incon_hyp = g_hypothesis(inconsistent_hypotheses);
        g_hypothesis(inconsistent_hypotheses) = [];
        
        % Minially specialize each of the inconsistent hypotheses to
        % make them consistent with, while making sure they're more general than
        % specific hypothesis.  Then, add them back into to
        % g_hypothesis
        for hyp = 1:length(incon_hyp)
            for attrb = 1:length(incon_hyp{1, hyp})
                
                %If hypot attrib == {-1}, then specify.
                %If hypot attrib == bin, and data value not in bin, then
                %remove hypot. 
                
                if isequal(incon_hyp{1, hyp}{1, attrb}, {-1})
                    %If hypot attrib == {-1}, then find corresponding bin and specify.
                    for bin = 1:length(bins_of_attributes{1, attrb})
                        if data_array(i, attrb) >= bins_of_attributes{1, attrb}{1,bin}(1) && data_array(i,attrb) <= bins_of_attributes{1, attrb}{1,bin}(2)
                            continue
                        else 
                            temp_hypothesis = incon_hyp{1, hyp};
                            temp_hypothesis{1, attrb} = {bins_of_attributes{1, attrb}{1,bin}};

                            % Check to make sure the new general hypothesis is
                            % more general than or equal to s_hypothesis
                            if is_more_general_than_or_equal(temp_hypothesis, s_hypothesis)
                                g_hypothesis{1, length(g_hypothesis) + 1} = temp_hypothesis;
                            end
                        end
                    end
                end
            end
        end
        
        % The algorithm specifies to find all of the general hypotheses that 
        % specific forms of another general hypothesis.  
        % We don't need to do this because of the way we form our 
        % conjunctive hypothesis space.
    end
    
end

end

