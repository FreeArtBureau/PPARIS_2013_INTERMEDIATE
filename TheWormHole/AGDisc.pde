public class AGDisc extends Worm {

  color col1, col2;
  float r1, r2, h;
  float f1, f2, fh;
  PVector[] lookUp;
  
  PVector vpos, vrot;
  
  public AGDisc() {
    author = "Andreas";
    name = "MiniDisco";

    rot.x = random(TWO_PI);
    rot.y = random(TWO_PI);
    rot.z = random(TWO_PI);
    
    vrot = new PVector(random(-0.01,0.01),random(-0.01,0.01),random(-0.01,0.01));
    vpos = new PVector(random(-2,2),random(-2,2),random(-2,2));

    int num = (int) random(6, 100);
    r1 = random(50, 100);
    r2 = random(50, 100);
    h = random(10, 170);
    
    f1 = random(0.01, 0.03);
    f2 = random(0.01, 0.03);
    fh = random(0.004, 0.008); 
    
    //h = 0;
    col1 = color(random(255), random(255), random(255));
    col2 = color(random(255), random(255), random(255));

    lookUp = new PVector[num*2];
    float arc = TWO_PI / (num*2);
    for (int i=0; i<num*2; i++) {
      float a = arc * i;
      lookUp[i] = new PVector(cos(a), sin(a), 0);
    }
  }

  void update() {
    pos.add(vpos);
    rot.add(vrot);
  }

  void draw() {
    applyTransforms();    

    noStroke();    
    
    //float ra = map(sin(count * f1),-1,1, r1 * 0.5, r1);
    //float rb = map(sin(count * f2),-1,1, r1 * 0.5, r2);
    //float hauteur = sin(count * fh) * h; 
    float ra = r1;
    float rb = r1;
    float hauteur = h;

    beginShape(QUADS);
    int n = lookUp.length;
    for (int i=0; i<n; i += 2) {
      int j = (i + 1) % n;      
      fill(col1);
      vertex(lookUp[i].x*ra, lookUp[i].y*ra, -hauteur);
      vertex(lookUp[j].x*ra, lookUp[j].y*ra, -hauteur);      
      fill(col2);
      vertex(lookUp[j].x*rb, lookUp[j].y*rb, hauteur);
      vertex(lookUp[i].x*rb, lookUp[i].y*rb, hauteur);
    }
    endShape();
  }
}

