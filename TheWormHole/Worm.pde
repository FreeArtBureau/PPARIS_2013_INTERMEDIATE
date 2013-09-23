public abstract class Worm {
  WormManager manager;
  int count = 0;
  PVector pos, sca, rot;
  PVector screenPos;
  String author = "Anonymous";
  String name = "Unknown";
  int life;


  public Worm() {
    pos = new PVector();
    rot = new PVector();
    sca = new PVector(1, 1, 1);
    screenPos = new PVector(); 
    life = (int) random(5000, 6000);
  }

  public void setManagerReference(WormManager manager) {
    this.manager = manager;
  }

  public void setPos(PVector pos) {
    this.pos = pos.get();
  }

  PVector getPos() {
    return pos.get();
  }

  // Raccourci pour appliquer les trois vecteurs de transformation
  public void applyTransforms() {
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    scale(sca.x, sca.y, sca.z);
  }


  public void setPos(float x, float y, float z) {
    this.pos.set(x, y, z);
  }

  public void drawAxis() {
    float l = 100;
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    stroke(255, 0, 0);
    line(0, 0, 0, l, 0, 0);
    stroke(0, 255, 0);
    line(0, 0, 0, 0, l, 0);
    stroke(0, 0, 255);
    line(0, 0, 0, 0, 0, l);
    popMatrix();
  }

  void preDraw() {
    pushMatrix();
    pushStyle();
  }

  void postDraw() {
    popMatrix();
    popStyle();
    screenPos.x = screenX(pos.x, pos.y, pos.z);
    screenPos.y = screenY(pos.x, pos.y, pos.z);
    screenPos.z = screenZ(pos.x, pos.y, pos.z);
    println(screenPos.z);

    count++;
    life--;
  }  

  void showInfo() {
    float ox = 70;
    float oy = -70;
    String info = name + "\n";
    info += author + "\n";
    info += "Life: " + life + "\n";

    noFill();

    stroke(0, 100);
    line(screenPos.x + 2, screenPos.y - 2, screenPos.x + ox, screenPos.y + oy);

    fill(0, 100); 
    ellipse(screenPos.x, screenPos.y, 6, 6);    
    text(info, screenPos.x + ox + 6, screenPos.y +oy);
  }

  abstract void draw();
  abstract void update();
}

