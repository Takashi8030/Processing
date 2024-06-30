// 重すぎて断念

int ballNum = 300;
color bgColor = color(0,0,0);
color bColor = color(255,255,255);

Ball[] balls = new Ball[ballNum];

void setup(){
  size(1000, 500);
  for(int i = 0; i < balls.length; i++){
    float radius = random(1, 5);
    balls[i] 
      = new Ball(
          random(radius,width-radius),
          random(radius,height-radius),
          radius);
  }
}

void draw(){
  background(0);
  fill(bColor);
  rect(width/2, height/2, 100, 100);
  for (int i = 0; i < balls.length; i++){
    balls[i].display();
    balls[i].moveTo(balls[i].getNearTarget()[0], balls[i].getNearTarget()[1]);
  }
}
