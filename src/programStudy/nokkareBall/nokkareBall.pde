// マリオパーティの乗っかれボールのオマージュ。外に出たボールは消える。

int sSize = 500;
float d = 100;
Player p1, p2, p3;

DwWorld world;
float scale;

void setup() {
  size(1000, 1000, P2D);
  
  world = new DwWorld(this, 20);
  world.setGravity(new Vec2(0, 0));
  scale = world.transform.screen_scale;
  
  p1 = new Player((width/2)+(d*cos(radians(90))), (height/2)+(d*sin(radians(90))), color(255, 0, 0), world, 1);
  p2 = new Player((width/2)+(d*cos(radians(210))), (height/2)+(d*sin(radians(210))), color(0, 255, 0), world, 2);
  p3 = new Player((width/2)+(d*cos(radians(330))), (height/2)+(d*sin(radians(330))), color(0, 0, 255), world, 3);
  
  p1.setupPlayer(p1.getX(), p1.getY(), p2.getX(), p2.getY(), p3.getX(), p3.getY());
  p2.setupPlayer(p1.getX(), p1.getY(), p2.getX(), p2.getY(), p3.getX(), p3.getY());
  p3.setupPlayer(p1.getX(), p1.getY(), p2.getX(), p2.getY(), p3.getX(), p3.getY());
  
  // setWall();
}

void draw() {
  PGraphics2D canvas = (PGraphics2D) this.g;
  
  canvas.background(255);
  
  //ステージ描画
  canvas.fill(200, 200, 200); // RGBカラー(白)塗りつぶし
  canvas.noStroke(); // 線無し
  canvas.ellipse(width/2, height/2, sSize, sSize);
  
  world.update();
  
  canvas.pushMatrix();
  world.applyTransform(canvas);
  world.display(canvas);
  canvas.popMatrix();
  
  p1.drawPlayer(p1.getX(), p1.getY(), p2.getX(), p2.getY(), p3.getX(), p3.getY());
  p2.drawPlayer(p1.getX(), p1.getY(), p2.getX(), p2.getY(), p3.getX(), p3.getY());
  p3.drawPlayer(p1.getX(), p1.getY(), p2.getX(), p2.getY(), p3.getX(), p3.getY());
  
  p1.checkFailed();
  p2.checkFailed();
  p3.checkFailed();
}

void setWall(){
  float screen_scale = world.transform.screen_scale;
  float b2d_screen_w = world.transform.box2d_dimx;
  float b2d_screen_h = world.transform.box2d_dimy;
  float b2d_thickness = 20 / screen_scale;
  
  BodyDef bd = new BodyDef();
  bd.position.set(0, 0);

  Body ground = world.createBody(bd);
  PolygonShape sd = new PolygonShape();
  
  float x, y, w, h;

  // 上
  x = 0 - (b2d_thickness/2);
  y = +b2d_screen_h + (b2d_thickness/2);
  w = b2d_screen_w;
  h = b2d_thickness;
  sd.setAsBox(w/2f, h/2f, new Vec2(x, y), 0.0f);
  ground.createFixture(sd, 0f);

  // 下
  x = 0 - (b2d_thickness/2);
  y = 0 - (b2d_thickness/2);
  w = b2d_screen_w;
  h = b2d_thickness;
  sd.setAsBox(w/2f, h/2f, new Vec2(x, y), 0.0f);
  ground.createFixture(sd, 0f);


  // 左
  x = -b2d_screen_w/2 - (b2d_thickness/2);
  y = +b2d_screen_h/2 + (b2d_thickness/2);
  w = b2d_thickness;
  h = b2d_screen_h;
  sd.setAsBox(w/2f, h/2f, new Vec2(x, y), 0.0f);
  ground.createFixture(sd, 0f);
  
  // 右
  x = +b2d_screen_w/2 + (b2d_thickness/2);
  y = +b2d_screen_h/2 + (b2d_thickness/2);
  w = b2d_thickness;
  h = b2d_screen_h;
  sd.setAsBox(w/2f, h/2f, new Vec2(x, y), 0.0f);
  ground.createFixture(sd, 0f);

  world.bodies.add(ground, true, color(255), !true, color(255), 1f);
}
