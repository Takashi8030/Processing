float circleX; // 円のx座標

void setup() {
  size(400, 200); // ウィンドウのサイズを設定
  circleX = width / 2; // 円の初期位置を画面の中央に設定
}

void draw() {
  background(220); // 背景をクリア

  // 円を描画
  fill(255, 0, 0); // 円の色を設定 (赤)
  ellipse(circleX, height / 2, 50, 50); // 円を描画

  // 円を左右に移動
  circleX = circleX + 1; // 1ピクセル右に移動

  // 画面外に出たら反対側に移動
  if (circleX > width) {
    circleX = 0;
  }
}
