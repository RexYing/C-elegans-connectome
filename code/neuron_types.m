% 1: interneuron; 2: sensory neuron; 3: motor neuron 
neuronTypes = [ ...
    1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, ...
    ones(1, 11) * 3, ones(1, 12) * 2, ones(1, 19), 13,  ones(1, 9) * 2, 1, 1, ones(1, 4) * 2, ...
    ones(1, 9) * 3, ones(1, 7) * 3, ones(1, 6) * 3, 1, 13, ...
    1, 2, 2, 3, 3, ones(1, 6) * 123,  ones(1, 6) * 2, 1, 1, 2, 2, ones(1, 4) * 12, 3, 3, ...
    2, 2, ones(1, 11) * 2, 1, 1, 2, 2, 2, 13, 13, ones(1, 8) * 1, ...
    ones(1, 6), 13, ones(1, 5), 13, 13, 1, 1, 1, 1, 13, 13, ones(1, 12) * 3, 1, 1, 3, 3, ...
    ones(1, 7) * 13, 12, 12, ones(1, 8) * 13, ones(1, 8) * 3, ...
    3, 3, 3, 3, 1, 1, ones(1, 6) * 2, ones(1, 12) * 3, ones(1, 11) * 23, ones(1, 5) * 3, ...
    ones(1, 13) * 3
    ];

neuronTypes([54,55,57]) = [];

interIdx = [];
sensoryIdx = [];
motorIdx = [];
for i = 1: length(neuronTypes)
    switch neuronTypes(i)
        case 1
            interIdx = [interIdx, i];
        case 2
            sensoryIdx = [sensoryIdx, i];
        case 3
            motorIdx = [motorIdx, i];
        case 12
            interIdx = [interIdx, i];
            sensoryIdx = [sensoryIdx, i];
        case 23
            sensoryIdx = [sensoryIdx, i];
            motorIdx = [motorIdx, i];
        case 13
            motorIdx = [motorIdx, i];
            interIdx = [interIdx, i];
        case 123
            interIdx = [interIdx, i];
            sensoryIdx = [sensoryIdx, i];
            motorIdx = [motorIdx, i];
    end
end
    
   