int bNum = 100;
float pSize = 10;
float minBSpeed = -2;
float maxBSpeed = 2;
boolean isGameOver;

Ball[] balls = new Ball[bNum];
Player p = new Player(pSize);


void setup(){
  size(500, 700);
  isGameOver = false;
  initBalls();
}

void draw(){
  background(0);
  if(!isGameOver){
    for (int i = 0; i < balls.length; i++){
      balls[i].display();
      balls[i].move();
      balls[i].checkBound();
    }
    p.display();
    checkGameOver();
  }
  else{
    displayGameOver();
  }
}

void keyPressed() {
  initBalls();
  isGameOver = false;
}

void initBalls(){
  for(int i = 0; i < balls.length; i++){
    float radius = random(1, 10);
    float collisionBuffer = 10;
    balls[i] 
      = new Ball(
          random(radius+collisionBuffer,width-radius-collisionBuffer),
          random(radius+collisionBuffer,height-radius-collisionBuffer),
          random(minBSpeed, maxBSpeed),
          random(minBSpeed, maxBSpeed),
          radius*2,
          color(255, 255, 255)
        );
  }
}

void checkGameOver(){
  for(int i = 0; i < balls.length; i++){
    Ball b = balls[i];
    if( mouseX < b.x + b.radius && mouseX > b.x - b.radius && mouseY < b.y + b.radius && mouseY > b.y - b.radius){
      isGameOver = true;
    }
  }
}

void displayGameOver(){
  fill(255,0,0);
  textSize(50);
  textAlign(CENTER);
  text("GAME OVER", width/2 , height/2);
}
