public class AGBox extends Worm {

  PVector vitesseRot;
  PVector vitessePos;
  color col1, col2;
  float f1, f2, f3;
  float base;

  public AGBox() {    
    name = "BoomBox";
    author = "Andreas";
    
    vitesseRot =new PVector(random(-0.03, 0.03), random(-0.03, 0.03), random(-0.03, 0.03));  
    vitessePos =new PVector(random(-2, 2), random(-2, 2), random(-2, 2));

    col1 = color(random(255), random(255), random(255));
    col2 = color(random(255), random(255), random(255));
    
    f1 = random(0.04, 0.2);
    f2 = f1 * 1.1;
    f3 = f1 * 1.1;    
    base = random(20, 120);
  }

  void update() {
    rot.add(vitesseRot);
    pos.add(vitessePos);
  }

  void draw() {
    noStroke();        
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    fill(col1);
    box(base, base, base);
    fill(col2);
    
    float h1 = base * 0.6666;
    float h2 = base * 0.3333;
    
    float s1 = sin(count * f1);
    float s2 = sin(count * f2);
    float s3 = sin(count * f3);
    
    float l1 = map(s1, -1, 1, base+1, base * 2);
    float l2 = map(s2, -1, 1, base+1, base * 2);
    float l3 = map(s3, -1, 1, base+1, base * 2); 
    float l4 = map(s1, -1, 1, base+2, base * 3);
    float l5 = map(s2, -1, 1, base+2, base * 3);
    float l6 = map(s3, -1, 1, base+2, base * 3); 

    box(l1, h1, h1);
    box(h1, l2, h1);
    box(h1, h1, l3);
    
    fill(col1);
    box(l4, h2, h2);
    box(h2, l5, h2);
    box(h2, h2, l6);    
  }
}

