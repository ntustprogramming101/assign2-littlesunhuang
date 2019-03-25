PImage bgImg;
PImage groundhogIdleImg;
PImage life1Img;
PImage life2Img;
PImage life3Img;
PImage soilImg;
PImage soldierImg;
PImage titleImg;
PImage startNormalImg;
PImage startHoveredImg;
PImage restartNormalImg;
PImage restartHoveredImg;
PImage gameoverImg;
PImage cabbageImg;

int soldierX,soldierY;
int cabbageX,cabbageY;
float life1X=10,life2X=80,life3X=150;

float groundhogIdleX=320;
float groundhogIdleY=80;
float groundhogSpeed=80;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = GAME_START;
final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

final int TOTAL_LIFE = 2;
int life;

void setup() {
  size(640, 480, P2D);
  titleImg=loadImage("img/title.jpg");
  startNormalImg=loadImage("img/startNormal.png");
  startHoveredImg=loadImage("img/startHovered.png");
  bgImg=loadImage("img/bg.jpg");
  groundhogIdleImg=loadImage("img/groundhogIdle.png");
  life1Img=loadImage("img/life.png");
  life2Img=loadImage("img/life.png");
  life3Img=loadImage("img/life.png");
  soilImg=loadImage("img/soil.png");
  soldierImg=loadImage("img/soldier.png");
  gameoverImg=loadImage("img/gameover.jpg");
  cabbageImg=loadImage("img/cabbage.png");
  restartNormalImg=loadImage("img/restartNormal.png");
  restartHoveredImg=loadImage("img/restartHovered.png");
	
  //cabbage
  cabbageX=floor(random(8));
  cabbageX=cabbageX*80;
  cabbageY=floor(random(4)+2);
  cabbageY=cabbageY*80;
  //soldier
  soldierY=floor(random(4)+2);
  soldierY=soldierY*80;
  
  life = TOTAL_LIFE;
}

void draw() {
	switch(gameState){
    case GAME_START:
      image(titleImg,0,0);
      image(startNormalImg,BUTTON_LEFT,BUTTON_TOP);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHoveredImg,BUTTON_LEFT,BUTTON_TOP);
        if(mousePressed){
          gameState = GAME_RUN;
        }  
      }
    break;
      
    case GAME_RUN:
      soldierX+=3;
      soldierX%=720;
      
      image(bgImg,0,0);
      image(life1Img,life1X,10);
      image(life2Img,life2X,10);
      //image(life3Img,life3X,10);
      image(soilImg,0,160);
      image(cabbageImg,cabbageX,cabbageY);
      image(soldierImg,soldierX-80,soldierY);
      
      //gress
      fill(124,204,25);
      noStroke();
      rect(0,145,640,15);
      
      //groundhogImg
      image(groundhogIdleImg,groundhogIdleX,groundhogIdleY);
      
      //sun
      noStroke();
      fill(255,255,0);
      ellipse(590,50,130,130);//outside
      fill(253,184,19);
      ellipse(590,50,120,120);//inside
      
      //AABBhit_groundhog&soldier
      if(soldierX-80<groundhogIdleX+80 && soldierX>groundhogIdleX && 
      soldierY<groundhogIdleY+80 && soldierY+80>groundhogIdleY){
        groundhogIdleX=320;
        groundhogIdleY=80;
        life--;
        //println("life: " +life);
        if (life <=0 ){
          gameState = GAME_LOSE;
        }   
      }  
      
      
      //AABBhit_groundhog&cabbage
      if(cabbageX<groundhogIdleX+80 && cabbageX+80>groundhogIdleX && 
      cabbageY<groundhogIdleY+80 && cabbageY+80>groundhogIdleY){
        cabbageY=500;
        life++;
        //println("life: " +life);     
      }  
      
      //life
      if(life==3){
        life1X=10;
        life2X=80;
        image(life3Img,life3X,10);
        life3X=150;
      } 
      if(life==2){
        life1X=10;
        life2X=80;
        life3X=width;
      }  
      if(life==1){
        life1X=10;
        life2X=width;
        life3X=width;
      } 
      
      
    break;
    
    case GAME_LOSE:
    image(gameoverImg,0,0);
    image(restartNormalImg,BUTTON_LEFT,BUTTON_TOP);
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHoveredImg,BUTTON_LEFT,BUTTON_TOP);
        if(mousePressed){
          gameState = GAME_RUN;
          life = TOTAL_LIFE;
          cabbageX=floor(random(8));
          cabbageX=cabbageX*80;
          cabbageY=floor(random(4)+2);
          cabbageY=cabbageY*80;
          soldierY=floor(random(4)+2);
          soldierY=soldierY*80;
        }
      } 
    break;  
  }
  
}

  

void keyPressed() {
 
  if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        groundhogIdleY += groundhogSpeed;
        if (groundhogIdleY>height-80){
          groundhogIdleY=height-80;
        }  
        break;
      case LEFT:
        groundhogIdleX -= groundhogSpeed;
        if (groundhogIdleX<0){
          groundhogIdleX=0;
        }  
        break;
      case RIGHT:
        groundhogIdleX += groundhogSpeed;
        if (groundhogIdleX>width-80){
          groundhogIdleX=width-80;
        }  
        break;
    }
  } 
}

void keyReleased(){
}
