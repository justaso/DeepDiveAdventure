class Submarine {
  private float x, y, speed, explosionSize, healthIncreaseSize;
  private boolean leftDir, rightDir, up, down, left, right;
  private PImage Rsub1, Rsub2, Rsub3, Rsub4, Lsub1, Lsub2, Lsub3, Lsub4;
  private int counter = 0;
  private final float subWidth, subHeight;
  
  
  // Constructor
  public Submarine (float x, float y, int speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.leftDir = false; // submarine facing left
    this.rightDir = true; // submarine facing right
    this.subWidth = width/7; // submarine width 1/7 of screen width
    this.subHeight = height/14; // submarine height 1/14 of screen height
    this.Rsub1 = loadImage("img/sub/Rsb1.png");
    this.Rsub2 = loadImage("img/sub/Rsb2.png");
    this.Rsub3 = loadImage("img/sub/Rsb3.png");
    this.Rsub4 = loadImage("img/sub/Rsb4.png");
    this.Lsub1 = loadImage("img/sub/Lsb1.png");
    this.Lsub2 = loadImage("img/sub/Lsb2.png");
    this.Lsub3 = loadImage("img/sub/Lsb3.png");
    this.Lsub4 = loadImage("img/sub/Lsb4.png");
    this.explosionSize = 0;
    this.healthIncreaseSize = 200;
  }
  
  
  // render submarine based on direction its facing
  private void render () {
    if (leftDir) {
      animateSub(Lsub1, Lsub2, Lsub3, Lsub4);
    } else if (rightDir) {
      animateSub(Rsub1, Rsub2, Rsub3, Rsub4);
    }
    
  }
  
  
  // animate submarine, display each sprite for 15 seconds in draw()
  private void animateSub (PImage sub1, PImage sub2, PImage sub3, PImage sub4) {
    if (counter >= 0 && counter <= 15) {
      image(sub1, x, y, subWidth, subHeight);
    } else if (counter > 15 && counter <= 30) {
      image(sub2, x, y, subWidth, subHeight);
    } else if (counter > 30 && counter <= 45) {
      image(sub3, x, y, subWidth, subHeight);
    } else if (counter > 45 && counter <= 60) {
      image(sub4, x, y, subWidth, subHeight);
    } else {
      image(sub1, x, y, subWidth, subHeight);
      counter = 0;
    }
    
    counter += 1;
  }
  
  
  // accepts keyCode as argument k, and a boolean b to enable or disable movements
  public boolean setMove(int k, boolean b) {
    switch (k) {
      case UP:
        return up = b;
        
      case DOWN:
        return down = b;
        
      case LEFT:
        return left = b;
        
      case RIGHT:
        return right = b;
        
      default:
        return b;
    }
  }
  
  
  // moves player based on which value (up, down, right, left) is true
  private void move() {
    if (down) {
      if (y < height/2) {
        y += speed;
      }
    }
    if (up) {
      if (y > 0) {
        y -= speed;
      }
    }
    if (left) {
      if (x > 0) {
        leftDir = true;
        rightDir = false;
        x -= speed;
      }
    }
    if (right) {
      if (x < width-subWidth) {
        rightDir = true;
        leftDir = false;
        x += speed; 
      }
    }
  }
  
  
  // update player submarine on screen
  public void update() {
    move();
    render();
  }
  
  
  // collision detection
  public boolean isHit(Obstacle obs, float obWidth, float obHeight) {
    if (obs != null) {
      
      if (this.x+subWidth > obs.getX() && this.x < obs.getX()+obWidth && this.y+subHeight > obs.getY() && this.y < obs.getY()+obHeight) {
        return true;
      }
    }
    return false;
  }
  
  
  // explosion animation
  public void explosion() {
    fill(0);
    ellipse(x+subWidth/2,y+subHeight,explosionSize,explosionSize); 
    explosionSize=explosionSize+15;
    
    if (explosionSize > 100) { // stop animation at 100 radius
        explosionSize = 0;
      }
  }
  
  
  // health increase animation
  public void healthIncrease(int scoreInc) {
    fill(242, 242, 247);
    textAlign(CENTER, CENTER);
    rectMode(CORNER);
    textSize(30);
    text("+" + str(scoreInc), width/2, 50); // draw game title
    ellipse(x+subWidth/2,y+subHeight/2,healthIncreaseSize,healthIncreaseSize); 
    healthIncreaseSize=healthIncreaseSize-10;
    
    if (healthIncreaseSize < 0) { // stop animation at 0 radius
        healthIncreaseSize = 200;
      }
  }
  
  
  public float getExplosionSize() {
    return explosionSize;
  }
  
  
  public float getHealthIncreaseSize() {
    return healthIncreaseSize;
  }
  
  
}
