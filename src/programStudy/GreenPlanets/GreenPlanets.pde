// アート作品風。緑色の丸が同心円の軌道上をぐるぐる回る。

float radius = 30;
int planetNum = 100;

Planet[] planets = new Planet[planetNum];

void setup(){
  size(1000, 1000);
  for(int i = 0; i < planets.length; i++){
    planets[i] = new Planet(random(-0.02, 0.02), random(1, 500), random(0, 360), random(0.1, 10));
  }
}

void draw(){
  fill(0,64);
  noStroke();
  rect(0,0,width,height);
  for(int i = 0; i < planets.length; i++){
    planets[i].display();
    planets[i].move();
  }
}
