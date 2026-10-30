function nAlive = countAlivecells(board, iNeighbourRow, iColumn)

    
    % Now we are at the cell to check
    nAlive = 0;
    for iNeighbourRow = -1:1
        for iNeighbourColumn = -1:1
            if iNeighbourRow == 0 && iNeighbourColumn == 0
                % If we are on the current cell (i,j), ignore it from
                % the search
                continue;
            end
    
            % Is this cell dead or alive?
            if board(iNeighbourRow + iNeighbourRow, iColumn + iNeighbourColumn) ~= 0
                nAlive = nAlive + 1;
            end
        end
    end

end