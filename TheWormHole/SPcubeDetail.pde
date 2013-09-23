
public class SPcubeDetail extends Worm {


  PVector vr;
  PVector vit;

  ArrayList <PVector> points;
  ArrayList <Particle> particles;


  public SPcubeDetail() {

    author = "Stephane";
    name = "cubeDetail";


    vr = new PVector();    
    vr.x = random(-0.02, 0.02);
    vr.y = random(-0.02, 0.02);
    vr.z = random(-0.02, 0.02);    
    vit = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));

    ///

    points = new ArrayList();
    particles = new ArrayList();
  }

  void update() {
    rot.add(vr);
    pos.add(vit);

    for (int i=0; i<10; i++) {
      PVector v = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
      v.normalize();
      v.mult(frameCount%20);
      points.add(v);
      if (points.size() > 300) {
        points.remove(0);
      }
    }
  }

  void draw() {
    noStroke();
    noFill();    
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    scale(1, 1, 1);
    /////////// commence les cubes noirs
    fill(0);
    box(10, random(20, 100), 10);

    fill(0);
    box(10, 10, random(20, 100));

    fill(0);

    if (frameCount%200>150) {


      for (int i=0; i<10; i++) {
        float x = i;
        float y = i;
        particles.add(new Particle(x, y, 0));
      }


      for (int i=particles.size()-1; i>=0; i--) {
        Particle p = particles.get(i);

        p.step();

        //p.draw();
        float f = random(0.3, 0.7);
        translate(f, 0, 0);
        strokeWeight(3);
        line(0, 0, 0, f, f, f);
        if (p.vq < 0.2) particles.remove(p);
      }

      beginShape(POINTS);
      for (Particle p : particles) {
        strokeWeight(2);
        vertex(p.x, p.y, p.z);
      }
      endShape();


      //      
      //   
      //      
      //      for (int i=0; i<500; i++) {
      //        translate(i/100, 0, 0);
      //        fill(255, 0, 0, map(frameCount%2000, 0, 2000, 0, 255));
      //        box(random(20, 100), 10, 10);
      //      }
    }
    else {
      fill(0);
      box(random(20, 100), 10, 10);
    }
    /////////// commence les cubes blancs
    fill(250);
    float l = random(6+frameCount%30, 30);
    box(12, 12, l);
    box(12, l, 12);
    box( l, 12, 12);

    ////////////////////////////////// partie offset
    rotateX(PI*0.25);
    /////////// commence les cubes noirs
    fill(0);
    box(10, random(20, 100), 10);
    fill(0);
    box(10, 10, random(20, 100));

    /////////// commence les cubes blancs
    fill(250);
    float u = random(6+frameCount%30, 30);
    box(12, 12, u);
    box(12, u, 12);


    /////////////////////////////////
    ///////// barres rouges exitées du centre...


    for (PVector p : points) {
      translate (p.x, p.y, p.z);
      fill(random(100, 255), 0, 0, random(10, 100));
      noStroke();
      box(10+ random(5, frameCount%20), 10, 5);
      translate (-p.x, -p.y, -p.z);
    }
  }
}

//---------------------------------- class ------------ 

class Particle extends PVector {

  PVector vel;
  float damp;
  float vq;
  Particle(float x, float y, float z) {
    super(x, y, z);
    vel = PVector.random3D();
    vel.mult(random(1, 4)); // paramettre à modifier...
    damp = random(0.96, 0.98); // amortissement
  }

  void step() {
    this.add(vel);
    vel.mult(damp);
    vq = pow(vel.x, 2) + pow(vel.y, 2) + pow(vel.y, 2);
  }

  void draw() {
    //    pushMatrix();
    //    noStroke();
    //    fill(0);
    //    translate(x, y, z);
    //    box(10,10,10);
    //    popMatrix();
    stroke(0);
    point(x, y, z);
  }
}

