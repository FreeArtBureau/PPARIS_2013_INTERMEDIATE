public class JPWorm extends Worm {

  ArrayList <PVector> points;

  PVector vr;
  PVector vit;
  float theta = 0.0;

  public JPWorm() {
    author = "Julia Puyo";
    name = "erizo";

    points = new ArrayList();

    for (int i=0; i<700; i++) {
      PVector v1 = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));

      v1.normalize();
      PVector v2 = v1.get();    
      v1.mult(3);
      v2.mult(50);
      points.add(v1);
      points.add(v2);
    }


    vr = new PVector();    
    vr.x = random(-0.01, 0.01);
    vr.y = random(-0.01, 0.01);
    vr.z = random(-0.01, 0.01);    
    vit = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
  }

  void update() {
    rot.add(vr);
    pos.add(vit);
    theta += 0.009;
  }

  void draw() {


    // planète1 central: tout tourne autour
    noFill();
    //stroke(5);
    strokeWeight(1);
    smooth();
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    //sphereDetail(10);
    //sphere(20);

 float offset = frameCount * 0.03;
    
    beginShape(LINES);
    for (PVector p : points){
    stroke(0);
    vertex(p.x, p.y, p.z);
    PVector p2 = p.get();  // le deuxième point est une copie de tous les premiers
    p2.normalize();   // on normalise le vecteur
    p2.mult(noise(p.x*0.01, p.y*0.01, offset) * 20);   // on le multiplie par noise
    p2.add(p);   // on ajoute au vecteur la coordonnée de la position p du vecteur
    vertex((p2.x), (p2.y), p2.z);
  }
    endShape();

//    // planète2: tourne autour du triangle1 central
//    pushMatrix();
//    beginShape(TRIANGLES);
//    rotate(theta);
//    translate(150, 150, 150);
//
//    noFill();
//    stroke(0);
//    //sphereDetail(10);
//    //sphere(10);
//    
//beginShape(LINES);
//    for (PVector p : points){
//      stroke(100,100,100,100);
//    vertex(p.x, p.y, p.z);
//    PVector p2 = p.get();  // le deuxième point est une copie de tous les premiers
//    p2.normalize();   // on normalise le vecteur
//    p2.mult(noise(p.x*0.001, p.y*0.001, offset) * 10);   // on le multiplie par noise
//    p2.add(p);   // on ajoute au vecteur la coordonnée de la position p du vecteur
//    vertex((p2.x), (p2.y), p2.z);
//  }
//    endShape();
//    endShape();

//
//    // planète autour du planète2
//    pushMatrix();    
//    rotate(-theta*4);
//    translate(35, 0);
//
//
//    noFill();
//    stroke(0);
//    sphereDetail(10);
//    sphere(10);
//    popMatrix();
//
//
//    
//    // tourne autour du planète2
//    pushMatrix(); 
//    rotate(-theta*2);
//    translate(75, 0);
//
//    noFill();
//    stroke(0);
//    sphere(10);
//    popMatrix();
//
//
 //   popMatrix();  // fin du pushMatrix du planete2 autour duquel tournent le 3 et 4
  }
}

