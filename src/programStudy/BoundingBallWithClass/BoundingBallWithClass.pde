int ballNum = 100;
Ball[] balls = new Ball[ballNum];

void setup(){
  size(500, 1000);
  for(int i = 0; i < balls.length; i++){
    float radius = random(1, 10);
    balls[i] = new Ball(random(radius+1, width-radius), random(radius+1, height-radius), random(1, 5), random(1, 5), radius*2, color(255, 255, 255));
  }
}

void draw(){
  background(0);
  for (int i = 0; i < balls.length; i++){
    balls[i].display();
    balls[i].move();
    balls[i].checkBound();
  }
}
