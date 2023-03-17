class Disassembler{
  ROM rom = new ROM();
  
  Disassembler(ROM rom){
    this.rom = rom;
  }
  
  String Disasm(int num){
    String str = "$> ";
    
    byte by = rom.data[num];
    byte hby = byte((0b11110000 & by) / 0b10000);
    switch(hby){
      case 0x0:str += "NOP";break;
      case 0x1:str += "PUSH";break;
      case 0x2:str += "POP";break;
      case 0x3:str += "JUM";break;
      case 0x4:str += "COP A X";break;
      case 0x5:str += "COP A Y";break;
      case 0x6:str += "COP X A";break;
      case 0x7:str += "COP Y A";break;
      case 0x8:str += "ADD X";break;
      case 0x9:str += "ADD Y";break;
      case 0xA:str += "LDA";break;
      case 0xB:str += "CLC";break;
      case 0xC:str += "JMP if A==0";break;
      case 0xD:str += "JMP if Carry==0";break;
      case 0xE:str += "JMP if A!=0";break;
      case 0xF:str += "JMP if Carry!=0";break;
      
    }
    
    return str;
  }
}
