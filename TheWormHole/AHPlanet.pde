public class AHPlanet extends Worm {
  ArrayList <PVector> points;
  PVector vitesseRot;
  PVector vitessePos;
  color col1, col2;
  float f1, f2, f3;
  float rayon;
  int res;

  public AHPlanet() {

    name = "Planet";
    author = "Hal";

    vitesseRot =new PVector(random(-0.03, 0.03), random(-0.03, 0.03), random(-0.03, 0.03));  
    vitessePos =new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    col1 = color(10, 0, random(100, 255), random(0, 255));
    col2 = color(250, random(100, 255), 0);

    //    col1 = color(255);
    //    col2 = random(1)<0.1 ? color(255,0,0) : color(0);

    f1 = random(0.01, 0.09);
    //f2 = f1 * 1.1;
    //f3 = f1 * 1.1;    
    rayon = random(10, 50);
    res = int(random (3, 10));
  }

  void update() {
    rot.add(vitesseRot);
    pos.add(vitessePos);
  }



  void draw() {



    points = new ArrayList();

    ball();
    //chat();



    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    fill(col1);
    stroke(col2); 
    sphereDetail(res);
    sphere(rayon*2);

    //image(img, 0, 0);

    float h1 = rayon * 0.6666;
    //float h2 = rayon * 0.3333;
    float s1 = sin(count * f1);
    float s2 = sin(count * f2);


    float l1 = map(s1, -1, 1, rayon+1, rayon * 3);
    float l2 = map(s2, -0.5, 0.5, rayon-4, rayon*1.8);
    // float l3 = map(s3, -1, 1, base+1, base * 2); 
    // float l4 = map(s1, -1, 1, base+2, base * 3);
    // float l5 = maol1);
    noFill();
    sphere(l2);
    sphere(l1);

    pushMatrix();
    translate(pos.x*0.2, pos.y*0.2, pos.z*0.2);
    stroke(col1);
    sphere(l2);
    fill(col2, 100);
    sphere(l1);
    popMatrix();


    sphereDetail(50);
    stroke(col2);
    beginShape(LINES);
    for (PVector p : points) vertex(p.x, p.y, p.z);
    endShape();
  }


  //  void chat(){
  //     img = loadImage("chat.png"); 
  //  }

  void ball() {
    for (int i=0; i<200; i++) {
      PVector v1 = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));

      v1.normalize();
      PVector v2 = v1.get();    
      v1.mult(100);
      v2.mult(12);
      points.add(v1);
      points.add(v2);
    }
  }
}

