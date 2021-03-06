%% Compute hub score for each neuron
w = 0.5;
n = length(AHermGap(1, :));
A2 = zeros(size(AHermGap));
for i = 1: n
    for j = 1: n
        r = AHermGap(i, :);
        c = AHermGap(:, j)';
        secConn = sum(min([r; c], [], 1));
        A2(i, j) = AHermGap(i, j) + secConn;
    end
end

deg = sum(A2);
plot(sort(deg))