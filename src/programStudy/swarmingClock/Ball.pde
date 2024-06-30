class Ball{
  float x;
  float y;
  float radius;
  float nextX;
  float nextY;
  
  Ball(float _x, float _y, float _radius){
    x = _x;
    y = _y;
    radius = _radius;
  }
  
  void display(){
    noStroke();
    fill(255, 255, 255);
    ellipse(x, y, radius*2, radius*2);
  }
  
  void moveTo(float tx, float ty){
    x+=(tx-x)/2;
    y+=(ty-y)/2;
  }
  
  void setNextXY(float _nextX, float _nextY){
    nextX = _nextX;
    nextY = _nextY;
  }
  
  float getNextX(){
    return nextX;
  }
  
  float getNextY(){
    return nextY;
  }
}
