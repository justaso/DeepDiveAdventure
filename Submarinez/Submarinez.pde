/*************************************************************** 
GAME ASSETS DOWNLOADED FROM: https://opengameart.org/content/sea-and-underwater-assets

Copyright/Attribution Notice: 
https://www.patreon.com/fethalis

***************************************************************/


import java.util.ArrayList;

private float playTextX, playTextY; // x and y coordinates of Play button (used for other buttons as well for the x coordinate)
private float leaderboardButtonY; // leaderboard button Y coordinate (playTextX for x coord)
private float backButtonY; // back button Y coordinate (playTextX for x coord)
private float textBoxWidth, textBoxHeight; // width and height of menu buttons
private PImage background;
private int y; // y position of background
private int gameMode; 

private Submarine player;
private Health healthBar;
private LeaderBoard board;
private int playerLives; // player lives (initialized to 10)
private float targetX, targetY; // variables used by Narwhal objects to constantly move towards the player
private ArrayList<Obstacle> obstacleList;

// buttons hover effect variables - TRUE if hovered over
private boolean playHover;
private boolean leaderboardHover;
private boolean backHover; 

private boolean startGame; // for display of either PLAY or PLAY AGAIN menu buttons (set to TRUE initially to display "PLAY")
private boolean gameEnded; // to trigger end of game methods

private int animation; // 1 for explosion and 2 for health increase
private int score; // score of player collected air (HealthPoint)
private int scoreInc; // score increment for each HealthPoint collected
private LeaderBoard leaderBoard; // leader board (opens existing file OR creates new file if it doesn't exist)
private int time; // level time, increments in draw (60 = 1sec) (changeLevel(gameMode) function controls it)
private int currentLevel; // current level (initiated at 1 to display level numbers starting from 1)
private int levelTextTime; // timing of text displayed announcing each level (60 = 1sec), increments in draw(), resets before each level; adjust in gameMode 4
private boolean displayLevel; // true to display level, false otherwise (used in gameMode 2 to display current level announcement)



public void setup() {
  size(600, 1000);
  playTextX = width/2.6;
  playTextY = height*0.3;
  leaderboardButtonY = playTextY+40;
  backButtonY = height*0.7;
  textBoxWidth = 150;
  textBoxHeight = 30;
  gameMode = 1;
  gameEnded = false;
  startGame = true;
  displayLevel = true;
  y = 0;
  score = 0;
  scoreInc = 20;
  currentLevel = 1;
  levelTextTime = 0;
  background = loadImage("img//background/bg3.png");
  background.resize(width, height);
  player = new Submarine(width/2, height-height*0.85, 5);
  playerLives = 10;
  healthBar = new Health(playerLives);
  leaderBoard = new LeaderBoard();
  
  // creation and initial population of obstacle list
  obstacleList = new ArrayList<Obstacle>();
  
  for (int i = 0; i < 2; i++) {
    populateObsList(1, 4);
  }
}

public void draw() {
  // level gameplay and level announcement timers
  time += 1;
  levelTextTime += 1;
  
  // draw background
  if (gameMode == 0 || gameMode == 3 || gameMode == 4) {
    drawBackground();
  }
  
  // draw health bar
  healthBar.update();
  
  // draw score
  displayScore(score);
  
  
  switch (gameMode) {
    case 0: // gameMode for collision (explosion and healthIncrease)
    
      // collision animations
      
      // animate depending on whether it's an explosion or healthIncrease
      animateCollision(animation);
  
      // update player and other objects whilst animation is happening
      if (player != null) {
        player.update();
      }
      
      updateObstacles();
      
      // terminate animation and return to gameplay
      if (player.getExplosionSize() == 0 && player.getHealthIncreaseSize() == 200) {
        gameMode = 3;
        animation = 0;
      }
      
      break; // CASE 0 BREAK //<>//
      
      
    case 1: // gameMode for menus
      
      // draw still background
      image(background, 0, y); // draw background twice adjacent
      image(background, 0, y+background.height);
      
      // reset time before each level
      time = 0; 
      
      // draw game menus (either new game or restart game)
      drawMenus();
      
      // menu buttons mouse hover animation
      updateHover();
      
      // if game has ended, add new score, sort Top 5 scores list, and update file
      if (gameEnded) {
        leaderBoard.addScore(score);
        leaderBoard.updateScores();
        gameEnded = false;
        startGame = false;
      }
      
      break; // CASE 1 BREAK
      
      
    case 2: // gameMode for changing game levels
      // announce game level
      if (displayLevel) {
        levelTextTime = 0;
        gameMode = 4;
        break; // CASE 2 BREAK - announce level
      }
      
      // repopulate obstacles depending on level
      if (currentLevel == 2) {
        obstacleList.clear();
        for (int i = 0; i < 2; i++) {
          populateObsList(1, 6);
        }
      } else if (currentLevel == 3) {
        obstacleList.clear();
        for (int i = 0; i < 3; i++) {
          populateObsList(1, 6);
        }
      } else if (currentLevel == 4) {
        obstacleList.clear();
        for (int i = 0; i < 3; i++) {
          populateObsList(1, 8);
        }
      }
    
      gameMode = 3; // changes gameMode to gameplay
      displayLevel = true;
      
      break; // CASE 2 BREAK
    
    
    case 3: // gameMode playing (gameplay)
      // update obstacles
      updateObstacles();
    
      // update player
      player.update();
    
      //// check for collision with obstacles
      checkObsCollision();
      
      // if on last level, change gameMode to display menus and take user name after finished
      if (currentLevel == 4) {
        gameEnded = true;
        changeLevel(1); // change to gameMode 1
      } else {
        changeLevel(2); // change to gameMode 2
      }

      break; // CASE 3 BREAK
      
      
    case 4: // gameMode for announcing levels (Level 1, Level 2, etc)
      displayLevel();
      
      if (levelTextTime > 180) { // 60 - 1sec
        displayLevel = false;
        gameMode = 2;
        break;
      }
      
      break; // CASE 4 BREAK
      
      
    case 5: // gameMode for print leaderBoard
      image(background, 0, y); // draw background twice adjacent
      image(background, 0, y+background.height);
      leaderBoard.printLeaderBoard();
      drawBackButton();
      updateHover();
      
      break; // CASE 5 BREAK
  }
}


// key press listener
public void keyPressed() {
  player.setMove(keyCode, true);
}


// key release listener
public void keyReleased() {
  player.setMove(keyCode, false);
}


// check for mouse hover
public boolean rectHover(float x, float y, float w, float h) { // x, y, width, height
  if (mouseX >= x && mouseX <= x+w && 
      mouseY >= y && mouseY <= y+h) {
    return true;
  } else {
    return false;
  }
}


// check which menu item mouse hovers over
public void updateHover() {
  if ( rectHover(playTextX, playTextY, textBoxWidth, textBoxHeight) ) {
    playHover = true;
  } else {
    playHover = false;
  }
  
  if ( rectHover(playTextX, leaderboardButtonY, textBoxWidth, textBoxHeight) ) {
    leaderboardHover = true;
  } else {
    leaderboardHover = false;
  }
  
  if ( rectHover(playTextX, backButtonY, textBoxWidth, textBoxHeight) ) {
    backHover = true;
  } else {
    backHover = false;
  }
  
}


// listen for mouse presses on menu items
public void mousePressed() {
  if (playHover) {
    setup();
    gameMode = 2; // start new game
  }
  
  if (leaderboardHover) {
    gameMode = 5; // print leaderBoard
  }
  
  if (backHover) {
    gameMode = 1; // display menu
  }
}


// populate obstacle list
public void populateObsList (float lower, float upper) { // obstacle speed lower and upper bounds (generate random speeds)
    Medusa tempMed = new Medusa(random(-1.5, 1.5), random(lower, upper));
    Narwhal tempNar = new Narwhal(random(lower, upper));
    Boat tempBoat = new Boat(random(lower, upper));
    HealthPoints tempHealthPts = new HealthPoints(random(lower, upper));
    
    obstacleList.add(tempMed);
    obstacleList.add(tempNar);
    obstacleList.add(tempBoat);
    obstacleList.add(tempHealthPts);
}


// display score on screen whilst playing
public void displayScore(int score) {
  textAlign(LEFT, TOP);
    rectMode(CORNER);
    textSize(30);
    text("Score: " + str(score), 20, 20);
}


// animate background
public void drawBackground() {
  image(background, 0, y); // draw background twice adjacent
  image(background, 0, y+background.height);
  
  y -= 4; // move background down
  
  // reset background image when end of first image is reached
  if (y == -background.height) {
    y = 0;
  }
}


// update obstacles
public void updateObstacles() {
  for (int i=0; i<obstacleList.size(); i++) {
  Obstacle temp = obstacleList.get(i);
  if (temp instanceof Medusa) {
    ((Medusa)temp).update();
  } else if (temp instanceof Narwhal) {
    // move Narwhal towards player
    targetX = temp.calculateTargetX(player);
    targetY = temp.calculateTargetY(player);
    ((Narwhal)temp).update(targetX, targetY);
  } else if (temp instanceof Boat) {
    ((Boat)temp).update();
  } else if (temp instanceof HealthPoints) {
    ((HealthPoints)temp).update();
    }
  }
}


// check for collision with obstacles
public void checkObsCollision() {
  for (int i=0; i<obstacleList.size(); i++) {
    Obstacle temp = obstacleList.get(i);
    
    if (player.isHit(temp, temp.getObWidth(), temp.getObHeight())) {
      // if the obstacle is hit, restore obstacle at the bottom of screen
      temp.setY(height);
      temp.setX(random(temp.getObWidth(), width-temp.getObWidth()));
      // if the obstacle is healthPoints, increase lives
      if (!(temp instanceof HealthPoints)) {
        healthBar.decreaseLives(1);
        animation = 1; // animate for obstacle hit
        gameMode = 0;
      } else if (temp instanceof HealthPoints) {
        healthBar.increaseLives(1);
        score += 20;
        animation = 2; // animate for health increase
        gameMode = 0;
      }
      
      // restrict healthBar to 10
      if (healthBar.getPlayerLives() > 10) {
        healthBar.setPlayerLives(10);
      }
      
      
      // stop game if player runs out of lives
      if (healthBar.getPlayerLives() < 1) {
        gameMode = 1;
        gameEnded = true;
        startGame = false; // for display of 'PLAY AGAIN' instead of 'PLAY'
        break;
      }
    }
  }
}


// animate collisions based on whether it's health increase or obstacle explosion
public void animateCollision(int animation) {
  if (animation == 1) {
    strokeWeight(2);
    stroke(0);
    player.explosion();
  } else if (animation == 2) {
    strokeWeight(4);
    stroke(163, 200, 217);
    player.healthIncrease(20);
  }
  
}


// draw menu on start or end game
public void drawMenus() {
  image(background, 0, y);
  fill(242, 242, 247);
  textAlign(CENTER, CENTER);
  rectMode(CORNER);
  textSize(30);
  text("DEEP DIVE ADVENTURE", width/7, 50, textBoxWidth*3, textBoxHeight*1.5); // draw game title
  
  
  // display 'PLAY' button, coloured based on its hover state
  if (playHover) {
    fill(174, 174, 181);
  } else {
    fill(242, 242, 247);
  }
  
  
  textSize(20); // NOTE: if text is larger than its box - it won't be displayed
  
  
  // show 'PLAY' initially and then 'PLAY AGAIN' on subsequent runs
  if (startGame) {
    text("PLAY", playTextX, playTextY, textBoxWidth, textBoxHeight); // draw rectangular box PLAY
  } else {
    text("PLAY AGAIN", playTextX, playTextY, textBoxWidth, textBoxHeight); // draw rectangular box PLAY slightly below GAME OVER
  }
  
  // display 'LEADERBOARD' button, coloured based on its hover state
  if (leaderboardHover) {
    fill(174, 174, 181);
  } else {
    fill(242, 242, 247);
  }
  
  text("LEADERBOARD", playTextX, leaderboardButtonY, textBoxWidth, textBoxHeight);
  
}


public void drawBackButton() {
  textSize(20); // NOTE: if text is larger than its box - it won't be displayed
  
  // display 'BACK' button, coloured based on its hover state
  if (backHover) {
    fill(174, 174, 181);
  } else {
    fill(242, 242, 247);
  }
  
  text("BACK", playTextX, backButtonY, textBoxWidth, textBoxHeight);
}


// change game levels after time 'duration' (60 = 1sec), use gameMode 2 to perform the switch
public void changeLevel(int gameMode) {
  int levelDuration = 600; // 25sec level duration
  if (time >= levelDuration) {
    time = 0;
    this.gameMode = gameMode;
    currentLevel += 1;
  }
}


// display current level announcement
public void displayLevel() {
  fill(163, 8, 21);
  textSize(25);
  text("LEVEL " + str(currentLevel), playTextX, playTextY-(height*0.07), textBoxWidth, textBoxHeight); // draw GAME LEVEL in middle of screen
}
