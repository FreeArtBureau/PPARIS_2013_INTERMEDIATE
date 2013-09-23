public class AGSpray extends Worm {

  ArrayList<Particle> particles = new ArrayList();
  PShape particleShape = createShape(PShape.GROUP);
  float offs;
  float vit;

  public AGSpray() {    
    name = "Sprayer";    
    author = "Andreas";
    offs = random(100);
    particles = new ArrayList();
    vit = random(2, 4);    
    int num = (int) random(800, 1500);
    for (int i = 0; i < num; i++) {
      Particle p = new Particle(pos);
      particles.add(p);
      particleShape.addChild(p.getShape());
    }
  }

  void update() {
    pos.x += (noise(pos.y*0.01, offs) -0.5) * vit;
    pos.y += (noise(pos.z*0.01, offs) -0.5) * vit;
    pos.z += (noise(pos.x*0.01, offs) -0.5) * vit;

    for (Particle p : particles) {
      p.update();
      if (p.isDead()) p.rebirth(pos);
    }
  }

  void draw() {
    shape(particleShape);
  }

  //------------------------------------------------------------------
  class Particle extends PVector {
    PShape part;
    PVector vel;
    float damp;
    float sq;

    Particle(PVector p) {
      float size = random(2, 3);
      PVector a = PVector.random3D();
      PVector b = PVector.random3D();
      PVector c = PVector.random3D();
      a.mult(size);
      b.mult(size);
      c.mult(size);

      part = createShape();
      part.beginShape(TRIANGLES);
      part.noStroke();
      part.fill(0);
      part.vertex(a.x, a.y, a.z );
      part.vertex(b.x, b.y, b.z );
      part.vertex(c.x, c.y, c.z );
      part.endShape();

      rebirth(p);
    }

    PShape getShape() {
      return part;
    }

    void rebirth(PVector p) {  
      damp = random(0.98, 0.99);    
      vel = PVector.random3D();
      vel.mult(random(0.5, 1));
      part.resetMatrix();
      part.translate(p.x, p.y, p.z);
    }

    boolean isDead() {
      if (sq < 0.01)  return true;
      return false;
    }

    public void update() {
      vel.mult(damp);
      //part.setTint(color(255, lifespan));
      part.translate(vel.x, vel.y, vel.z);
      sq = pow(vel.x, 2) + pow(vel.y, 2) + pow(vel.z, 2);      
    }
  }
}
