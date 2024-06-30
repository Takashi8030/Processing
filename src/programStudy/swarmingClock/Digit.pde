class Digit{
  int n;
  float x;
  float y;
  float radius;
  float randX;
  float randY;
  int ballNum;
  Ball[] balls;
  
  Digit(int _n, float _x, float _y, int _ballNum){
    n = _n;
    x = _x;
    y = _y;
    ballNum = _ballNum;
    balls = new Ball[ballNum];
    for(int i = 0; i < balls.length; i++){
      float radius = random(1, 15);
      balls[i] 
        = new Ball(
            random(radius,width-radius),
            random(radius,height-radius),
            radius);
    }
    this.setNextXY();
  }
  
  void updateDigit(int _n){
    n = _n;
  }
  
  ArrayList<float[]> getRange(){
    ArrayList<float[]> r = new ArrayList<float[]>();
    switch(n){
      case 0:
        r.add(_getSegR(1));
        r.add(_getSegR(2));
        r.add(_getSegR(3));
        r.add(_getSegR(5));
        r.add(_getSegR(6));
        r.add(_getSegR(7));
        break;
      case 1:
        r.add(_getSegR(3));
        r.add(_getSegR(6));
        break;
      case 2:
        r.add(_getSegR(1));
        r.add(_getSegR(3));
        r.add(_getSegR(4));
        r.add(_getSegR(5));
        r.add(_getSegR(7));
        break;
      case 3:
        r.add(_getSegR(1));
        r.add(_getSegR(3));
        r.add(_getSegR(4));
        r.add(_getSegR(6));
        r.add(_getSegR(7));
        break;
      case 4:
        r.add(_getSegR(2));
        r.add(_getSegR(3));
        r.add(_getSegR(4));
        r.add(_getSegR(6));
        break;
      case 5:
        r.add(_getSegR(1));
        r.add(_getSegR(2));
        r.add(_getSegR(4));
        r.add(_getSegR(6));
        r.add(_getSegR(7));
        break;
      case 6:
        r.add(_getSegR(1));
        r.add(_getSegR(2));
        r.add(_getSegR(4));
        r.add(_getSegR(5));
        r.add(_getSegR(6));
        r.add(_getSegR(7));
        break;
      case 7:
        r.add(_getSegR(1));
        r.add(_getSegR(2));
        r.add(_getSegR(3));
        r.add(_getSegR(6));
        break;
      case 8:
        r.add(_getSegR(1));
        r.add(_getSegR(2));
        r.add(_getSegR(3));
        r.add(_getSegR(4));
        r.add(_getSegR(5));
        r.add(_getSegR(6));
        r.add(_getSegR(7));
        break;
      case 9:
        r.add(_getSegR(1));
        r.add(_getSegR(2));
        r.add(_getSegR(3));
        r.add(_getSegR(4));
        r.add(_getSegR(6));
        r.add(_getSegR(7));
        break;
      
    }
    return r;
  }
  
  float[] _getSegR(int segNum){
    float[] segR = new float[4];
    switch(segNum){
      case 1:
        segR[0] = x+segW;
        segR[1] = y;
        segR[2] = x+digW-segW;
        segR[3] = y+segW;
        break;
      case 2:
        segR[0] = x;
        segR[1] = y+segW;
        segR[2] = x+segW;
        segR[3] = y+digW-segW;
        break;
      case 3:
        segR[0] = x+digW-segW;
        segR[1] = y+segW;
        segR[2] = x+digW;
        segR[3] = y+digW-segW;
        break;
      case 4:
        segR[0] = x+segW;
        segR[1] = y+digW-segW;
        segR[2] = x+digW-segW;
        segR[3] = y+digW;
        break;
      case 5:
        segR[0] = x;
        segR[1] = y+digW;
        segR[2] = x+segW;
        segR[3] = y+digW-segW+digW-segW;
        break;
      case 6:
        segR[0] = x+digW-segW;
        segR[1] = y+digW;
        segR[2] = x+digW;
        segR[3] = y+digW-segW+digW-segW;
        break;
      case 7:
        segR[0] = x+segW;
        segR[1] = y+digW-segW+digW-segW;
        segR[2] = x+digW-segW;
        segR[3] = y+digW+digW-segW;
        break;
    }
    return segR;
  }
  
  // 範囲内のランダムな座標をballsにset
  void setNextXY(){
    ArrayList<float[]> range = this.getRange();
    for (int i = 0; i < this.balls.length; i++){
      int segN = floor(random(0, segNum[n]));
      this.balls[i].setNextXY(
        random(range.get(segN)[0], range.get(segN)[2]),
        random(range.get(segN)[1], range.get(segN)[3])
      );
    }
  }
  
  void displayBalls(){
    for (int i = 0; i < this.balls.length; i++){
      this.balls[i].display(); 
    }
  }
  
  void moveTo(){
    for (int i = 0; i < this.balls.length; i++){
      Ball b = this.balls[i];
      b.moveTo(
        b.getNextX(),
        b.getNextY()
      );
    }
  }
}
