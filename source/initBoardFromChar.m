function board = initBoardFromChar(board, seed)


    if ~mod(length(seed), 7) == 0
        error("Seed string is wrong length. Expect multiple of 7\n");
    end
    
    for iEach7thChar = 1:7:length(seed)
        originX = (hex2dec(seed(iEach7thChar)) * 16) + hex2dec(seed(iEach7thChar + 1));
        originY = (hex2dec(seed(iEach7thChar + 2)) * 16) + hex2dec(seed(iEach7thChar + 3));
        type = seed(iEach7thChar + 4);
        sizeX = hex2dec(seed(iEach7thChar + 5));
        sizeY = hex2dec(seed(iEach7thChar + 6));
    
        for iRow = originY: (originY + sizeY)
            for iColumn = originX: (originX + sizeX)
                board(iRow, iColumn) = hex2dec(type);
            end
        end
    end

end