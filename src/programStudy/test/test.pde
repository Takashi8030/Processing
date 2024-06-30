import com.thomasdiewald.liquidfun.java.DwWorld;
import org.jbox2d.collision.shapes.CircleShape;
import org.jbox2d.common.Vec2;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;
import org.jbox2d.dynamics.FixtureDef;
import processing.core.*;

DwWorld world;
Ball[] balls;

void setup() {
  size(800, 600, P2D);
  world = new DwWorld(this, 20);

  balls = new Ball[3];
  for (int i = 0; i < balls.length; i++) {
    float x = random(width);
    float y = random(height);
    balls[i] = new Ball(x, y, random(10, 50));
    balls[i].applyForce();
  }
}

void draw() {
  background(255);

  // 物理シミュレーションを進める
  world.update();

  for (Ball ball : balls) {
    ball.update(); // 速度に基づいて位置を更新
    ball.display();
  }
}

class Ball {
  Body body;
  float radius;
  Vec2 velocity;

  Ball(float x, float y, float r) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(x, y);
    body = world.createBody(bd);

    CircleShape cs = new CircleShape();

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1.0;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    body.createFixture(fd);

    radius = r;
    velocity = new Vec2(0, 0);
  }

  // ボールにランダムな方向に速度を加えるメソッド
  void applyForce() {
    float strength = 0.1; // 速度の強さ
    float angle = random(TWO_PI); // ランダムな方向
    velocity.set(cos(angle) * strength, sin(angle) * strength);
  }

  // 速度に基づいて位置を更新するメソッド
  void update() {
    Vec2 pos = body.getPosition();
    pos.add(velocity);
    body.setTransform(pos, body.getAngle());
  }

  // ボールを描画するメソッド
  void display() {
    Vec2 pos = body.getPosition();
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
  }
}
