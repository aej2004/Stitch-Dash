class Player {
  
  // variables
  int x;
  int y;
  int w;
  int h;
  
  boolean isMovingLeft;
  boolean isMovingRight;
  
  boolean isJumping;
  boolean isFalling;
  
  int speed;
  
  float jumpHeight;
  float highestY;
  
  float left;
  float right;
  float top;
  float bottom;
  
  Animation runAnimation;
  
  // constructor
  
  Player(int startingX, int startingY, int startingW, 
         int startingH, Animation aAnimation){
    
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    
    isMovingLeft = false;
    isMovingRight = false;
    
    isJumping = false;
    isFalling = false;
    
    speed = 15;
    
    jumpHeight = 400;
    highestY = y - jumpHeight;
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
    runAnimation = aAnimation;
    
  }
  
  // functions
  
  void render(){
    
    rectMode(CENTER);
    runAnimation.display(x,y);
    //rect(x,y,w,h);
    
  }
  
  void move(){
    
    runAnimation.isAnimating = true;
    if (isMovingLeft == true){
      x -= speed; 
    }
    if (isMovingRight == true){
      x += speed;
    }
    
    // update the bounds of the player 
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
  }
  
  void jumping(){
    
    if (isJumping == true){
      y -= speed;
    }
    
  }
  
  void falling(){
    
    if (isFalling == true){
      y += speed;
    }
    
  }
  
  void topOfJump(){
    
    if (y <= highestY){
      isJumping = false;
      isFalling = true;
    }
    
  }
  
  void land(){
    
    if (y >= height - h/2){
      isFalling = false; // stop falling
      y = height - h/2; // snap player to position where they are standing of the bottom of window
    }
    
  }
  
  // check to see if the player is colliding with any platform
  // if the player is not colliding with any platforms, then
  // make the player start falling 
  
  void fallOfPlatform(ArrayList<Platform> aPlatformList){
    
    // check that the player is not in the middle of a jump
    // and check that the player is not on the groung
    
    if (isJumping == false && y < height - h/2){
      
      boolean onPlatform = false;
      
      for (Platform aPlatform : aPlatformList){
        // if the player is colliding with a platform 
        if (top <= aPlatform.bottom &&
            bottom >= aPlatform.top &&
            left <= aPlatform.right &&
            right >= aPlatform.left){
              
              onPlatform = true; // make onPlatform true
              
        }
      }
         
         // if you are not on a platform 
         // start falling
         if (onPlatform == false){
           isFalling = true;
         }
        
   }  
 }
}
