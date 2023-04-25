// declaring my vars

import processing.sound.*;

SoundFile hawaiianRollerCoasterSound;

// image vars 
PImage startImage;
PImage gameImage;
PImage winLevelImage;
PImage lossLevelImage;
PImage winGameImage;

PImage[] stitchRunImages = new PImage[3];
Animation stitchRunAnimation;

PImage[] angelCheerImages = new PImage[20];
Animation angelCheerAnimation;
Extra angelCheer;

PImage experimentImage;

// object vars

Player p1;

Portal po1;

ArrayList<Platform> platforms;

ArrayList<Obstacle> obstacles;

int levelSpeed = 5;
int topSpeed = 10;

int state = 0;

int upgrade = 0;

// timer vars 

int platStartTime;
int platEndTime;
int platInterval = 5000;

int obsStartTime;
int obsEndTime;
int obsInterval = 3000;

int gameStartTime;
int gameEndTime;
int gameInterval = 10000;

void setup(){
  
  size(1200,800);
  
  hawaiianRollerCoasterSound = new SoundFile(this, "hawaiiansong.wav");
  hawaiianRollerCoasterSound.loop();
  
  if (hawaiianRollerCoasterSound.isPlaying() == false){
    hawaiianRollerCoasterSound.play();
  }
  
  // background images
  
  imageMode(CENTER);
  
  startImage = loadImage("stitchdash0.png");
  startImage.resize(width,height);
  
  gameImage = loadImage("stitchdash1.png");
  gameImage.resize(width,height);
  
  winLevelImage = loadImage("stitchdash2.png");
  winLevelImage.resize(width,height);
  
  lossLevelImage = loadImage("stitchdash3.png");
  lossLevelImage.resize(width,height);
  
  winGameImage = loadImage("stitchdash4.png");
  winGameImage.resize(width,height);
  
  if (upgrade == 0){
    experimentImage = loadImage("experiment0.png");
    experimentImage.resize(75,100);
  }
  if (upgrade == 1){
    experimentImage = loadImage("experiment1.png");
    experimentImage.resize(75,100);
  }
  if (upgrade == 2){
    experimentImage = loadImage("experiment2.png");
    experimentImage.resize(100,75);
  }
  if (upgrade == 3){
    experimentImage = loadImage("experiment3.png");
    experimentImage.resize(75,100);
  }
  else if (upgrade == 4){
    experimentImage = loadImage("experiment4.png");
    experimentImage.resize(75,100);
  }
  
  // initialize my player vars
  
  for(int index = 0; index < 3; index++){
    stitchRunImages[index] = loadImage("stitch" + index + ".png");
  }
  
  stitchRunAnimation = new Animation(stitchRunImages, .1, .5);
  
  for(int index = 0; index < 20; index++){
    angelCheerImages[index] = loadImage("angel" + index + ".gif");
  }
  
  angelCheerAnimation = new Animation(angelCheerImages, .1, .8);
  angelCheer = new Extra(200, levelSpeed, angelCheerAnimation);
  
  p1 = new Player(200, height/2, stitchRunImages.length, 80, stitchRunAnimation);
  
  po1 = new Portal(levelSpeed);
  
  // Platform Setup
  
  platforms = new ArrayList<Platform>();
  
  // Obstacle Setup 
  
  obstacles = new ArrayList<Obstacle>();
  
  // start the stopwatch 
  platStartTime = millis();
  obsStartTime = millis();
  gameStartTime = millis();
  
}

void draw(){
  
  switch (state){
    case 0:
      image(startImage, width/2, height/2);
      break;
    case 1: 
      platEndTime = millis();
      obsEndTime = millis();
      gameEndTime = millis();
      
      image(gameImage, width/2, height/2);
      
      textSize(100);
      text(upgrade, width - 100, 100);
      
      p1.render();
      p1.move();
      p1.jumping();
      p1.falling();
      p1.topOfJump();
      p1.land();
      p1.fallOfPlatform(platforms);
      
      if (gameEndTime - gameStartTime >= gameInterval + 2000){
        po1.render(experimentImage);
        po1.move();
        po1.collide(p1);
      }
      
      for (Platform aPlatform : platforms){
          aPlatform.render();
          aPlatform.collide(p1);
          aPlatform.move();
      }
      
      for (Obstacle aObstacle : obstacles){
          aObstacle.render();
          aObstacle.collide(p1);
          aObstacle.move();
      }
      
      // for loop to go through all platforms
        if (platEndTime - platStartTime >= platInterval){
          println("platform timer triggered");
          
          if (gameEndTime - gameStartTime <= gameInterval){
            platforms.add(new Platform(width, int(random(450,650)), levelSpeed));
            platforms.add(new Platform(width + 150, int(random(350,650)), levelSpeed));
            platforms.add(new Platform(width + 300, int(random(350,500)), levelSpeed));
          
            platStartTime = millis();
          }
          else {
            platStartTime = millis();
          }
        }
      
        if (obsEndTime - obsStartTime >= obsInterval){
          println("obstacle timer triggered");
      
          if (gameEndTime - gameStartTime <= gameInterval){
            if (obsInterval == 3000){
              obstacles.add(new Obstacle(width, levelSpeed));
            }
            if (obsInterval <= 2000){
              obstacles.add(new Obstacle(width, levelSpeed));
              obstacles.add(new Obstacle(width + int(random(50,200)), levelSpeed));
            }
            
            obsStartTime = millis();
          }
          else {
            obsStartTime = millis();
          }
        }
        
        if (gameEndTime - gameStartTime >= 20000){
          angelCheer.render();
          angelCheer.move();
        } 
      break;
    case 2: 
      if (upgrade < 4){
        image(winLevelImage, width/2, height/2);
      }
      else {
        image(winGameImage, width/2, height/2);
      }
      break;
    case 3: 
      image(lossLevelImage, width/2, height/2);
      break;
  }
}

void keyPressed(){
  
  if (key == 'p' && state == 0){
    state += 1;
    
    if (state >= 1){
      state = 1;
    }
  }
  if (key == 'r' && state > 2){
    hawaiianRollerCoasterSound.stop();
    state = 0;
    platInterval = 5000; 
    obsInterval = 3000;
    gameInterval = 30000;
    levelSpeed = 5;
    upgrade = 0;
    setup();
  }
  if (key == 'u' && state == 2 && upgrade < 4){
    hawaiianRollerCoasterSound.stop();
    state = 1; 
    upgrade += 1;
    gameInterval += 5000;
    setup();
    
    if (obsInterval >= 2000){
      obsInterval -= 1000;
      platInterval += 1000;
    }
    else if (obsInterval <= 1000){
      obsInterval = 1000;
      platInterval -= 500;
    }
    if (levelSpeed <= topSpeed){
      levelSpeed += 2;
    }
    else {
      levelSpeed = topSpeed;
    }
  }
    if (state == 1 && key == ' ' && 
        p1.isJumping == false && p1.isFalling == false) {
      
        p1.isJumping = true;
        p1.highestY = p1.y - p1.jumpHeight;
    }
  
}

void keyReleased(){
  
  if (key == 'a'){
    p1.isMovingLeft = false;
  }
  if (key == 'd'){
    p1.isMovingRight = false;
  }
  if (key == ' '){
    p1.isJumping = false;
    p1.isFalling = true;
  }
  
}
