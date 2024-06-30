// 揺れながら画面内を跳ね回るボール。実験半分アート半分。

/**
 * bound ball. 
 * 
 * The current time can be read with the second(), minute(),
 * and hour() functions. In this example, sin() and cos() values
 * are used to set the position of the hands.
 */

float x, y, s, t;
float xSpeed, ySpeed, sSpeed, tSpeed;
float radius1 = 100, radius2 = 50;
float radian = 0;

void setup() {
  size(800, 600);
  x = width / 2;
  y = height / 2;
  s = 200;
  t = 500;
  xSpeed = random(2, 5);
  ySpeed = random(2, 5);
  sSpeed = random(2, 5);
  tSpeed = random(2, 5);
}

void draw() {
  background(0);

  x += xSpeed - 5 * sin(radian) * ySpeed / xSpeed;
  y += ySpeed + 5 * sin(radian);
  s += sSpeed - 5 * sin(radian) * tSpeed / sSpeed;
  t += tSpeed + 5 * sin(radian);
  
  radian += 0.5;
  if(radian > 360){
    radian = 0;
  }
  
  // 壁に当たったら跳ね返る
  if (x < radius1 || x > width - radius1) {
    xSpeed *= -1;
  }
  if (y < radius1 || y > height - radius1) {
    ySpeed *= -1;
  }
  if (s < radius2 || s > width - radius2) {
    sSpeed *= -1;
  }
  if (t < radius2 || t > height - radius2) {
    tSpeed *= -1;
  }
  
  // ボールが当たったら跳ね返る
  if ( sqrt( sq((x-s)) + sq((y-t)) ) < radius1 + radius2 ) {
    float tempS, tempT;
    tempS = sSpeed;
    tempT = tSpeed;
    sSpeed = xSpeed;
    tSpeed = ySpeed;
    xSpeed = tempS;
    ySpeed = tempT;
  }
  
  fill(255,44,99);
  ellipse(x, y, radius1 * 2, radius1 * 2);
  ellipse(s, t, radius2 * 2, radius2 * 2);
}
