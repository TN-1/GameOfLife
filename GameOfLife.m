% This script is a simple version of Conway's Game of Life

% TODO items:
% Factions

% Clean up workspace to ensure a sane environment
clearvars;
close all;

%%%%% Define User Configurable Variables
global isPaused;
isPaused = false;
mapSizeCols = 256;
mapSizeRows = 256;
simulationSpeed = 5; % 10 is getting laggy
consoleOutput = false;
seedString = '405115A28013FA48013FA';

%%%%% Define Game Mode variables
currentBoard = zeros(mapSizeRows, mapSizeCols);
newBoard = zeros(mapSizeRows, mapSizeCols);
CurrentTurn = 0;
mainFig = figure('Name','Game of Life',...
    'WindowState', 'maximized',...
    'MenuBar', 'none',...
    'ToolBar', 'none',...
    'DockControls', 'off'...
);
set(mainFig, 'KeyPressFcn', @figureKeyPressHandler);


% Seed the map
if ~mod(length(seedString), 7) == 0
    fprintf("Seed string is wrong length. Expect multiple of 7\n");
    close all;
    return;
end

for i = 1:7:length(seedString)
    originX = (hex2dec(seedString(i)) * 16) + hex2dec(seedString(i + 2));
    originY = (hex2dec(seedString(i + 1)) * 16) + hex2dec(seedString(i + 3));
    type = seedString(i + 4);
    sizeX = hex2dec(seedString(i + 5));
    sizeY = hex2dec(seedString(i + 6));
    
    for j = originY: originY + sizeY
        for k = originX: originX + sizeX
            currentBoard(j, k) = hex2dec(type);
        end
    end
end

%return;

% Start game loop
while ~isPaused   
    % Iterate through all cells in the grid
    for i = 2: mapSizeRows - 1
        for j = 2: mapSizeCols - 1
            % Now we are at the cell to check
            AliveCells = 0;
            if currentBoard(i, j) == 3
                newBoard(i, j) = 3;
                continue
            end

            % Next nested loop is the border squares to check
            for k = -1:1
                for l = -1:1
                    if k == 0 && l == 0
                        % If we are on the current cell (i,j), ignore it from
                        % the search
                        continue;
                    end

                    % Is this cell dead or alive?
                    if currentBoard(i + k, j + l) == 1
                        AliveCells = AliveCells + 1;
                    end
                end
            end
            % Check cell status and then set B(i, j) to dead or alive.

            if AliveCells < 2
                newBoard(i, j) = 0;
            elseif AliveCells == 2 || AliveCells == 3
                newBoard(i, j) = 1;
            elseif AliveCells > 3
                newBoard(i, j) = 0;
            elseif currentBoard(i, j) == 0 && AliveCells == 3
                newBoard(i, j) = 1;
            end
        end 
    end

    % Check if we are configured for console output
    %%% TODO: Needs to be reworked for variable board size
    if consoleOutput == true
        % Print new board to the command window
        clc;
        for i = 2:19
            rowToPrint = "";
            for j = 2:99
                rowToPrint = strcat(rowToPrint, num2str(newBoard(i,j)));
            end
            fprintf(rowToPrint + "\n");
        end

        fprintf("Current turn: %d\n", CurrentTurn);
    end

    % Copy new board to old board, reset new board, output the new board to the figure and go to next turn
    currentBoard = newBoard;
    newBoard = zeros(mapSizeRows, mapSizeCols);
    CurrentTurn = CurrentTurn + 1;
    clf;
    cspy(currentBoard);
    colorbar('off');
    pause(.5 / simulationSpeed);
end
    
% Handles keypress for the figure window. YAY for events :)
function figureKeyPressHandler(~, event)
    global isPaused;
    
    switch(event.Key)
        case 'c'
            isPaused = ~isPaused;
            close all;
    end
end     