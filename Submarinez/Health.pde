class Health {
  private float x, y;
  private int playerLives;
  
  public Health (int playerLives) {
    this.x = width-220;
    this.y = 20;
    this.playerLives = playerLives;
  }
  
  public void update() {
    rectMode(CORNER);
    strokeWeight(1);
    fill(163, 200, 217);
    noStroke();
    rect(x, y, playerLives*20, 20, 5);
    noFill();
    stroke(0);
    rect(x, y, 200, 20, 5);
  }
  
  public void decreaseLives(int l) {
    playerLives -= l;
  }
  
  public void increaseLives(int l) {
    playerLives += 1;
  }
  
  public int getPlayerLives() {
    return playerLives;
  }
  
  public void setPlayerLives(int lives) {
    this.playerLives = lives;
  }
}
