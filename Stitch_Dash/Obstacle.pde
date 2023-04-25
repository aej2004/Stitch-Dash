class Obstacle {
  
  // variables 
  int x;
  int y;
  int w;
  int h;
  
  float left;
  float right;
  float top;
  float bottom;
  
  int obstSpeed;
  
  // constructor
  
  Obstacle(int startingX, int speed){
    
    x = startingX;
    y = height;
    w = 50;
    h = 75;
    
    obstSpeed = speed;
    
  }
  
  // functions
  
  void render(){
    
    rectMode(CENTER);
    noStroke();
    rect(x,y,w,h);
    
  }
  
  void move(){
    x -= obstSpeed;
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
          
          state = 3;
          
    }
    
  }
  
}
