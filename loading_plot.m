% function that creates a loadings bar plot

% Jake Nease
% Chemical Engineering
% McMaster University

% Pass in the appropriate loading
% Pass in the tag of the loading (1, 2, 3 etc)
% Pass in the names of the data labels

function [F] = loading_plot(p,number,Dataset)
Dataset = Dataset(:);

[~, idx] = sort(abs(p),'descend');
p_sorted = p(idx);
Dataset_sorted = Dataset(idx);
D = categorical(Dataset_sorted); % <-- needed for bar plot
D = reordercats(D, Dataset_sorted);

% Make the actual loadings plot
F = figure;
hold on;

barh(D, p_sorted,'FaceColor','red','EdgeColor','black');
grid on;
box on;
xlabel(['Loadings for Component ' num2str(number)]);

ax = gca;
ax.FontSize = 6;

hold off;

end