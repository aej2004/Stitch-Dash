class Extra{
  
  // variables 
  
  int x; 
  int y;
  int s;
  
  Animation aAnimation;
  
  // constructor
  
  Extra(int startingY, int speed, Animation anim){
    
    x = width;
    y = startingY;
    s = speed;
    
    aAnimation = anim;
    
  }
  
  // functions 
  
  void render(){
    
    rectMode(CENTER);
    aAnimation.display(x,y);
    
  }
  
  void move(){
    
    aAnimation.isAnimating = true;
    x -= s;
    
  }

}
