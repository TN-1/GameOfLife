function board = updateBoard(board, seed)

% Iterate through all cells in the grid
for iRow = 2: mapSizeRows - 1
    for iColumn = 2: mapSizeCols - 1

        nAliveNeighbour = countAlivecells(board, iRow, iColumn);


        % Check cell status and then set B(i, j) to dead or alive.
        if board(iRow, iColumn) ~= 0
            if nAliveNeighbour < 2
                board(iRow, iColumn) = 0;
            elseif nAliveNeighbour == 2 || nAliveNeighbour == 3
                board(iRow, iColumn) = board(iRow, iColumn);
            elseif nAliveNeighbour > 3
                board(iRow, iColumn) = 0;
            end
        elseif nAliveNeighbour == 3
            board(iRow, iColumn) = 1;
        else
            board(iRow, iColumn) = 0;
        end

    end
end
end