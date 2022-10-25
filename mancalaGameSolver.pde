
Board game = new Board();
GameSpace gs = new GameSpace(0, 267, 66, 66, 0);
GameSpace gs2 = new GameSpace(534, 267, 66, 66, 0);
ArrayList<ArrayList<GameSpace>> boardUI = new ArrayList<ArrayList<GameSpace>>();

String infoText = "";


Boolean run = true;

void setup() {
  size(600,600);
  setupBoardUI();
}

void draw() {
  background(255);
  stroke(0);
  fill(255);
  rect(0, 0, 100, 100);
  fill(0);
  text(infoText, 0, 550);
  showBoardUI();
}

void mousePressed() {
  if (mouseX >= 0 && mouseX <= 100 && mouseY >= 0 && mouseY <= 100) {
    infoText = "";
    runBestMove();
  }
  
  if (mouseX > 69 && mouseX < 531) {
    //player 2 spot clicked
    if (mouseY > 234 && mouseY < 300) {
      findMovePlayed(1);
    } 
    //player 1 spot clicked
    else if (mouseY > 300 && mouseY < 366) {
      findMovePlayed(0);
    }
  }
}

void findMovePlayed(int player) {
  int move = 0;
  int constVal = 69;
  for (int i=0; i<8; i++) {
    if ((constVal+66*i)<mouseX && mouseX<(constVal+(66*(i+1)))) {
      if (player == 1) {
        move = 6-i;
      }else {
        move = i;
      }
      break;
    }
  }
  
  int gameState = game.move(move, player);
  if (gameState == 0) {
    infoText = "Move Finished";
  } else if (gameState == 1) {
    infoText = "Continue Your Turn";
  } else {
    infoText = "Not Valid Move";
  }
  updateBoardUI();
}

void runBestMove() {
  Solver solver = new Solver(game, 1, new MoveOutput(new ArrayList<Integer>(), 0, getPotential(1, game), getPotential(0, game)));
  ArrayList<MoveOutput> bestPossibleMove = solver.bestMove(0);
  
  bestPossibleMove.sort((x, y) -> (y.getScoreGained().compareTo(x.getScoreGained())));
  bestPossibleMove = removeLowScores(bestPossibleMove);
  bestPossibleMove.sort((x, y) -> (y.getSelfPotential().compareTo(x.getSelfPotential())));
  print("****************");
  for (int i=0; i<bestPossibleMove.size(); i++) {
    bestPossibleMove.get(i).printInfo();
  }
  print("****************");
  for (int i=0; i<bestPossibleMove.get(0).moves.size(); i++) {
    game.move(bestPossibleMove.get(0).moves.get(i), 0);
  }
  bestPossibleMove.get(0).printInfo();
  updateBoardUI();
}

void setupBoardUI() {
  boardUI.add(new ArrayList<GameSpace>());
  boardUI.add(new ArrayList<GameSpace>());
  for (int i=0; i<game.board.size(); i++) {
    for (int j=0; j<game.board.get(i).size(); j++) {
      if (j == 7) {
        if (i == 0) {
          boardUI.get(i).add(gs2);
        } else {
          boardUI.get(i).add(gs);
        }
      } else {
        if (i == 0) {
          boardUI.get(i).add(new GameSpace((69+66*j), 300, 66, 66, game.board.get(i).get(j)));
        } else {
          boardUI.get(i).add(new GameSpace((69+66*(6-j)), 234, 66, 66, game.board.get(i).get(j)));
        }
      }
    }
  }
}

void updateBoardUI() {
  for (int i=0; i<2; i++) {
    for (int j=0; j<8; j++) {
      boardUI.get(i).get(j).setValue(game.board.get(i).get(j));
    }
  }
}

void showBoardUI() {
  for (int i=0; i<2; i++) {
    for (int j=0; j<8; j++) {
      boardUI.get(i).get(j).show();
    }
  }
}

private int getPotential(int player, Board currentBoard) {
  int potential = 0;
  for (int i=0; i<7; i++) {
    potential += currentBoard.board.get(player).get(i);
  }
  return potential;
}

private ArrayList<MoveOutput> removeLowScores(ArrayList<MoveOutput> bestPossibleMove) {
  int highVal = bestPossibleMove.get(0).scoreGained;
  int startRemove = 0;
  for (int i=0; i<bestPossibleMove.size(); i++) {
    if (bestPossibleMove.get(i).scoreGained < highVal) {
      startRemove = i;
      break;
    }
  }
  for (int i=bestPossibleMove.size()-1; i>0; i--) {
    if (i >= startRemove) {
      bestPossibleMove.remove(i);
    }
  }
  return bestPossibleMove;
}
