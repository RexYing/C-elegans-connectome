%Fit  the degree data of a graph to a power function as in a
%scale-free network
%
%Definition: degree of a node is the number of connections it has to other
%nodes
%
%Just need adjacency matrix A to run the script
hubScores=sum(A,2)+eye;
data=sort(hubScores,'descend');
N=length(data);
[gamma,b,MSE,rsq]=logfit(1:N,data,'loglog');% cite Jonathan C. Lansey
yfit=10^b*data.^gamma;
figure
plot(1:N,data)
hold on
plot(N:-1:1,yfit,'LineStyle','--')
hold off
legend('data','power fit')
title('Scale Free Property')
ylabel('Counts')
xlabel('Node Degrees/HubScores')

