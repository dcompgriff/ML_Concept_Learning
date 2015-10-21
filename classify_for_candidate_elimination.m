function [ is_instance ] = classify_for_candidate_elimination( s_hypothesis, g_hypothesis, example )
    if isempty(s_hypothesis) || isempty(g_hypothesis)
        is_instance = false;
        return
    end

    if ~classify_example(s_hypothesis, example)
        is_instance = false;
        return
    end
    
    for hyp = 1:length(g_hypothesis)
        if classify_example(g_hypothesis{1, hyp}, example)
            is_instance = true;
            return
        end
    end
    
    is_instance = false;
    return;
end

