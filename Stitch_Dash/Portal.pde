class Portal {
 
  // variables 
  
  int x;
  int y;
  int w;
  int h;
  int c;
  int s;
  
  float left;
  float right;
  float top;
  float bottom;
  
  
  // constructor
  
  Portal(int speed){
    
    x = width - 100;
    y = height - 50;
    w = 75;
    h = 100;
    c = color(255,0,0);
    s = speed;
    
  }
  
  // functions
  
  void render(PImage img){
    
    image(img, x, y);
    
  }
  
  void move(){
    
    x -= s;
    
  }
  
  void collide(Player aPlayer){
    
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
    // if player collides with a portal 
    
    if (left < aPlayer.right &&
        right > aPlayer.left &&
        top < aPlayer.bottom &&
        bottom > aPlayer.top){
          
          state = 2;
          
    }
  }
  
}
