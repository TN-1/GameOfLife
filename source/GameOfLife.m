% Game of Life in MatLab

%% Initialize Environment
% Clean up workspace to ensure a sane environment
clearvars;
close all;

%%% Define User Configurable Variables
mapSizeCols = 100;
mapSizeRows = 100;
simulationSpeed = 5; % 10 is getting laggy
seed = 0;%'3232188'; %3232188 is fun
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
isPaused = false;
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

currentBoard = initBoard(currentBoard, seed);

% Start game loop
while ~isPaused
    
    board = updateBoard(board, seed);

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

close all;
clearvars;

%% Functions
% Handles keypress for the figure window. YAY for events :)
function figureKeyPressHandler(~, event)
    global isPaused;

    switch(event.Key)
        case 'p'
            isPaused = ~isPaused;
    end
end
