function outputArray = get_val1(inputArray, minValue, maxValue)
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
            % Generate new floating-point values within the range for each repetition
            newValues = minValue + rand(size(indices)) * (maxValue - minValue);
            
            % Update the output array with the new values
            outputArray(indices) = newValues;
        end
    end
    
    % Adjust the sum of the output array to be equal to the maximum value
    outputArray = outputArray * maxValue / sum(outputArray);
end
