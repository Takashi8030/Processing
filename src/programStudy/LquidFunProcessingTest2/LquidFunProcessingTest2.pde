// 物理シュミレーションライブラリのテスト用コード2。ボールが落ちて跳ねる。

/**
 * 
 * LiquidFunProcessing | 著作権 2017 Thomas Diewald - www.thomasdiewald.com
 * 
 * https://github.com/diwi/LiquidFunProcessing.git
 * 
 * Processing向けのBox2d / LiquidFunライブラリ。
 * MITライセンス: https://opensource.org/licenses/MIT
 * 
 */


import com.thomasdiewald.liquidfun.java.DwWorld;
import com.thomasdiewald.liquidfun.java.render.DwJoint;

import org.jbox2d.collision.shapes.CircleShape;
import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.Vec2;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;
import org.jbox2d.dynamics.Fixture;
import org.jbox2d.dynamics.FixtureDef;
import org.jbox2d.dynamics.contacts.Contact;
import org.jbox2d.dynamics.joints.DistanceJointDef;
import org.jbox2d.dynamics.joints.Joint;

import processing.core.*;
import processing.opengl.PGraphics2D;

  
//
// 衝突の例。
// 2つのボディが衝突するたびに、距離ジョイントが作成されます。
//
// 世界の接触リストを反復処理して衝突テストが行われます。
//
//
// コントロール:
//
// LMB         ... ボディのドラッグ
// LMB + SHIFT ... 弾を発射
// MMB         ... パーティクルの追加
// RMB         ... パーティクルの削除
// 'r'         ... リセット
// 't'         ... 物理演算の更新/一時停止
// 'f'         ... デバッグ描画の切り替え
//


int viewport_w = 1280;
int viewport_h = 720;
int viewport_x = 230;
int viewport_y = 0;

boolean UPDATE_PHYSICS = true;
boolean USE_DEBUG_DRAW = false;

DwWorld world;

public void settings(){
  size(viewport_w, viewport_h, P2D);
  smooth(8);
}

public void setup(){ 
  surface.setLocation(viewport_x, viewport_y);
  reset();
  frameRate(120);
}


public void release(){
  if(world != null) world.release(); world = null;  
}

public void reset(){
  // 古いリソースを解放
  release();
  
  world = new DwWorld(this, 20);
  world.setGravity(new Vec2(0, -5));
  
  world.mouse_shoot_bullet.density_mult = 0.001f;
  world.mouse_shoot_bullet.cirlce_shape.m_radius = 1;
  world.mouse_shoot_bullet.velocity_mult = 0.6f;
  
  // シーンの作成: 剛体、パーティクルなど ...
  initScene();
}




public void draw(){
  
  if(UPDATE_PHYSICS){
    world.update();
    doSomethingWithCollisionContactsAndDistanceJoints();
  }

  
  PGraphics2D canvas = (PGraphics2D) this.g;
  
  canvas.background(32);
  canvas.pushMatrix();
  world.applyTransform(canvas);
  world.drawBulletSpawnTrack(canvas);
  
  if(USE_DEBUG_DRAW){
    world.displayDebugDraw(canvas);
    // DwDebugDraw.display(canvas, world);
  } else {
    world.display(canvas);
  }
  canvas.popMatrix();
  
  // 情報
  int num_bodies    = world.getBodyCount();
  int num_particles = world.getParticleCount();
  String txt_fps = String.format(getClass().getName()+ " [bodies: %d]  [particles: %d]  [fps %6.2f]", num_bodies, num_particles, frameRate);
  surface.setTitle(txt_fps);
}







public void doSomethingWithCollisionContactsAndDistanceJoints(){
  
  DistanceJointDef djd = new DistanceJointDef();
  djd.dampingRatio = 0.5f;
  djd.frequencyHz = 20.0f;
  djd.collideConnected = false; // デフォルトでは接続しない
  
//    RopeJointDef rjd = new RopeJointDef();

 
  // 前回のワールド更新ステップ以来、す    // べての接触を反復処理
  for(Contact contact = world.getContactList(); contact != null; contact = contact.m_next){
    
    // 接触の両方のボディ
    Body bodyA = contact.m_fixtureA.getBody();
    Body bodyB = contact.m_fixtureB.getBody();
    
    // 静的ボディとの接触を無視
    if(bodyA.m_type == BodyType.STATIC || bodyB.m_type == BodyType.STATIC ){
      continue;
    }
    
    // ボディのワールド座標
    Vec2 posA = bodyA.getTransform().p;
    Vec2 posB = bodyB.getTransform().p;
    
    // jointを作成 bodyA <-> bodyB
    djd.initialize(bodyA, bodyB, posA, posB);
    Joint joint = world.createJoint(djd);
    
//      Vec2 distAB = posA.sub(posB);
// 
//      rjd.bodyA = bodyA;
//      rjd.bodyB = bodyB;
//      rjd.localAnchorA.set(bodyA.getLocalPoint(posA));
//      rjd.localAnchorB.set(bodyB.getLocalPoint(posB));
//      rjd.maxLength = distAB.length();
//      Joint joint = world.createJoint(rjd);
    
    // jointの形状とスタイルを追加
    DwJoint dwjoint = world.bodies.add(joint, false, color(0), true, color(255, 160), 1.0f);
    

//      // 直線形状を矩形形状に置き換える
//      // jointのための色の遷移を適用するため。
//      // この操作は、線では機能しないが、矩形の場合は機能します。
//      DwFixture fA = DwWorld.getShape(contact.m_fixtureA);
//      DwFixture fB = DwWorld.getShape(contact.m_fixtureB);
//      
//      float h = 1f / world.transform.screen_scale;
//      
//      PShape shape_rect = createShape();
//      shape_rect.beginShape(QUADS);
//      shape_rect.noStroke();
//      shape_rect.fill(fA.shape.getFill(0));
//      shape_rect.vertex(0,-h);
//      shape_rect.vertex(0,+h);
//      shape_rect.fill(fB.shape.getFill(0));
//      shape_rect.vertex(1,+h);
//      shape_rect.vertex(1,-h);
//      shape_rect.endShape();
//
//      dwjoint.replaceShape(shape_rect);

  }
}




//////////////////////////////////////////////////////////////////////////////
// ユーザーインタラクション
//////////////////////////////////////////////////////////////////////////////

public void keyReleased(){
  if(key == 'r') reset();
  if(key == 't') UPDATE_PHYSICS = !UPDATE_PHYSICS;
  if(key == 'f') USE_DEBUG_DRAW = !USE_DEBUG_DRAW;
}



//////////////////////////////////////////////////////////////////////////////
// シーンのセットアップ
//////////////////////////////////////////////////////////////////////////////

int MAX_NUM = 200;
int m_count = 0;

public void initScene() {
  
  float screen_scale = world.transform.screen_scale;
  float b2d_screen_w = world.transform.box2d_dimx;
  float b2d_screen_h = world.transform.box2d_dimy;
  float b2d_thickness = 20 / screen_scale;
  
  {

    float radius = 25 / screen_scale;
    CircleShape circle_shape = new CircleShape();
    circle_shape.setRadius(radius);

    FixtureDef fixture_def = new FixtureDef();
    fixture_def.shape = circle_shape;
    fixture_def.density = 1;
    fixture_def.friction = 0.10f;
    fixture_def.restitution = 0.70f;
    
    BodyDef body_def = new BodyDef();
    body_def.type = BodyType.DYNAMIC;
    body_def.angle = 0.0f;
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
