function outputArray = get_val(inputArray, minValue, maxValue)
    % Initialize the output array with the same values as the input array
    outputArray = inputArray;
    
    % Find the repeated values within the specified range
    repeatedValues = inputArray;
    repeatedValues(inputArray < minValue | inputArray > maxValue) = NaN; % Exclude values outside the range
    [~, uniqueIndices, ~] = unique(repeatedValues, 'stable'); % Find the indices of the unique values
    
    % Replace the repeated values within the specified range
    for i = 1:numel(uniqueIndices)
        index = uniqueIndices(i);
        repeatedValue = inputArray(index);
        indices = find(inputArray == repeatedValue);
        
        if numel(indices) > 1
            % Generate new values within the range for each repetition
            newValues = randi([minValue, maxValue], [1, numel(indices)]);
            
            % Update the output array with the new values
            outputArray(indices) = newValues;
        end
    end
end
