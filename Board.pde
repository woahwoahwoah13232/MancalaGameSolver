class Board {
  public ArrayList<ArrayList<Integer>> board = new ArrayList<ArrayList<Integer>>();
  
  Board(ArrayList<ArrayList<Integer>> gameBoard) {
    copyBoard(gameBoard);
  }
  
  Board() {
    fillInBoard();
  }
  
  private void copyBoard(ArrayList<ArrayList<Integer>> gameBoard) {
    board.add(new ArrayList<Integer>());
    board.add(new ArrayList<Integer>());
    
    for (int i=0; i<gameBoard.size(); i++) {
      for (int j=0; j<8; j++) {
        board.get(i).add(gameBoard.get(i).get(j));
      }
    }
  }
  
  private void fillInBoard() {
    board.add(new ArrayList<Integer>());
    board.add(new ArrayList<Integer>());
    
    for (int i = 0; i < board.size(); i++) {
      for (int j = 0; j < 8; j++) {
        if (j < 7) {
          board.get(i).add(4);
        } else {
          board.get(i).add(0);
        }
      }
    }
  }
  
  public int move(int x, int player) {
    int stock = board.get(player).get(x);
    board.get(player).set(x, 0);
    int boardSide = player;
    if (stock == 0) {
      return 2;
    }
    
    for(int i=++x;i<8;i++) {
      if (stock == 0) {
        return 1;
      }
      
      if (i == 7 && boardSide == player) {
        //Point scored For Player and Change BoardSide
        int currentWell = board.get(boardSide).get(i);
        board.get(boardSide).set(i, ++currentWell);
        stock--;
        boardSide = boardSideChange(boardSide);
        i = -1;
      } else if (i == 7 && boardSide != player) {
        //Skip Well For Player and Change BoardSide
        boardSide = boardSideChange(boardSide);
        i = -1;
      } else {
        //Normal Well For Player
        if (stock > 1) {
          //Continue
          int currentWell = board.get(boardSide).get(i);
          board.get(boardSide).set(i, ++currentWell);
          stock--;
        } else {
          //Check for move continuation
          int currentWell = board.get(boardSide).get(i);
          if (currentWell == 0) {
            board.get(boardSide).set(i, 1);
            stock = 0;
            return 0;
          } else {
            board.get(boardSide).set(i, 0);
            stock = ++currentWell;
          }
        }
      }
    }
    
    return 0;
  }
  
  private int boardSideChange(int boardSide) {
    if(boardSide == 0) {
      return 1;
    } else {
      return 0;
    }
  }
}
