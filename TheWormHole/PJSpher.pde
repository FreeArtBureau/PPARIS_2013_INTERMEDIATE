public class PJSpher extends Worm {

  ArrayList <PVector> points;

  PVector vr;
  PVector vit;
  float d;
  int res;

  public PJSpher() {    
    name = "spheres gribouillis";
    author = "Pierre-Julien Fieux";

    vr = new PVector();    
    vr.x = random(-0.06, 0.06);
    vr.y = random(-0.06, 0.06);
    vr.z = random(-0.06, 0.06);    
    vit = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
  }

  void update() {
    rot.add(vr);
    pos.add(vit);
  }

  void draw() {
    
    points = new ArrayList();
    
    Fadd();
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    ball();
  }
  
  void ball(){
  
  beginShape(LINES);
  for (PVector p : points) {

    stroke(0);
    noFill();

    PVector p2 = p.get();
    p2.rotate(pos.x*0.002);

    
    PVector p3 = p.get();
    p3.rotate(pos.y*0.002);

    
    PVector p4 = p.get();
    p4.rotate(pos.z*0.002);

    curve(p.x, p.y, p.z,p2.x, p2.y, p2.z,p3.x, p3.y, p3.z,p4.x, p4.y, p4.z);

   
  }
  endShape();
  }
  
  

  
  void Fadd(){
    for (int i=0; i<50; i++) {
    PVector v1 = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    v1.normalize();
    v1.mult(100);
    points.add(v1);
  }
}
}

