% temporary scripts
% Rex Ying

%% check self-connect
%
% result: index 626(RIBL, entry 4235), 643(RIBR, entry 4283), 
% 907(VA08, entry 5747) in gap junction has node connecting to
% itself
% Nothing found in chem junctions
%
disp('Gap:');
for i = 1: size(nodeListGap1, 1)
    if nodeListGap1(i) == nodeListGap2(i)
        fprintf('Neuron name: %s; nodeListGap1 index: %d; edge index: %d\n', ...
            nodeLabel{nodeListGap1(i)}, i, gapJunctionIndices(i));
    end
end
disp('Chem:');
for i = 1: size(nodeListChem1, 1)
    if nodeListChem1(i) == nodeListChem2(i)
        disp(i);
    end
end

