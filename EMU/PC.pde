class PC{
  BUS bus = new BUS();
  void loadData(){
    byte data[] = loadBytes("ROM");
    for (int i = 0; i < data.length; i++) {
      bus.rom.data[i] = data[i];
    }
  }
  void tick(){
    if(bus.cpu.RomPointer < 16){
      int data = bus.rom.data[bus.cpu.RomPointer];
      //println(hex(data,2));
      int hbyte = (data & 0b11110000) / 0b10000;
      
        switch(hbyte){
          case 0b0000:
          //NOP
          break;
          case 0b0001:
          PUSH();
          break;
          case 0b0010:
          POP();
          break;
          case 0b0011:
          JUM();
          break;
          case 0b0100:
          copA(0);
          break;
          case 0b0101:
          copA(1);
          break;
          case 0b0110:
          copXY(0);
          break;
          case 0b0111:
          copXY(1);
          break;
          case 0b1000:
          ADDX();
          break;
          case 0b1001:
          ADDY();
          break;
          case 0b1010:
          LDA();
          break;
          case 0b1011:
          CLC();
          break;
          case 0b1100:
          JMPA0();
          break;
          case 0b1101:
          JMPC0();
          break;
          case 0b1110:
          JMPA1();
          break;
          case 0b1111:
          JMPC1();
          break;
      }
      
      bus.cpu.RomPointer++;
    }
  }
  void PUSH(){
    bus.ram.data[bus.cpu.StackPointer] = bus.cpu.A;
    bus.cpu.StackPointer++;
  }
  void POP(){
    bus.cpu.StackPointer--;
    bus.cpu.A = bus.ram.data[bus.cpu.StackPointer];
    bus.ram.data[bus.cpu.StackPointer] = 0;
  }
  void JUM(){
    byte b = bus.rom.data[bus.cpu.RomPointer];
    byte data = byte(b & 0b1111);
    bus.cpu.RomPointer = byte(data - 1);
  }
  void copXY(int num){
    if(num == 0){
      bus.cpu.A = bus.cpu.X;
    }
    else{
      bus.cpu.A = bus.cpu.Y;
    }
  }
  void copA(int num){
    if(num == 0){
      bus.cpu.X = bus.cpu.A;
    }
    else{
      bus.cpu.Y = bus.cpu.A;
    }
  }
  void ADDX(){
    bus.cpu.A += bus.cpu.X;
    if(bus.cpu.A > 3){
      bus.cpu.A -= 0x3;
      bus.cpu.Carry = true;
    }
  }
  void ADDY(){
    bus.cpu.A += bus.cpu.Y;
    if(bus.cpu.A > 3){
      bus.cpu.A -= 0x3;
      bus.cpu.Carry = true;
    }
  }
  void LDA(){
    byte b = bus.rom.data[bus.cpu.RomPointer];
    byte data = byte(b & 0b1111);
    bus.cpu.A = data;
  }
  void CLC(){
    bus.cpu.Carry = false;
    bus.cpu.A = 0;
  }
  void JMPA0(){
    if(bus.cpu.A == 0){
      byte b = bus.rom.data[bus.cpu.RomPointer];
      byte data = byte(b & 0b1111);
      bus.cpu.RomPointer = byte(data - 1);
    }
  }
  void JMPA1(){
    if(bus.cpu.A != 0){
      byte b = bus.rom.data[bus.cpu.RomPointer];
      byte data = byte(b & 0b1111);
      bus.cpu.RomPointer = byte(data - 1);
    }
  }
  void JMPC0(){
    if(!bus.cpu.Carry){
      byte b = bus.rom.data[bus.cpu.RomPointer];
      byte data = byte(b & 0b1111);
      bus.cpu.RomPointer = byte(data - 1);
    }
  }
  void JMPC1(){
    if(bus.cpu.Carry){
      byte b = bus.rom.data[bus.cpu.RomPointer];
      byte data = byte(b & 0b1111);
      bus.cpu.RomPointer = byte(data - 1);
    }
  }
  void reset(){
    bus.ram.reset();
    bus.rom.reset();
    bus.cpu.reset();
  }
}
