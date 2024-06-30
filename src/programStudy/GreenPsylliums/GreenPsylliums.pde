// アート作品風。緑色の棒が1点を中心にぐるぐる回る。processingArtと一緒。

float radius = 30;
int strokeNum = 100;

Stroke[] strokes = new Stroke[strokeNum];

void setup(){
  size(1000, 1000);
  for(int i = 0; i < strokes.length; i++){
    strokes[i] = new Stroke(random(-0.1, 0.1), random(1, 500), random(0, 360));
  }
}

void draw(){
  fill(0,64);
  noStroke();
  rect(0,0,width,height);
  for(int i = 0; i < strokes.length; i++){
    strokes[i].display();
    strokes[i].move();
  }
}
