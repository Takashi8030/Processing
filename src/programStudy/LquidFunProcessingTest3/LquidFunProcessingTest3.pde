import com.thomasdiewald.liquidfun.java.DwWorld;
import org.jbox2d.common.Vec2;
import org.jbox2d.collision.shapes.CircleShape;
import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.dynamics.FixtureDef;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;

DwWorld world;

void setup(){ 
  size(1280, 720, P2D);
  world = new DwWorld(this, 20);
  world.setGravity(new Vec2(0, 0));

  initScene();
}

void draw(){
  world.update();
  PGraphics2D canvas = (PGraphics2D) this.g;
  
  canvas.background(32);
  canvas.pushMatrix();
  world.applyTransform(canvas);
  world.display(canvas);
  canvas.popMatrix();
}

public void initScene() {
  float screen_scale = world.transform.screen_scale;
  float b2d_screen_w = world.transform.box2d_dimx;
  float b2d_screen_h = world.transform.box2d_dimy;
  float b2d_thickness = 20 / screen_scale;
  
  // ボールの物理設定
  float radius = 25 / screen_scale;
  CircleShape circle_shape = new CircleShape();
  circle_shape.setRadius(radius);

  FixtureDef fixture_def = new FixtureDef();
  fixture_def.shape = circle_shape;
  fixture_def.density = 1;
  fixture_def.friction = 0.10f;
  fixture_def.restitution = 0.70f;
  
  { // ボール
    BodyDef body_def = new BodyDef();
    body_def.type = BodyType.DYNAMIC;
    body_def.position.x = -1/screen_scale;
    body_def.position.y = b2d_screen_h - 10;
    body_def.bullet = true;
       
    Body circle_body = world.createBody(body_def);
    circle_body.createFixture(fixture_def);
    
    world.bodies.add(circle_body, true, color(64, 125, 255), true, color(0), 1f);
  }
  
  { // ボール
    BodyDef body_def = new BodyDef();
    body_def.type = BodyType.DYNAMIC;
    body_def.position.x = -1/screen_scale;
    body_def.position.y = b2d_screen_h - 10;
    body_def.bullet = true;
       
    Body circle_body = world.createBody(body_def);
    circle_body.createFixture(fixture_def);
    
    world.bodies.add(circle_body, true, color(64, 125, 255), true, color(0), 1f);
  }
  
  { // 壁
    BodyDef bd = new BodyDef();
    bd.position.set(0, 0);

    Body ground = world.createBody(bd);
    PolygonShape sd = new PolygonShape();
    
    float x, y, w, h;

    // 上
    x = 0;
    y = +b2d_screen_h;
    w = b2d_screen_w;
    h = b2d_thickness;
    sd.setAsBox(w/2f, h/2f, new Vec2(x, y), 0.0f);
    ground.createFixture(sd, 0f);

    // 下
    x = 0;
    y = 0;
    w = b2d_screen_w;
    h = b2d_thickness;
    sd.setAsBox(w/2f, h/2f, new Vec2(x, y), 0.0f);
    ground.createFixture(sd, 0f);


    // 左
    x = -b2d_screen_w/2;
    y = +b2d_screen_h/2;
    w = b2d_thickness;
    h = b2d_screen_h;
    sd.setAsBox(w/2f, h/2f, new Vec2(x, y), 0.0f);
    ground.createFixture(sd, 0f);
    
    // 右
    x = +b2d_screen_w/2;
    y = +b2d_screen_h/2;
    w = b2d_thickness;
    h = b2d_screen_h;
    sd.setAsBox(w/2f, h/2f, new Vec2(x, y), 0.0f);
    ground.createFixture(sd, 0f);

    world.bodies.add(ground, true, color(0), !true, color(0), 1f);
  }
}
