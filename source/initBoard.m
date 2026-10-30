function board = initBoard(board, seed)

    if ischar(seed)
        board = initBoardFromChar(boar, seed);
    else
        board = initBoardFromMatrix(board, seed);
    end
end