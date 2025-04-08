function [F] = loadingplots(A,P,var,data)

for a = 1:A
    loadings = P(:,a); %Loadings for component a

    loading_plot(loadings,a,var); %Create loading plot

    filename = sprintf('LoadingPlot_%s_Component%d.png', data, a);
    saveas(gcf,filename);
    close(gcf);
end

end