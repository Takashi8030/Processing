class Player{
  float size;
  
  Player(float _size){
    size = _size;
  }
  
  void display(){
    fill(255, 0, 0);
    noStroke();
    rect(mouseX, mouseY, size, size);
  }
}
