public class AGSnake extends Worm {
  
  PMatrix mat;
  float speed;
  PVector ang;
  ArrayList<PVector> points;
  int maxLength;
  float largeur;
  float nervous;
  float noiseDet;
  public AGSnake() {
    author = "Andreas";
    name = "WormSnake";

    points = new ArrayList();
    mat = new PMatrix3D();
    mat.rotateX(random(TWO_PI));
    mat.rotateY(random(TWO_PI));
    mat.rotateZ(random(TWO_PI));

    ang = new PVector();
    speed = random(4, 8);
    maxLength = (int) random(300, 1000);
    largeur = random(15, 30);
    nervous = random(0.2, 0.6);
    noiseDet = random(0.0001, 0.005);
  }

  void update() {
    
    ang.x = (noise(pos.z * noiseDet) - 0.5) * 0.15;
    ang.y = (noise(pos.x * noiseDet) - 0.5) * 0.15;
    ang.z = (noise(pos.y * noiseDet) - 0.5) * 0.15;
    
    // position
    mat.mult(new PVector(0, 0, 0), pos);

    PVector temp = new PVector();
    mat.mult(new PVector(-largeur, 0, 0), temp);
    points.add(temp.get());
    mat.mult(new PVector(largeur, 0, 0), temp);
    points.add(temp.get());

    if (points.size() > maxLength) {
      points.remove(0);
      points.remove(0);
    }
    mat.translate(0, 0, speed);
    mat.rotateX(ang.x);
    //mat.rotateY(ang.y);
    mat.rotateZ(ang.z);    
  }

  void draw() {
    stroke(0);
    fill(255);
    beginShape(QUAD_STRIP);
    for (PVector v : points) {
      vertex(v.x, v.y, v.z);
      v.x += random(-nervous, nervous);
      v.y += random(-nervous, nervous);
      v.z += random(-nervous, nervous);
    }
    endShape();
  }
}
