function [ s_hypothesis, g_hypothesis ] = candidate_eliminiation( data_array, answer, answer_column, bins_of_attributes )
%candidate_eliminiation Implements the candidate elimination algorithm

% Initialize the hypothesis to the nil h
s_hypothesis = {};
for i = 1:length(bins_of_attributes)
    s_hypothesis{1, i} = {};
end

% Intialize the general hypothesis to be all bins
g_hypothesis = {};
g_hypothesis{1} = bins_of_attributes;

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
                inconsistent_hypotheses(length(inconsistent_hypothesis) + 1) = hyp;
            end
        end
        
        % Remove the inconsistent hypotheses
        g_hypothesis(inconsistent_hypotheses) = [];
        
        % Minimally generalize the s_hypothesis to be consistent with the
        % positive example
        % Check to see if the example is in the s_hypothesis
        for j = 1:length(bins_of_attributes)
            is_in_hypothesis = false;
            for k = 1:length(s_hypothesis{1, j})
                if data_array(i, j) >= s_hypothesis{1,j}{1,k}(1) && data_array(i,j) <= s_hypothesis{1,j}{1,k}(2)
                    is_in_hypothesis = true;
                end
            end
            
            % If not in hypothesis, then minimally generalize the
            % s_hypothesis to include the positive example
            if ~is_in_hypothesis
                for k = 1:length(bins_of_attributes{1, j})
                    if data_array(i, j) >= bins_of_attributes{1,j}{1,k}(1) && data_array(i,j) <= bins_of_attributes{1,j}{1,k}(2)
                        s_hypothesis{1, j}{1, length(s_hypothesis{1, j}) + 1} = bins_of_attributes{1,j}{1,k};
                    end
                end
            end
        end
    elseif data_array(i, answer_column) ~= answer
        % Check to see if the s_hypothesis is inconsistent with data set
        if classify_example(s_hypothesis, data_array(i, 1:(answer_column-1)))
            disp('The following training example is inconsistent with learning thus far, and thus will be ignored.')
            data_array(i)
        end
        
        incosistent_hypotheses = [];
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
                % Find the bin that matches with the negative example
                % attribute fall into
                for bin = 1:length(incon_hyp{1, hyp}{1, attrb})
                    if data_array(i, attrb) >= incon_hyp{1, hyp}{1, attrb}{1, bin}(1) && data_array(i,attrb) <= incon_hyp{1, hyp}{1, attrb}{1, bin}(2)
                        % Add to the g_hypothesis set the specialized hypothesis
                        temp_hypothesis = incon_hyp{1, hyp};
                        temp_hypothesis{1, attrb}(bin) = [];
                        
                        % Check to make sure the new general hypothesis is
                        % more general than or equal to s_hypothesis
                        if is_more_general_than_or_equal(temp_hypothesis, s_hypothesis)
                            g_hypothesis{1, length(g_hypothesis) + 1} = temp_hypothesis;
                        end
                        break;
                    end
                end
            end
        end
        
        % Find all of the general hypotheses that specific forms of another
        % general hypothesis.  Remove them!
        redundant_hyp = [];
        for hyp = 1:length(g_hypothesis)
           for hyp_2 = (hyp+1):length(g_hypothesis)
              if is_more_general_than_or_equal(g_hypothesis{1, hyp}, g_hypothesis{1, hyp_2})
                 %disp('Found a more general hypothesis within the g_hypothesis space')
                 redundant_hyp(length(redundant_hyp) + 1) = hyp_2;
              end
           end
        end
        g_hypothesis(redundant_hyp) = [];
    end
    
    i
end


end
