class LeaderBoard {
  private String[] leaderBoard;
  private String[] currentScore1, currentScore2;
  private String temp;
  
  public LeaderBoard() {
    leaderBoard = loadStrings("data/scores.txt"); // load leaderboard if file exists OR ->
    if (leaderBoard == null) { // initialize a new text file to a number of empty rows for the length of scores list + 1 (for the new value) if file doesn't exist
        PrintWriter board = createWriter("data/scores.txt");
        for (int i = 0; i < 6; i++) {
          board.println("");
        }
        board.flush();
        board.close();
        leaderBoard = loadStrings("data/scores.txt"); // load the new file
    }
  }
  
  public void addScore(int highScore) {
    String name = window.prompt("Enter name: ");
    leaderBoard[5] = name + ": " + str(highScore); // add value to the 6th position to be sorted (only top 5 are displayed)
  }
  
  // bubble sort high scores based on score in descending order
  private void sortList() {
    for (int i = 0; i < leaderBoard.length; i++) {
      for (int j = 1; j < leaderBoard.length; j++) {
        if (leaderBoard[j-1].equals("")) {
          temp = leaderBoard[j-1];
          leaderBoard[j-1] = leaderBoard[j];
          leaderBoard[j] = temp;
        }
        if (!(leaderBoard[j].equals("") || leaderBoard[j-1].equals(""))) {
          currentScore1 = split(leaderBoard[j], ": ");
          currentScore2 = split(leaderBoard[j - 1], ": ");
          if (int(currentScore2[1]) < int(currentScore1[1])) {
            temp = leaderBoard[j-1];
            leaderBoard[j-1] = leaderBoard[j];
            leaderBoard[j] = temp;
          }
        }
      }
    }
  }
  
  private void saveScores () {
    saveStrings("data/scores.txt", leaderBoard);
  }
  
  public void updateScores() {
    sortList();
    saveScores();
  }
  
  public void printLeaderBoard() {
    float yPos = height/6;
    float xPos = width/3;
    textAlign(LEFT);
    rectMode(CORNER);
    fill(99, 58, 55);
    textSize(20);
    text("Top 5 High Scores", xPos, yPos);
    for (int i = 0; i < leaderBoard.length-1; i++) {
      text(leaderBoard[i], xPos, yPos+30, 300, 30);
      yPos += 35;
    }
  }
  
}
