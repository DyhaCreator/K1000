class RAM{
  byte data[] = {
    0,0,0,0
  };
  void reset(){
    for(int i = 0; i < 4; i++){
      data[i] = 0;
    }
  }
}
