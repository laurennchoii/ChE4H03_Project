function [varexplained,F] = screeplot(totalvar,A,T_pca,data)

varexplained = zeros(1,A); %variance explained by each component

for a = 1:A
    varexplained(a) = sum(T_pca(:,a).^2) / totalvar;
end

cumvarexplained = cumsum(varexplained); %cumulative variance

F=figure;
yyaxis left
plot(1:A, varexplained, '-o', 'DisplayName', 'Variance Explained');
yyaxis right
plot(1:A, cumvarexplained, '-s', 'DisplayName', ...
    'Cumulative Variance Explained');
xlabel('Number of Components');
legend('Location','southoutside');
filename = sprintf("ScreePlot_%s.png",data);
saveas(gcf,filename);
close(gcf);

end