
function plot_all(xVals, data, legendNames, plotType, modeType, ...
                  figureTitle, xlabelStr, ylabelStr, saveResults, showPlots, outDir, fileNameSuffix)
% plot_all: Flexible plotting utility called explicitly per-variable.
%
% Inputs:
%  - xVals        : vector for x-axis (length must equal number of rows in data)
%  - data         : matrix (rows = x points, columns = series) OR vector
%  - legendNames  : cell array or string array of legend labels (one per column)
%  - plotType     : 'bar' or 'line'
%  - modeType     : 'comparative' or 'performance' (affects legend location/title)
%  - figureTitle  : string title
%  - xlabelStr    : x label text
%  - ylabelStr    : y label text
%  - saveResults  : boolean - save image if true
%  - showPlots    : boolean - show figure window if true
%  - outDir       : output folder for saving
%  - fileNameSuffix : optional suffix for file name (e.g. 'comparative_bar')
%
% Notes:
%  - This function ensures Times New Roman font and bold ticks/legend.

if nargin < 11
    fileNameSuffix = '';
end

% Normalize data shape
if isvector(data)
    data = data(:); % column vector
end

[nRows, nSeries] = size(data);

% If xVals is scalar or length mismatch, create default x
if isempty(xVals) || numel(xVals) ~= nRows
    xVals = (1:nRows)';
end

% Prepare figure (visible only if showPlots true)
if showPlots
    h = figure('Color','w');
else
    h = figure('Visible','off','Color','w');
end
ax = axes('Parent', h);
hold(ax,'on'); grid(ax,'on'); box(ax,'on');

% Plot
switch lower(plotType)
    case 'bar'
        % grouped bar if multiple series, single bar if single series
        b = bar(ax, xVals, data, 'grouped', 'LineWidth', 1);
        % improve bar appearance for single-series
        if nSeries == 1
            set(b, 'EdgeColor', 'k');
        end
    case 'line'
        colors = lines(nSeries);
        for s = 1:nSeries
            plot(ax, xVals, data(:,s), '-o', 'LineWidth', 1.6, 'MarkerSize',6);
        end
    otherwise
        error('plot_all: unknown plotType %s', plotType);
end

% Legends: if legendNames supplied, use them
try
    if ~isempty(legendNames)
        legend(ax, legendNames, 'Location','best', 'FontName','Times New Roman', 'FontWeight','bold');
    end
catch
    % ignore legend errors
end

% Labels and styling
title(ax, figureTitle, 'FontName','Times New Roman', 'FontWeight','bold');
xlabel(ax, xlabelStr, 'FontName','Times New Roman', 'FontWeight','bold');
ylabel(ax, ylabelStr, 'FontName','Times New Roman', 'FontWeight','bold');
set(ax, 'FontName','Times New Roman', 'FontWeight','bold', 'LineWidth', 1.2);
set(ax, 'XTick', xVals);

% Save file if requested
if saveResults
    if ~exist(outDir, 'dir'), mkdir(outDir); end
    cleanName = regexprep(figureTitle, '\W', '_');
    if isempty(fileNameSuffix)
        fileName = sprintf('%s.png', cleanName);
    else
        fileName = sprintf('%s_%s.png', cleanName, fileNameSuffix);
    end
    saveas(h, fullfile(outDir, fileName));
end

if ~showPlots
    close(h);
end

end
