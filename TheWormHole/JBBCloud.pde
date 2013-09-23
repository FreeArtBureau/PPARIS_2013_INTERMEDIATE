public class JBBCloud extends Worm {

  float[] tailles;
  int[] couls;
  ArrayList<PVector> vects;
  float taille = 20;
  int numL, numH, delai;
  PVector vitessePos, vitesseRot;
  color col1;

  public JBBCloud() {
    author = "JBB";
    name = "Cloud";

    vitesseRot =new PVector(random(-0.003, 0.003), random(-0.003, 0.003), random(-0.003, 0.003)); 
    vitessePos =new PVector(random(-0.1, 0.1), random(-0.1, 0.1), random(-0.3, 0.3));

    rot.x = random(TWO_PI);
    rot.y = random(TWO_PI);
    rot.z = random(TWO_PI);

    delai = int(random(8, 20));
    numL = (int) random(2, 10);
    numH = (int) random(2, 10);

    tailles = new float[numL*numH];
    for (int i=0; i<tailles.length; i++) {
      tailles[i] = taille;
    }
    couls = new int[numL*numH];
    for (int i=0; i<couls.length; i++) {
      couls[i] = int (random(10, 110));
    }
    vects = new ArrayList();
    for (int i=0; i<numL*numH; i++) {
      PVector v = new PVector(0, 0, random(10));
      vects.add(v.get());
    }
  }

  void update() {

    pos.add(vitessePos);
    rot.add(vitesseRot);

    if (frameCount %delai == 0) {
      for (PVector v : vects) {
        // v.x += random(-2, 2);
        // v.y += random(-2, 2);
        v.z += random(-10, 10);
      }

      int vcount = 0;
      for (PVector v : vects) {
        vcount++;
        if (v.z < -taille || v.z>taille) {
          float dist = taille- (abs(v.z)-taille)*0.2;
          if (dist >=0) {
            tailles[vcount-1] = dist;
          }
        }
        else {
          tailles[vcount-1] = taille;
        }
      }
    }
  }

  void draw() {
    applyTransforms();  

    noStroke();
    fill(0);

    translate(pos.x-(numH*taille)/3, pos.y-(numL*taille)/3, pos.z);
    //stroke(0);
    //noFill();

    for (int i=0; i<numH-1; i++) {
      for (int j=0; j<numL-1; j++) {

        noStroke();
        fill(couls[j+i*numL]);

        pushMatrix();
        translate(i*taille-pos.x, j*taille-pos.y, vects.get(j+i*numL).z-pos.z);
        box(tailles[j+i*numL], tailles[j+i*numL], tailles[j+i*numL]);
        popMatrix();

        pushMatrix();
        stroke(255, 0, 0, 40);
        noFill();
        translate(i*taille-pos.x, j*taille-pos.y, -pos.z);
        box(taille, taille, taille);
        popMatrix();
      }
    }
  }
}

