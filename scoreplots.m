function [F] = scoreplots(A,Y,T,data)

for j = 1:(A-1)    
    tj = T(:,j); %Component j's scores

    for k = (j+1):A
        tk= T(:,k); %Component k's scores

        if (j ~= k) %To avoid repeats
            scoreplot(Y,tj,tk,j,k); %Create scoreplot
            text = [j,k];
            filename = ...
                sprintf('ScorePlot_%s_Component%dand%d.png',data,text);
            saveas(gcf,filename);
            close(gcf);
        end

    end
end

end