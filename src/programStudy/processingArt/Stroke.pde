class Stroke{
  float speed;
  float radius;
  float t;
  
  Stroke(float _speed, float _radius, float _t){
    speed = _speed;
    radius = _radius;
    t = _t;
  }
  
  void display(){
    noFill();
    stroke(13,196,29);
    line(width/2, height/2, radius*cos(t)+(width/2), radius*sin(t)+(height/2));
  }
  
  void move(){
    t += speed;
  }
}
