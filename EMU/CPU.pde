class CPU{
  byte A = 0;
  byte X = 0;
  byte Y = 0;
  boolean Carry = false;
  byte StackPointer = 0;
  byte RomPointer = 0;
  
  void reset(){
    A = 0;
    X = 0;
    Y = 0;
    Carry = false;
    StackPointer = 0;
    RomPointer = 0;
  }
}
