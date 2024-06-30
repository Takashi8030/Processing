// アート作品風。淡い半透明のボールが画面内を跳ね回る。色の付け方がポイント。

int ballNum = 300;
float minBSpeed = -3;
float maxBSpeed = 3;

Ball[] balls = new Ball[ballNum];

void setup(){
  size(1000, 1500);
  colorMode(HSB,360,100,100);
  for(int i = 0; i < balls.length; i++){
    float radius = random(1, 50);
    float collisionBuffer = radius;
    balls[i] 
      = new Ball(
          random(radius+collisionBuffer,width-radius-collisionBuffer),
          random(radius+collisionBuffer,height-radius-collisionBuffer),
          random(minBSpeed, maxBSpeed),
          random(minBSpeed, maxBSpeed),
          radius*2,
          color(random(360),random(40,50),random(80, 99))
        );
  }
}

void draw(){
  //fill(0,100);
  //rect(0, 0, width, height);
  background(47,7,97);
  for (int i = 0; i < balls.length; i++){
    balls[i].display();
    balls[i].move();
    balls[i].checkBound();
  }
}
