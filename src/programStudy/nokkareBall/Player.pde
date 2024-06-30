import com.thomasdiewald.liquidfun.java.DwWorld;
import org.jbox2d.common.Vec2;
import org.jbox2d.collision.shapes.CircleShape;
import org.jbox2d.collision.shapes.PolygonShape;
import org.jbox2d.dynamics.FixtureDef;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;

class Player{
  color c;
  FixtureDef fixture_def;
  BodyDef body_def;
  Body circle_body;
  boolean isGameOver = false;
  int pNum;
  
  Player(float _x, float _y, color _c ,DwWorld world, int _pNum){
    pNum = _pNum;
    
    // ボールの物理設定
    float radius = 25 / scale;
    CircleShape circle_shape = new CircleShape();
    circle_shape.setRadius(radius);
  
    fixture_def = new FixtureDef();
    fixture_def.shape = circle_shape;
    fixture_def.density = 10f;
    fixture_def.friction = 0.10f;
    fixture_def.restitution = 1f;
    
    body_def = new BodyDef();
    body_def.type = BodyType.DYNAMIC;
    body_def.position.x = codToWorldPositionX(_x);
    body_def.position.y = codToWorldPositionY(_y);
    body_def.bullet = true;
       
    circle_body = world.createBody(body_def);
    circle_body.createFixture(fixture_def);
    
    world.bodies.add(circle_body, true, _c, false, 0, 1f);
  }
  
  public void setupPlayer(float x1, float y1, float x2, float y2, float x3, float y3){
    switch(pNum){
      case 1:
       setupPlayer1(circle_body, x1, y1, x2, y2, x3, y3);
       break;
      case 2:
       setupPlayer2(circle_body, x1, y1, x2, y2, x3, y3);
       break;
      case 3:
       setupPlayer3(circle_body, x1, y1, x2, y2, x3, y3);
       break;
      default:
       break;
    }
  }
  
  public void drawPlayer(float x1, float y1, float x2, float y2, float x3, float y3){
    switch(pNum){
      case 1:
       drawPlayer1(circle_body, x1, y1, x2, y2, x3, y3);
       break;
      case 2:
       drawPlayer2(circle_body, x1, y1, x2, y2, x3, y3);
       break;
      case 3:
       drawPlayer3(circle_body, x1, y1, x2, y2, x3, y3);
       break;
      default:
       break;
    }
  }
  
  public void checkFailed(){
    if(!isGameOver && sqrt( sq(getX()-(width/2)) + sq(getY()-(height/2)) ) > (sSize/2)){
      isGameOver = true;
      world.destroyBody(circle_body);
      println(pNum);
    }
    //if(isGameOver){
    //  goToOutside(circle_body);
    //}
  }
  
  public float getX(){
    return worldPositionToCodX(circle_body.getPosition().x);
  }
  
  public float getY(){
    return worldPositionToCodY(circle_body.getPosition().y);
  }
}

float codToWorldPositionX(float _x){
  return _x / scale - ( width / (scale*2));
}

float codToWorldPositionY(float _y){
  return (height - _y) / scale ;
}

float worldPositionToCodX(float _x){
  return (_x + ( width / (scale*2) ) ) * scale;
}

float worldPositionToCodY(float _y){
  return height - ( _y * scale);
}

void goToOutside(Body body){
  Vec2 center = new Vec2(codToWorldPositionX(width*2), codToWorldPositionY(height*2));
  Vec2 force = center.sub(body.getWorldCenter());
  force.normalize(); // ベクトルの正規化
  force.mulLocal(9999999999f); // 力の大きさを調整

  // ボールに力を加える
  body.applyForceToCenter(force);
}
