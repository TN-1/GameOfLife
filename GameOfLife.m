% This script is a simple version of Conway's Game of Life

% For now assume a 100x100 play area (Usable 98x98)
% A is the current state to be assesed, B is the next turn.
A = zero(100, 100);
B = zero(100, 100);
CurrentTurn = 0;

% Lock the game loop on, eventually this will be a toggle
while 1
    % Iterate through all cells in the grid
    for i = [2: 99]
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
    % Copy new board to old board, reset new board and go to next turn
    A = B;
    B = zero(100,100);
    CurrentTurn = CurrentTurn + 1;
end
