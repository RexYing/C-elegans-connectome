%% Compute hub score for each neuron

w = 0.5;
n = length(AGap(1, :));
A2 = zeros(size(AGap));
for i = 1: n
    for j = 1: n
        r = AGap(i, :);
        c = AGap(:, j)';
        secConn = sum(min([r; c], [], 1));
        A2(i, j) = AGap(i, j) + secConn;
    end
end

deg = sum(A2);
plot(deg)