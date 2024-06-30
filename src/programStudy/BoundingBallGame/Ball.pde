class Ball{
  float x;
  float y;
  float xSpeed;
  float ySpeed;
  float radius;
  color c;
  
  Ball(float _x, float _y, float _xSpeed, float _ySpeed, float _radius, color _c){
    x = _x;
    y = _y;
    xSpeed = _xSpeed;
    ySpeed = _ySpeed;
    radius = _radius;
    c = _c;
  }
  
  void display(){
    fill(c);
    noStroke();
    ellipse(x, y, radius*2, radius*2);
  }
  
  void move(){
    x += xSpeed;
    y += ySpeed;
  }
  
  void checkBound(){
    if(x < radius || x > width - radius){
      xSpeed = -xSpeed;
      _updateColor();
    }
    if(y < radius || y > height - radius){
      ySpeed = -ySpeed;
      _updateColor();
    }
  }
  
  void _updateColor(){
    c = color(random(255),random(255),random(255));
  }
}
