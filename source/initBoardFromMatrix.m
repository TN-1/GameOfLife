function board = initBoardFromMatrix(board, seed)


% Place initial pattern into the board
for iRow = 1:size(seed, 1)
    for iColumn = 1:size(seed, 2)
        board(20 + iRow, 20 + iColumn) = seed(iRow, iColumn);
    end
end
end