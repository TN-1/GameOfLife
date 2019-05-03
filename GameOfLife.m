% Game of Life in MatLab

%% Initialize Environment
% Clean up workspace to ensure a sane environment
clearvars;
close all;

%%% Define User Configurable Variables
mapSizeCols = 100;
mapSizeRows = 100;
simulationSpeed = 5; % 10 is getting laggy
seedString = 0;%'3232188'; %3232188 is fun
seedVect = [1 1 0 0 0 1 1;
            0 1 0 0 0 1 0;
            0 0 0 1 0 0 0;
            0 0 1 0 0 0 0;
            0 0 0 1 0 0 0;
            0 1 0 0 0 1 0;
            1 1 0 0 0 1 1];
constSeed = true;

%%% Define Game Mode variables
global isPaused;
global isActive;
isPaused = false;
isActive = true;
currentBoard = zeros(mapSizeRows, mapSizeCols);
newBoard = zeros(mapSizeRows, mapSizeCols);
seedBoard = zeros(mapSizeRows, mapSizeCols);
CurrentTurn = 0;
mainFig = figure('Name','Game of Life',...
    'WindowState', 'maximized',...
    'MenuBar', 'none',...
    'ToolBar', 'none',...
    'DockControls', 'off'...
    );
set(mainFig, 'KeyPressFcn', @figureKeyPressHandler);

%% Start Game Mode
% Seed the map
if seedString ~= 0 
    if ~mod(length(seedString), 7) == 0
        fprintf("Seed string is wrong length. Expect multiple of 7\n");
        close all;
        return;
    end

    for i = 1:7:length(seedString)
        originX = (hex2dec(seedString(i)) * 16) + hex2dec(seedString(i + 1));
        originY = (hex2dec(seedString(i + 2)) * 16) + hex2dec(seedString(i + 3));
        type = seedString(i + 4);
        sizeX = hex2dec(seedString(i + 5));
        sizeY = hex2dec(seedString(i + 6));

        for j = originY: originY + sizeY
            for k = originX: originX + sizeX
                currentBoard(j, k) = hex2dec(type);
            end
        end
    end
else
    % Place initial pattern into the board
    for i = 1:size(seedVect, 1)
        for j = 1:size(seedVect, 2)
            currentBoard(20 + i, 20 + j) = seedVect(i, j);
        end
    end
end
seedBoard = currentBoard;

% Start game loop
while isActive
    while ~isPaused
        % Iterate through all cells in the grid
        for i = 2: mapSizeRows - 1
            for j = 2: mapSizeCols - 1
                % Now we are at the cell to check
                AliveCells = 0;
                for k = -1:1
                    for l = -1:1
                        if k == 0 && l == 0
                            % If we are on the current cell (i,j), ignore it from
                            % the search
                            continue;
                        end
                        
                        % Is this cell dead or alive?
                        if currentBoard(i + k, j + l) ~= 0
                            AliveCells = AliveCells + 1;
                        end
                    end
                end
                
                % Check cell status and then set B(i, j) to dead or alive.
                if currentBoard(i, j) ~= 0
                    if AliveCells < 2
                        newBoard(i, j) = 0;
                    elseif AliveCells == 2 || AliveCells == 3
                        newBoard(i, j) = currentBoard(i, j);
                    elseif AliveCells > 3
                        newBoard(i, j) = 0;
                    end
                elseif AliveCells == 3
                    newBoard(i, j) = 1;
                else
                    newBoard(i, j) = 0;
                end
                
            end
        end
        
        % Copy new board to old board, reset new board, output the new board to the figure and go to next turn
        if constSeed == true
            currentBoard = newBoard | seedBoard;
        else
            currentBoard = newBoard;
        end
        newBoard = zeros(mapSizeRows, mapSizeCols);
        CurrentTurn = CurrentTurn + 1;
        clf;
        spy(currentBoard);
        pause(.5 / simulationSpeed);
    end
end

%% Functions
% Handles keypress for the figure window. YAY for events :)
function figureKeyPressHandler(~, event)
    global isPaused;
    global isActive;
    
    switch(event.Key)
        case 'p'
            isPaused = ~isPaused;
        case 'c'
            isActive = false;
            close all;
    end
end