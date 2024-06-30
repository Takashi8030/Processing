class Ball{
  float x;
  float y;
  float radius;
  
  Ball(float _x, float _y, float _radius){
    x = _x;
    y = _y;
    radius = _radius;
  }
  
  void display(){
    noStroke();
    fill(bColor, 200);
    ellipse(x, y, radius*2, radius*2);
  }
  
  void moveTo(float tx, float ty){
    x+=(x-tx)/2;
    y+=(y-ty)/2;
  }
  
  float[] getNearTarget(){
    float[] target = new float[2];
    float targetX = x;
    float targetY = y;
    int deg = 0;
    int tRadius = 0;
    while(get(int(targetX), int(targetY)) != bColor){
      targetX = tRadius*cos(deg);
      targetY = tRadius*sin(deg);
      deg++;
      if(deg > 360){
        deg = 0;
        tRadius++;
      }
      if(tRadius > max(width, height)){
        targetX = -1;
        targetY = -1;
        break;
      }
    }
    target[0] = targetX;
    target[1] = targetY;
    return target;
  }
}
