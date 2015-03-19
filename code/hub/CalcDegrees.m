function degrees=CalcDegrees(A,mode)
%
%mode is either 'primary' or 'secondary'
%
switch mode
    case 'primary'
        degrees=sum(A,2);
    case 'secondary'
        %REX CODE
end