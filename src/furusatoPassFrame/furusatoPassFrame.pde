// 円形の枠を8個に分割し、それぞれ銅、銀、金に塗り分けた画像を出力するプログラム

int count=0;

void setup()
{
  size(500, 500);
}

void draw()
{
  translate(250,250);
  if(count < 65536){
    int[] r = intToRankNum(count);
    drawFrame(r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7]); 
    save(str(r[7])
         + str(r[6])
         + str(r[5])
         + str(r[4])
         + str(r[3])
         + str(r[2])
         + str(r[1])
         + str(r[0])
         +".png");
    count++;
  }
}

void drawFrame(int a, int b, int c, int d,int e,int f,int g,int h){
  int fix = -90;
  noStroke(); // 線無し
  fill(getRankColor(a));
  arc( 0, 0, 350, 350, radians(0 + fix), radians(45 + fix) );
  fill(getRankColor(b));
  arc( 0, 0, 350, 350, radians(45 + fix), radians(90 + fix) );
  fill(getRankColor(c));
  arc( 0, 0, 350, 350, radians(90 + fix), radians(135 + fix) );
  fill(getRankColor(d));
  arc( 0, 0, 350, 350, radians(135 + fix), radians(180 + fix) );
  fill(getRankColor(e));
  arc( 0, 0, 350, 350, radians(180 + fix), radians(225 + fix) );
  fill(getRankColor(f));
  arc( 0, 0, 350, 350, radians(225 + fix), radians(270 + fix) );
  fill(getRankColor(g));
  arc( 0, 0, 350, 350, radians(270 + fix), radians(315 + fix) );
  fill(getRankColor(h));
  arc( 0, 0, 350, 350, radians(315 + fix), radians(360 + fix) );
  fill(255, 255, 255);
  ellipse(0, 0, 250, 250);
}

color getRankColor(int rank){
  color rankColor = color(247, 247, 247);
  switch(rank){
    case 1:
      rankColor = color(123, 40, 0);
      break;
    case 2:
      rankColor = color(190, 193, 195);
      break;
    case 3:
      rankColor = color(230, 180, 34);
      break;
  }
  return rankColor;
}

int[] intToRankNum(int num){
  int[] rankNum;
  rankNum = new int[8];
  int tempNum = num;
  for(int i=0; i<8; i++){
    rankNum[i] = tempNum % 4;
    tempNum = tempNum/4;
  }
  
  return rankNum;
}
