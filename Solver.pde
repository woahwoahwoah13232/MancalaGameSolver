class Solver {
  private Board board;
  private int depth;
  private MoveOutput moveOutput;
  private ArrayList<MoveOutput> bestMoves = new ArrayList<MoveOutput>();

  Solver(Board x, int y, MoveOutput m) {
    board = x;
    depth = y;
    moveOutput = m;
  }
  
  public void printBestMoves() {
    for (int i=0; i<bestMoves.size(); i++) {
      bestMoves.get(i).printInfo();
    }
  }
  
  public ArrayList<MoveOutput> bestMove(int player) {
    
    for(int i=0; i<7; i++) {
      Board testBoard = new Board(board.board);
      int returnVal = testBoard.move(i, player);
      if (returnVal == 1) {
        int scoreFromMove = getScore(player, testBoard);
        ArrayList<Integer> list = moveOutput.getList();
        list.add(i);
        
        MoveOutput move = new MoveOutput(list, scoreFromMove, getPotential(getOpponent(player), testBoard), getPotential(player, testBoard));
        Solver newSolver = new Solver(testBoard, ++depth, move);
        bestMoves.addAll(newSolver.bestMove(player));
      } else if (returnVal == 2) {
        
      } else {
        int scoreFromMove = getScore(player, testBoard);
        ArrayList<Integer> list = moveOutput.getList();
        list.add(i);
        MoveOutput finalMove = new MoveOutput(list, scoreFromMove, getPotential(getOpponent(player), testBoard), getPotential(player, testBoard));
        bestMoves.add(finalMove);
        /*print("\n\n****************");
        for (int j=0; j<bestMoves.size(); j++) {
          bestMoves.get(j).printInfo();
        }
        print("\n\n****************");*/
        
        /*print("\n\n****************");
        for (int j=0; j<bestMoves.size(); j++) {
          bestMoves.get(j).printInfo();
        }
        print("\n\n****************");*/
      }
    }
    
    return bestMoves;
  }
  
  private int getScore(int player, Board currentCheck) {
    return currentCheck.board.get(player).get(7);
  }
  
  private int getPotential(int player, Board currentBoard) {
    int potential = 0;
    for (int i=0; i<7; i++) {
      potential += currentBoard.board.get(player).get(i);
    }
    return potential;
  }
  
  private int getOpponent(int player) {
    if (player == 0) {
      return 1;
    } else {
      return 0;
    }
  }
  
  private void removeLowScores() {
    int highVal = bestMoves.get(0).scoreGained;
    
    for (int i=0; i<bestMoves.size(); i++) {
      if (bestMoves.get(i).scoreGained < highVal) {
        
        bestMoves.remove(i);
        removeLowScores();
        return;
      }
    }
  }
}
