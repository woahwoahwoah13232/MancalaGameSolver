class MoveOutput {
  int scoreGained;
  int opponentPotential;
  int selfPotential;
  ArrayList<Integer> moves = new ArrayList<Integer>();
  
  MoveOutput(ArrayList<Integer> x, int y, int op, int sp) {
      for (int i=0; i<x.size(); i++) {
        moves.add(x.get(i));
      }
      scoreGained = y;
      opponentPotential = op;
      selfPotential = sp;
  }
  
  public void printInfo() {
    print("\nMoves: ");
    for (int i=0; i<moves.size(); i++) {
      print(moves.get(i)+" ");
    }
    print("\nYour Potential: "+selfPotential);
    print("\nOpponents Potential: "+opponentPotential);
    print("\nScore: "+scoreGained);
    print("\n");
  }
  
  public Integer getScoreGained() {
    return scoreGained;
  }
  
  public Integer getSelfPotential() {
    return selfPotential;
  }
  
  private ArrayList<Integer> getList() {
    ArrayList<Integer> copyList = new ArrayList<Integer>();
    for (int i=0; i<moves.size(); i++) {
      copyList.add(moves.get(i));
    }
    return copyList;
  }
}
