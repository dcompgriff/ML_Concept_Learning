function [ is_instance ] = classify_example ( hypothesis, example )
%classify_example Checks to see if the example is in the hypothesis space

for i = 1:length(example)
    is_in_hypothesis = false;
    for j = 1:length(hypothesis{1, i})
        if isequal(hypothesis{1,i}{1,1}, -1)
            is_in_hypothesis = true;
        elseif example(1, i) >= hypothesis{1,i}{1,j}(1) && example(1, i) <= hypothesis{1,i}{1,j}(2)
            is_in_hypothesis = true;
        end
    end
    
    if ~is_in_hypothesis
        is_instance = false;
        return
    end
end

is_instance = true;

end

