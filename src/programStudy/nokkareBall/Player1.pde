void setupPlayer1(Body circle_body, float x1, float y1, float x2, float y2, float x3, float y3){
}

void drawPlayer1(Body circle_body, float x1, float y1, float x2, float y2, float x3, float y3){
  // ボールに中心方向の力を加える
  Vec2 center = new Vec2(codToWorldPositionX(500), codToWorldPositionY(500));
  Vec2 force = center.sub(circle_body.getWorldCenter());
  force.normalize(); // ベクトルの正規化
  force.mulLocal(3000f); // 力の大きさを調整

  // ボールに力を加える
  circle_body.applyForceToCenter(force);
}
