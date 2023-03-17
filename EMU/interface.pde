class Interface{
  Disassembler disasm;
  RAM ram = new RAM();
  ROM rom = new ROM();
  CPU cpu = new CPU();
  Interface(CPU cpu, ROM rom, RAM ram){
    this.cpu = cpu;
    this.rom = rom;
    this.ram = ram;
    disasm = new Disassembler(rom);
  }
  void drawInface(){
    background(0,0,255);
    textSize(30);
    String dataRam = "$> ";
    for(int i = 0; i < ram.data.length; i++){
      dataRam += hex(ram.data[i],1) + " ";
    }
    String dataRom[] = new String[4];
    for(int i = 0; i < 4; i++){
      dataRom[i] = "";
    }
    for(int i = 0; i < 4; i++){
      for(int j = 0; j < 4; j++){
        dataRom[i] += hex(rom.data[j+i*4],2) + " ";
      }
    }
    text("RAM", 10,30);
    text(dataRam, 10,60);
    text("ROM", 10,100);
    text("$> "+dataRom[0], 10,130);
    text("$> "+dataRom[1], 10,160);
    text("$> "+dataRom[2], 10,190);
    text("$> "+dataRom[3], 10,220);
    text("CPU",10,260);
    text("A > " + hex(cpu.A,1),10,290);
    text("X > " + hex(cpu.X,1),10,320);
    text("Y > " + hex(cpu.Y,1),10,350);
    text("Carry > " + cpu.Carry, 10, 380);
    text("PC > " + hex(cpu.RomPointer,1), 10, 410);
    text("DISASSEMBLY",500,30);
    text(disasm.Disasm(0),500,60);
    text(disasm.Disasm(1),500,90);
    text(disasm.Disasm(2),500,120);
    text(disasm.Disasm(3),500,150);
    text(disasm.Disasm(4),500,180);
    text(disasm.Disasm(5),500,210);
    text(disasm.Disasm(6),500,240);
    text(disasm.Disasm(7),500,270);
    text(disasm.Disasm(8),500,300);
    text(disasm.Disasm(9),500,330);
    text(disasm.Disasm(10),500,360);
    text(disasm.Disasm(11),500,390);
    text(disasm.Disasm(12),500,420);
    text(disasm.Disasm(13),500,450);
    text(disasm.Disasm(14),500,480);
    text(disasm.Disasm(15),500,510);
  }
}
