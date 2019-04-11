% This script is a simple version of Conway's Game of Life

% For now assume a 20x100 play area (Usable 28x98)
% A is the current state to be assesed, B is the next turn.
A = zeros(20, 100);
B = zeros(20, 100);
CurrentTurn = 0;

% Add a map seed
for i = [1:5]
    for j = [1:5]
        A(i,j) = 1;
    end
end

% Lock the game loop on, eventually this will be a toggle
while 1
    % Iterate through all cells in the grid
    for i = [2: 19]
        for j = [2:99]
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
                    if A(i + k, j + l) == 1
                        AliveCells = AliveCells + 1;
                    end
                end
            end
            % Check cell status and then set B(i,j) to dead or alive.
            
            if AliveCells < 2
                B(i, j) = 0;
            elseif AliveCells == 2 || AliveCells == 3
                B(i, j) = 1;
            elseif AliveCells > 3
                B(i, j) = 0;
            elseif A(i, j) == 0 && AliveCells == 3
                B(i, j) = 1;
            end
        end 
    end
    
    % Print new board to the command window
    clc;
    for i = [2: 19]
        rowToPrint = "";
        for j = [2:99]
            rowToPrint = strcat(rowToPrint, num2str(B(i,j)));
        end
        fprintf(rowToPrint + "\n");
    end
    
    fprintf("Current turn: %d\n", CurrentTurn);
    % Copy new board to old board, reset new board and go to next turn
    A = B;
    B = zeros(20,100);
    CurrentTurn = CurrentTurn + 1;
    pause(.5);
end