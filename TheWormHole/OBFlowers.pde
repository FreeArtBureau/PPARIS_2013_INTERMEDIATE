public class OB extends Worm {

  PVector vr;
  PVector vit;
  PVector vpos, vrot;

  //Forme
  ArrayList <PVector> forme1;
  ArrayList <PVector> forme2;
  ArrayList <PVector> forme3;

  //color
  color col1, col2;




  ///////////////////////////////////////////////////////////////////////////////////////////

  public OB() {
    author = "Olivier";
    name = "Particles";

    vr = new PVector();    
    vr.x = random(-0.01, 0.01);
    vr.y = random(-0.01, 0.01);
    vr.z = random(-0.01, 0.01);    
    vit = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));

    //Rotations et vitesses
    vrot = new PVector(random(-0.01, 0.01), random(-0.01, 0.01), random(-0.01, 0.01));
    vpos = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));

    //color
    col1 = color(random(255), random(255), random(255));
    col1 = color(0);
    float R1 = map(sin(frameCount * 0.01 + 10), -1, 1, 0, 255);
    float G1 = map(sin(frameCount * 0.02 + 10), -1, 1, 0, 255);
    float B1 = map(sin(frameCount * 0.03 + 10), -1, 1, 0, 255); 

    col2 = color(random(255), random(255), random(255));
    col2 = color(0);
    float R2 = map(sin(frameCount * 0.011), -1, 1, 0, 255);
    float G2 = map(sin(frameCount * 0.021), -1, 1, 0, 255);
    float B2 = map(sin(frameCount * 0.031), -1, 1, 0, 255); 

    col1 = color(R1, G1, B1);
    col2 = color(R2, G2, B2);


    //Forme1 = lignes
    forme1 = new ArrayList();
    //nombre de points crées
    for (int i=0; i<1000; i++) {
      PVector v1 = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
      v1.normalize();
      PVector v2 = v1.get();
      v1.mult(100);  //taille = max 220
      v2.mult(random(100, 150));
      forme1.add(v1);
      forme1.add(v2);
    }


    //Forme2 = points
    forme2 = new ArrayList();
    //nombre de points crées
    for (int i=0; i<100; i++) {
      PVector v1 = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
      v1.normalize();
      PVector v2 = v1.get();
      v1.mult(50);  //taille = max 220
      v2.mult(55);
      forme2.add(v1);
      forme2.add(v2);
    }
  }


    ///////////////////////////////////////////////////////////////////////////////////////////

    void update() {
      rot.add(vrot);  //rotations
      pos.add(vpos);  //vitesses
    }


    ///////////////////////////////////////////////////////////////////////////////////////////

    void draw() {

      //Deplacement et rotation de forme
      translate(pos.x, pos.y, pos.z);
      rotateX(rot.x * 0.01);
      rotateY(rot.y * 0.01);

      //rotation des formes avec la souris
      rotateX(pos.x * 0.01);
      rotateY(pos.y * 0.01);


      //forme1
      beginShape(LINES);
      stroke(col1);
      strokeWeight(0.5);
      for (PVector f1 : forme1) {
        vertex(f1.x, f1.y, f1.z);
      }
      endShape();


      //forme2
      beginShape(POINTS);
      //stroke(255, 0, 0);
      stroke(col2);
      strokeWeight(random(1, 3));
      for (PVector f2 : forme2) { 
        vertex(f2.x, f2.y, f2.z);
        f2.x += random(-5, 5);
        f2.y += random(-5, 5);
        f2.z += random(-5, 5);
      }
      endShape();

    }
  }









