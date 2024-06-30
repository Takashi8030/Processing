int count=0;

void setup()
{
  size(1000, 1000);
}

void draw()
{
  if(count < 100){
    String countStr = str(count);
    fill(255, 255, 255);
    noStroke();
    rect(0, 0, 1000, 1000);
    fill(0);
    textSize(500);
    textAlign(CENTER, CENTER);
    text(countStr, 250, 250, 500, 500);
    save(countStr+".png");
    count++;
  }
}
