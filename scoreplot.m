function [F] = scoreplot(Y,tj,tk,j,k)

N = length(Y);

% Possible outputs of Y
possible_Y = [0, 1];

% Markers to identify each output
markers = ["go", "mx"];

% Rest of the code below is adapted from Dr. Jake Nease's "scoreplot.m"
% It has been modified to include each output type as unique markers

% Make the actual score plot
figure;
hold on;
box on;
grid on;

% For each output type
for i = 1:length(possible_Y)

    % Initialize arrays to store tj and tk (larger than needed)
    tj_plot = zeros(N,1);
    tk_plot = zeros(N,1);

    % Store first occurrence of row index for this output type
    first_row = 0;

    % Counter to track number of valid entries for this output type
    % Starts at -1 because it will be used to calculate range later
    diff = -1;

    % For each observation
    for n = 1:N

        % If the observation's tumor type matches the current output type
        if Y(n) == possible_Y(i)

            % Store the row index of the first occurence of this ouput type
            if first_row == 0
                first_row = n;
            end
    
            % Store the corresponding scores
            tj_plot(n,1) = tj(n,1);
            tk_plot(n,1) = tk(n,1);

            % Increment the counter by 1
            diff = diff + 1;
        end

    end

    % Determine the valid range of rows for this output type
    max_row = first_row + diff;

    %Crop arrays to remove unnecessary zero entries
    tj_plot = tj_plot(first_row:max_row, :);
    tk_plot = tk_plot(first_row:max_row, :);

    %Plot data for tumor type using the corresponding marker
    plot(tj_plot, tk_plot, markers(i), "DisplayName", string(possible_Y(i)));
end

%Display legend
lgd = legend("Location","westoutside");
title(lgd, "TYPE");

%Label axes
namex = sprintf('t_%d',j);
xlabel(namex);
namey = sprintf('t_%d',k);
ylabel(namey);

% Plot the T2 elipses
N = length(tj);
a = (std(tj))^2;
b = (std(tk))^2;

% calculate T2 limits
A = 2;
Flim95 = finv(0.95,A,(N-A));
Flim99 = finv(0.99,A,(N-A));
T2lim95 = ((N-1)*(N+1)*A*Flim95)/(N*(N-A));
T2lim99 = ((N-1)*(N+1)*A*Flim99)/(N*(N-A));

% (t1/s1)^2 + (t2/s2)^2 = T2lim
% t1 is x and t2 is y
% parametric eqn for an elipse (RHS needs to be 1): (x,y) =
% (a*cos(theta),b*sin(theta)) for 0 <= theta <= 2*pi
% eqn becomes t1^2/(T2lim*s1^2) + t2^2/(T2lim*s2^2) = 1

% calculate elipse distances
theta = linspace(0,2*pi,50);
x95 = sqrt(a*T2lim95)*cos(theta);
y95 = sqrt(b*T2lim95)*sin(theta);
x99 = sqrt(a*T2lim99)*cos(theta);
y99 = sqrt(b*T2lim99)*sin(theta);

% plot elipse
plot(x95, y95, '--r','HandleVisibility','off')
hold on
plot(x99, y99, '-r', 'HandleVisibility','off')

if max(x99) > max(abs(tj))
    plot([-max(x99)*1.25 max(x99)*1.25], [0 0],'k-', ...
        'LineWidth',2,'HandleVisibility','off');
    xlim = [-max(x99)*1.25 max(x99)*1.25];
else
    plot([-max(abs(tj))*1.25 max(abs(tj))*1.25], [0 0],'k-', ...
        'LineWidth',2,'HandleVisibility','off');
    xlim = [-max(abs(tj))*1.25 max(abs(tj))*1.25];
end

if max(y99) > max(abs(tk))
    plot([0 0], [-max(y99)*1.25 max(y99)*1.25], 'k-', ...
        'LineWidth',2,'HandleVisibility','off');
    ylim = [-max(y99)*1.25 max(y99)*1.25];
else
    plot([0 0], [-max(abs(tk))*1.25 max(abs(tk))*1.25], 'k-',...
        'LineWidth',2,'HandleVisibility','off');
    ylim = [-max(abs(tk))*1.25 max(abs(tk))*1.25];
end

axis([xlim ylim])

hold off;

end