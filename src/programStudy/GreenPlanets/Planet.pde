class Planet{
  float speed;
  float tRadius;
  float radius;
  float t;
  
  Planet(float _speed, float _tRadius, float _t, float _radius){
    speed = _speed;
    tRadius = _tRadius;
    t = _t;
    radius = _radius;
  }
  
  void display(){
    noFill();
    stroke(13,196,29);
    ellipse(tRadius*cos(t)+(width/2), tRadius*sin(t)+(height/2), radius, radius);
  }
  
  void move(){
    t += speed;
  }
}
