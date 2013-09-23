public class SIPopWorm extends Worm {
  PVector bPos=new PVector(1, 1, 1);
  color col1, col2;

  float distance() {
    return PVector.dist(bPos, pos);
  }

  boolean tresProche() {
    return (distance()<=5)  ;
  }

  float damping;
  int rayon;
  int MAG=400;
  int nbLimAile;
  int nbMaxAile;

  public SIPopWorm() {

    author = "Fred SIgnard";
    name = "popWorm";

    rot.set(random(0, 1), random(0, 1), random(0, 1));
    bPos.set(pos.get());
    unPasDePlus() ;   
    damping = random(0.01, 0.1);
    col1 = color(random(150, 200), random(255), random(255));
    int r=(int)(col1 >> 16) & 0xFF;
    int v=(int)(col1 >> 8) & 0xFF;
    int b=(int)(col1 >> 0) & 0xFF;
    col2 = color(r, v*.2, b*.2);
    rayon=15;
    nbMaxAile=8;
    nbLimAile=(int)random(1, nbMaxAile+1);
  }

  void update() {

    if (tresProche()) {
      unPasDePlus();
    }
    else step();
    //      println("step()"+ "");
  }

  void draw() {

  // dessiner les ressorts
  float ressort=500*(1/distance());
    noFill();
    for (int i=nbLimAile; i<= nbMaxAile;i++) {
      stroke(col1, 200/i);
      beginShape();
      vertex(pos.x, pos.y, pos.z);
      bezierVertex(pos.x-ressort*i, pos.y, pos.z, bPos.x-ressort*i, bPos.y+50*i, bPos.z, bPos.x, bPos.y, bPos.z);
      endShape();
      //DEBUG stroke(0);
      beginShape();
      vertex(pos.x, pos.y, pos.z);
      bezierVertex(pos.x+ressort*i, pos.y, pos.z, bPos.x+ressort*i, bPos.y+50*i, bPos.z, bPos.x, bPos.y, bPos.z);
      endShape();
    }

    // corps position
    fill(col1, map((int)distance(), 0, MAG, 200, 0));
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    for (int i_=0;i_<=6;i_++) {
      rotate(0.2, 3, 3, 3);     
      box(rayon);
    }
    popMatrix();

    // cible cage 
    stroke(col2, 10);
    noFill();
    pushMatrix();
    translate(bPos.x, bPos.y, bPos.z);    
    for (int i_=0;i_<=16;i_++) {
      rotate(0.2, 3, 3, 3);     
      box(rayon);
    } 
    popMatrix();
  }

  void unPasDePlus() {
    bPos.set(random(-2, 1), random(-1, 2), random(-2, 2));
    bPos.mult(400);
  }


  void step() {
    pos.x += (bPos.x - pos.x) * damping;
    pos.y += (bPos.y - pos.y) * damping;
    pos.z += (bPos.z - pos.z) * damping;
  }
}

