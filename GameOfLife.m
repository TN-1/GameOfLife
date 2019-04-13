% This script is a simple version of Conway's Game of Life

% TODO items:
% Seeds and seed strings!
% Factions
% Finer user control and settings. Getting there, still need more and need
% to expose them to the user`
% GFX! 80% done, Just need to clean up figure window and add buttons

%%%%% Define User Configurable Variables
% For now assume a 100x100 play area (Usable 98x98)
mapSizeCols = 100;
mapSizeRows = 100;
simulationSpeed = 20;
consoleOutput = false;
global isPaused;
isPaused = false;

%%%%% Define Game Mode variables
currentBoard = zeros(mapSizeRows, mapSizeCols);
newBoard = zeros(mapSizeRows, mapSizeCols);
CurrentTurn = 0;
mainFig = figure('Name','Game of Life', 'WindowState', 'maximized');
set(mainFig, 'KeyPressFcn', @figureKeyPressHandler);


% Add a map seed
for i = [1:5]
    for j = [1:5]
        currentBoard(i,j) = 1;
    end
end

while 1
    % Start game loop
    while ~isPaused
        % Iterate through all cells in the grid
        for i = [2: mapSizeRows - 1]
            for j = [2: mapSizeCols - 1]
                % Now we are at the cell to check
                AliveCells = 0;

                % Next nested loop is the border squares to check
                for k = [-1:1]
                    for l = [-1:1]
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
                % Check cell status and then set B(i,j) to dead or alive.

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
        if consoleOutput == true
            % Print new board to the command window
            clc;
            for i = [2: 19]
                rowToPrint = "";
                for j = [2:99]
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
        spy(currentBoard);
        pause(.5 / simulationSpeed);
    end
end

function figureKeyPressHandler(src, event)
    global isPaused;
    
    switch(event.Key)
        case 'p'
            isPaused = ~isPaused;
        case 'c'
            quit cancel;
    end
end