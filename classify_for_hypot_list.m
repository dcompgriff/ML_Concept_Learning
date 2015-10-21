function [ is_instance ] = classify_for_hypot_list( hypothesis_set, example)
    if isempty(hypothesis_set)
        is_instance = false;
        return;
    end

    for hyp = 1:length(hypothesis_set)
        if classify_example(hypothesis_set{1, hyp}, example)
            is_instance = true;
            return
        end
    end
    
    is_instance = false;
    return;
end

