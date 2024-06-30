int cx, cy;             // 時計の中心座標
float secondsRadius;    // 秒針の長さ
float minutesRadius;    // 分針の長さ
float hoursRadius;      // 時針の長さ
float clockDiameter;    // 時計の直径

void setup() {
  size(640, 360);       // キャンバスのサイズを設定
  stroke(255);          // 描画時の線の色を白に設定
  
  int radius = min(width, height) / 2;  // 時計の半径を画面の幅と高さの小さい方の半分に設定
  secondsRadius = radius * 0.72;        // 秒針の長さを設定
  minutesRadius = radius * 0.60;        // 分針の長さを設定
  hoursRadius = radius * 0.50;          // 時針の長さを設定
  clockDiameter = radius * 1.8;         // 時計の直径を設定
  
  cx = width / 2;       // 時計の中心のx座標
  cy = height / 2;      // 時計の中心のy座標
}

void draw() {
  background(0);         // 背景を黒に設定
  
  // 時計の背景を描画
  fill(80);               // 塗りつぶし色を灰色に設定
  noStroke();             // 枠線をなしに設定
  ellipse(cx, cy, clockDiameter, clockDiameter);  // 円を描画
  
  // 時、分、秒の角度を計算
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;  // 秒針の角度
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;  // 分針の角度
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;  // 時針の角度
  
  // 時計の針を描画
  stroke(255);           // 描画時の線の色を白に設定
  strokeWeight(1);       // 線の太さを1に設定
  line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);  // 秒針を描画
  strokeWeight(2);       // 線の太さを2に設定
  line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);  // 分針を描画
  strokeWeight(4);       // 線の太さを4に設定
  line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);      // 時針を描画
  
  // 分の目盛りを描画
  strokeWeight(2);       // 線の太さを2に設定
  beginShape(POINTS);    // 点を描画するモードに切り替え
  for (int a = 0; a < 360; a+=6) {
    float angle = radians(a);  // 角度をラジアンに変換
    float x = cx + cos(angle) * secondsRadius;  // 分の目盛りのx座標を計算
    float y = cy + sin(angle) * secondsRadius;  // 分の目盛りのy座標を計算
    vertex(x, y);  // 点を描画
  }
  endShape();  // 描画モードを終了
}
