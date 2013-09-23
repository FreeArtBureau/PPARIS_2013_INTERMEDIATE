public class FGComet extends Worm {

  PVector vel, vr;
  PMatrix mat;
  color col;
  ArrayList<PVector> points;
  int queueLength;
  float alpha, mass;

  public FGComet() {
    author = "Félicien Goguey";
    name = "Comet";

    pos = new PVector(random(-200, 200), random(-200, 200), random(-200, 200));
    vel = new PVector(random(-2, 2), random(-2, 2), random(-2, 2));
    rot = new PVector(random(1), random(1), random(1));
    vr =  new PVector(random(0.01), random(0.01), random(0.01));

    mat = new PMatrix3D();
    points = new ArrayList();

    if (random(10)>9) {
      col=  color(255, 0, 0);
    }
    else {
      col=  color(0);
    }

    queueLength = (int)random(30, 60);

    alpha=255;
    mass=1;
  }

  void update() {
    //pos.add(vel);
  }

  void draw() {


    PVector t = new PVector();

    mat.mult(new PVector(0, 0, 0), t);
    points.add(t.get());
    pos=t.get();



    if (points.size() > queueLength) {
      points.remove(0);
    }
    float offset=frameCount;
  

    mat.rotateX(vr.x+map(noise(offset*10), 0, 1, -0.2, 0.2));
    mat.rotateY(vr.y+map(noise(offset), 0, 1, -0.2, 0.2));
    mat.rotateZ(vr.z+map(noise(offset), 0, 1, -0.2, 0.2));

    mat.translate(vel.x, vel.y, vel.z);

    // affichage  
    noFill();
    stroke(col);
    

    strokeWeight(1);
    //queue
    beginShape();
    alpha=1;
    for (PVector v : points) {
      vertex(v.x, v.y, v.z);
      stroke(col, alpha+=4);
    }
    endShape();
    
    strokeWeight(4);
    //tête
    point(points.get(points.size()-1).x, points.get(points.size()-1).y, points.get(points.size()-1).z);
    strokeWeight(3);
    if (points.size() > 2) point(points.get(points.size()-2).x, points.get(points.size()-2).y, points.get(points.size()-2).z);
    strokeWeight(2);
    if (points.size() > 3) point(points.get(points.size()-3).x, points.get(points.size()-3).y, points.get(points.size()-3).z);
  }
  
//  void applyForce(PVector force){
//    PVector f = PVector.div(force,mass);
//    //vel.mult(0);
//    vel.add(f);
//    
//  }
}

