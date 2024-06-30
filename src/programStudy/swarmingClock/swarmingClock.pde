// 様々な大きさの縁が集まってできたデジタル時計。ライブラリに頼らず数字の表現をしたのがポイント。

int ballNum = 70;
float sX = 0;
float sY = 0;
float margin = 20;
float segW = 15;
float digW = 100;
int[] segNum = {6, 2, 5, 5, 4, 5, 6, 4, 7, 6};

Digit h10Dig = new Digit(floor(hour()/10), width/2, height/2, ballNum);
Digit h1Dig = new Digit(hour()%10, width/2+digW+margin, height/2, ballNum);
Digit m10Dig = new Digit(floor(minute()/10), width/2+(digW+margin)*2, height/2, ballNum);
Digit m1Dig = new Digit(minute()%10, width/2+(digW+margin)*3, height/2, ballNum);
Digit s10Dig = new Digit(floor(second()/10), width/2+(digW+margin)*4, height/2, ballNum);
Digit s1Dig = new Digit(second()%10, width/2+(digW+margin)*5, height/2, ballNum);

void setup(){
  size(1000, 500);
}

void draw(){
  background(0);
  if(s1Dig.n != second()%10){
    s1Dig.updateDigit(second()%10);
    s1Dig.setNextXY();
  }
  if(s10Dig.n != floor(second()/10)){
    s10Dig.updateDigit(floor(second()/10));
    s10Dig.setNextXY();
  }
  if(m1Dig.n != minute()%10){
    m1Dig.updateDigit(minute()%10);
    m1Dig.setNextXY();
  }
  if(m10Dig.n != floor(minute()/10)){
    m10Dig.updateDigit(floor(minute()/10));
    m10Dig.setNextXY();
  }
  if(h1Dig.n != hour()%10){
    h1Dig.updateDigit(hour()%10);
    h1Dig.setNextXY();
  }
  if(h10Dig.n != floor(hour()/10)){
    h10Dig.updateDigit(floor(hour()/10));
    h10Dig.setNextXY();
  }
  
  s1Dig.displayBalls();
  s1Dig.moveTo();
  s10Dig.displayBalls();
  s10Dig.moveTo();
  m1Dig.displayBalls();
  m1Dig.moveTo();
  m10Dig.displayBalls();
  m10Dig.moveTo();
  h1Dig.displayBalls();
  h1Dig.moveTo();
  h10Dig.displayBalls();
  h10Dig.moveTo();
  
}
