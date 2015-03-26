function degrees=CalcDegrees(A,mode)
%
%mode is either 'primary' or 'secondary'
%
switch mode
    case 'primary'
        degrees=sum(A,2);
    case 'secondary'
        w = 0.5; % secondary weight
        n = length(A(1, :));
        A2 = zeros(size(A));
        for i = 1: n
            for j = 1: n
%                 r = A(i, :);
%                 c = A(:, j)';
                r = A(j, :);
                secConn = sum(min([r], [], 1)) * w;
                A2(i, j) = A(i, j) + secConn ;
            end
        end

        degrees = sum(A2, 2);
        figure;
        plot(sort(degrees))
end