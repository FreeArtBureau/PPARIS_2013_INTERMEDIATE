public class FGGlobule extends Worm {

  ArrayList<PVector> points;
  PVector vel, vr;
  color col;
  float offset, radius, mass, G;
  int deform, alpha;


  public FGGlobule() {
    author = "Félicien Goguey";
    name = "Globule";

    vel = new PVector(random(-0.5, 0.5), random(-0.5, 0.5), random(-0.5, 0.5));
    rot = new PVector(random(1), random(1), random(1));
    vr =  new PVector(random(-0.005, 0.005), random(-0.005, 0.005), random(-0.005, 0.005));

    points = new ArrayList();

    radius=random(80, 120);
    mass=200;
    G=10;

    offset=random(100);
    for (int i=0; i<500; i++) {
      PVector v1 = new PVector(map(noise(offset*1, offset*1.1, offset*1.2), 0, 1, -1, 1), 
      map(noise(offset*2, offset*2.1, offset*2.2), 0, 1, -1, 1), 
      map(noise(offset*3.2, offset*3.1, offset*3.3), 0, 1, -1, 1));

      v1.normalize();
      v1.mult(radius);
      points.add(v1);
      offset+=0.01;
    }

    deform = 30;
    alpha=255;
  }

  void update() {
    rot.add(vr);
    pos.add(vel);

    //attract();
  }

  void draw() {
    stroke(0, alpha);
    noFill();
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);


    beginShape();
    for (PVector p : points) {
      //vertex(p.x, p.y, p.z);
      PVector p2 = p.get();
      //p2.normalize();
      //p2.mult(noise(offset*0.012+120, offset*0.05+90, offset*0.09) * 40);
      p2.add(new PVector(noise(p.x+offset*5, p.y+offset*2, p.x+offset)*deform, 
      noise(p.x+offset*3.2, p.y+offset*7.8, p.x+offset)*deform, 
      noise(p.x+offset, p.y+offset*4, p.x+offset*0.2)*deform));
      vertex(p2.x, p2.y, p2.z);
      offset+=0.00001;
    }
    endShape();

    if (life < 255) {
      alpha--;
    }
  }

//  void attract() {
//    ArrayList<FGComet> comets = new ArrayList(manager.getWorms("Comet"));
//    for (FGComet c : comets) {
//      //c.col=color(0, 255, 0);
//      PVector force = PVector.sub(pos, c.pos);
//      float distance=force.mag();
//      distance = constrain(distance, radius+50, 50*radius);
//      
//      force.normalize();
//      float strength=(G*mass*c.mass)/(distance*distance);
//      
//      force.mult(strength);
//      c.applyForce(force);
//    }
//  }
}

