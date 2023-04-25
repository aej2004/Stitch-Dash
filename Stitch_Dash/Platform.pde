class Platform {
  
  // variables
  
  int x;
  int y;
  int w;
  int h;
  
  int left;
  int right;
  int top;
  int bottom;
  
  int platSpeed;
  
  // constructor 
  
  Platform(int startingX, int startingY, int speed){
    
    rectMode(CENTER);
    
    x = startingX;
    y = startingY;
    w = 150;
    h = 10;
    
    platSpeed = speed;
    
  }
  
  // functions
  
  void render(){
    
    rectMode(CENTER);
    noStroke();
    rect(x,y,w,h);
    
  }
  
  void move(){
    x -= platSpeed;
  }
  
  void collide(Player aPlayer){
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
    // if player collides with a platform 
    
    if (left < aPlayer.right &&
        right > aPlayer.left &&
        top < aPlayer.bottom &&
        bottom > aPlayer.top){
          
          aPlayer.isFalling = false;
          aPlayer.y = y - h/2 - aPlayer.h/2;
          
    }
    
  }
  
}
