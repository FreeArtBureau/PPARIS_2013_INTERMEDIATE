public class SBSauce extends Worm {

  PVector vitesseRot;
  PVector vitessePos;
  Poly ball;

  public SBSauce () {    
    name = "Sauce";
    author = "Souley";
    
    int sub = int(random(3));
    ball = new Poly(random(50, 100), sub);
    vitesseRot =new PVector(random(-0.03, 0.03), random(-0.03, 0.03), random(-0.03, 0.03));  
    vitessePos =new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
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
    stroke(255, 50);
    ball.draw();
  }
}

//----------------------------------Class Triangle ----------------------------

class Face {
  PVector a, b, c;
  color col1;
  Face(PVector a, PVector b, PVector c) {
    this.a = a;
    this.b = b;
    this.c = c;
    col1 = color(220,random(255),random(120,255),120);
  }
}

class Poly {

  float radius;
  PVector pos;
  PVector rot;

  ArrayList <PVector> vertices;  
  ArrayList <Face> faces;  

  Poly(float radius, int subdivisions) {
    this.radius = radius;
    build(subdivisions);
    pos = new PVector();
    rot = new PVector();
  }

  void build(int subdivisions) {
    vertices = new ArrayList();
    faces = new ArrayList();

    float r = 1;
    float t = (1 + sqrt(5)) / 2 * r;

    v(-r, t, 0);
    v( r, t, 0);
    v(-r, -t, 0);
    v( r, -t, 0);

    v( 0, -r, t);
    v( 0, r, t);
    v( 0, -r, -t);
    v( 0, r, -t);

    v( t, 0, -r);
    v( t, 0, r);
    v(-t, 0, -r);
    v(-t, 0, r);

    // 5 faces around point 0
    f(0, 11, 5);
    f(0, 5, 1);
    f(0, 1, 7);
    f(0, 7, 10);
    f(0, 10, 11);

    // 5 adjacent faces
    f(1, 5, 9);
    f(5, 11, 4);
    f(11, 10, 2);
    f(10, 7, 6);
    f(7, 1, 8);

    // 5 faces around point 3
    f(3, 9, 4);
    f(3, 4, 2);
    f(3, 2, 6);
    f(3, 6, 8);
    f(3, 8, 9);

    // 5 adjacent faces
    f(4, 9, 5);
    f(2, 4, 11);
    f(6, 2, 10);
    f(8, 6, 7);
    f(9, 8, 1);


    for (int j=0; j < subdivisions; j++) {
      int n = faces.size(); // must be outside of the for
      for (int i=0; i<n; i++) {
        Face f = faces.get(i);
        PVector a = subd(f.a, f.b);
        PVector b = subd(f.b, f.c);
        PVector c = subd(f.c, f.a);

        vertices.add(a);
        vertices.add(b);
        vertices.add(c);

        faces.add(new Face(f.a, a, c));
        faces.add(new Face(f.b, b, a));
        faces.add(new Face(f.c, c, b));
        faces.add(new Face(a, b, c));
      }

      for (int i=0; i<n; i++) { // not very optimized
        faces.remove(0);
      }
    }
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    beginShape(TRIANGLES);
    noStroke();
    for (Face f : faces) {
      fill(f.col1);
      vertex(f.a.x, f.a.y, f.a.z);
      vertex(f.b.x, f.b.y, f.b.z);
      vertex(f.c.x, f.c.y, f.c.z); 
    }
    
    endShape();
    popMatrix();
  }

  // -----------------------------------------------------------------

  Face f(int a, int b, int c) {
    Face f = new Face(vertices.get(a), vertices.get(b), vertices.get(c));
    faces.add(f);
    return f;
  }

  PVector subd(PVector v1, PVector v2) {  
    PVector t = PVector.sub(v2, v1);
    t.mult(0.5);
    t.add(v1);
    return v(t.x, t.y, t.z);
  }

  PVector v( float x, float y, float z ) {
    PVector vert = new PVector( x, y, z );
    vert.normalize();
    vert.mult(radius); //need to pass this as a param...
    vertices.add(vert);
    return vert;
  }
}

