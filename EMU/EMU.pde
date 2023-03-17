import controlP5.*;
boolean isStarted = false;

PC pc = new PC();
Interface inface = new Interface(pc.bus.cpu,pc.bus.rom,pc.bus.ram);
Disassembler disasm = new Disassembler(pc.bus.rom);
ControlP5 cp5;

void setup(){
  frameRate(100);
  size(800,600);
  cp5 = new ControlP5(this);
  cp5.addButton("step").setLabel("step").setPosition(20,450).setSize(150,30);
  cp5.addButton("reset").setLabel("reset").setPosition(20,490).setSize(150,30);
  cp5.addButton("load").setLabel("load").setPosition(20,530).setSize(150,30);
  cp5.addButton("run").setLabel("run").setPosition(200,450).setSize(150,30);
  cp5.addButton("stop").setLabel("stop").setPosition(200,490).setSize(150,30);
  pc.loadData();
  inface.drawInface();
}
void draw(){
  inface.drawInface();
  if(isStarted){
    frameRate(10);
    pc.tick();
  }
}
void step(){
  pc.tick();
}
void reset(){
  pc.reset();
}
void load(){
  pc.loadData();
}
void run(){
  isStarted = true;
}
void stop(){
  isStarted = false;
}
