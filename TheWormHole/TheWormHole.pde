// This project was built during a three days workshop at Processing Paris 2013.
// The Wormhole is a common project with the participants. 
// Everybody could build a “scene” which would then be thrown into the “wormhole”... 
// The idea was to build a visual system where it would be possible to swicth
// from one scene to the other by moving a camera in 3d space. 
// Each scene could eventually be controlled over the network from the authors 
// computer with a custom controller. 
// The end result looked more like a colorful version of The Abyss 
// with multiple instances of different smaller objects instead of more complex scenes. 
// The controller part was also dropped because of time running out.
//
// Controls:
// See the mouse and keyboard event methods.

import processing.net.*;

final static int PORT = 12345;
final static String END = "\n"; 

int mx, my;
Server server;
WormManager wormHole;
Camera cam;

void setup() {

  size(displayWidth, displayHeight, OPENGL);
  frameRate(60);

  PFont f = loadFont("AmericanTypewriter-32.vlw");
  textFont(f, 12);

  server = new Server(this, PORT);
  println("----------------------------------");
  println("server IP: " + server.ip());
  println("server PORT: " + PORT);

  wormHole = new WormManager(this);
  cam = new Camera();
  cam.setTargets(wormHole.getWorms());
}

void mouseDragged() {
  float delta = (pmouseX - mouseX) * 0.01; 
  cam.setAngle(cam.getAngle() + delta);

  float rad = 250 + (float) mouseY / height * 5000;
  cam.setRadius(rad);
}

void keyPressed() {
  if (key == 'd') wormHole.drawAxis = !wormHole.drawAxis;
  else if (key == 'i') wormHole.drawInfo = !wormHole.drawInfo;
  else if (key == 'x') wormHole.killAll();  
  else if (key == ' ') wormHole.addWorm(); 
  else if (keyCode == RIGHT) {
    wormHole.nextWorm();
    cam.forgetTarget();
  }
  else if (keyCode == LEFT) {
    wormHole.prevWorm();
    cam.forgetTarget();
  }
  else if (keyCode == UP) cam.nextTarget();
  else if (keyCode == DOWN) cam.prevTarget();
  else if (key == 'f') cam.forgetTarget();
}

void draw() {
  //serverLoop();

  background(255);
  cam.interpolate();
  cam.apply();
  wormHole.draw();
} 
/*
void serverLoop() {
  Client c = server.available();
  if (c != null && c.available() > 0) {
    String message = c.readString();
    String[] s = split(trim(message), END);
    for (int i=0; i<s.length; i++) {
      String[] m = split(s[i], " ");
      if (m.length == 2) {
        String type = m[0];
        String val = m[1];         
        // parsing          
        if (type.equals("mx")) mx = int(val);
        else if (type.equals("my")) my = int(val);
      }
    }
  }
}
*/
