public class AGDonut extends Worm {
  PShape donut;
  PVector vitesseRot;
  PVector vitessePos;

  public AGDonut() {
    float r1 = random(51, 100);
    float r2 = random(20, 49);

    color c1 = color(random(255), random(255), random(255));
    color c2 = color(random(255), random(255), random(255));
    
    int s1 = (int) random(16, 32) * 2;
    
    donut = torus(r1, r2, s1, 32, c1, c2);
    vitesseRot =new PVector(random(-0.05, 0.05), random(-0.05, 0.05), random(-0.05, 0.05));  
    vitessePos =new PVector(random(-2, 2), random(-2, 2), random(-2, 2));
  }

  void update() {
    rot.add(vitesseRot);
    pos.add(vitessePos);
  }

  void draw() {
    applyTransforms();
    shape(donut, 0, 0);
  }
  
  PShape torus(float r1, float r2, int s1, int s2, color col1, color col2) {
    float arc1 = TWO_PI / s1;
    float arc2 = TWO_PI / s2;
    ArrayList <PVector>  points = new ArrayList();

    for (int j=0; j<s1; j++) {
      float a1 = arc1 * j;
      for (int i=0; i<s2; i++) {
        float a2 = arc2 * i;
        float pz = sin(a2) * r2;
        float px = (r1 + cos(a2) * r2) * cos(a1);      
        float py = (r1 + cos(a2) * r2) * sin(a1);  
        points.add(new PVector(px, py, pz));
      }
    }

    int num = s1 * s2;
    PVector v1, v2, v3, v4;

    PShape s = createShape();
    s.beginShape(QUADS);
    s.noStroke();

    for (int j=0; j<s1; j++) {
      if (j % 2 == 0) s.fill(col1);
      else s.fill(col2);
      for (int i=0; i<s2; i++) {
        int p1 = j * s2 + i;
        int p2 = j * s2 + (i + 1) % s2;
        int p3 = (p2 + s2) % num;
        int p4 = (p1 + s2) % num;

        v1 = points.get(p1);
        v2 = points.get(p2);
        v3 = points.get(p3);
        v4 = points.get(p4);

        s.vertex(v1.x, v1.y, v1.z);
        s.vertex(v2.x, v2.y, v2.z);
        s.vertex(v3.x, v3.y, v3.z);
        s.vertex(v4.x, v4.y, v4.z);
      }
    }
    s.endShape();
    return s;
  }
}

