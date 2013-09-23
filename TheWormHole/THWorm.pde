public class THWorm extends Worm {

  PVector vitesseRot;
  PVector vitessePos;
  PVector vsiz;
  color col;
  float r, g, b;
  float u;
  boolean pulse = false;
  int w;
  float base;

  public THWorm() {
    name = "Stars";
    author = "Tobias";
    
    boolean pulse = false;
    vitesseRot =new PVector(random(-0.03, 0.03), random(-0.03, 0.03), random(-0.03, 0.03));  
    vitessePos =new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    //    vsiz = new PVector(random(50,500),random(50,500));
    vsiz = new PVector(1, 1);
    base = random(20, 120);
  }

  void update() {
    rot.add(vitesseRot);
    pos.add(vitessePos);
    if (pulse) {
      vsiz.x = vsiz.x + .5*(frameRate*.001);
      if (vsiz.x > 10) {
        pulse = false;
      }
    } 
    else {
      vsiz.x = vsiz.x - .5*(frameRate*.001);
      if (vsiz.x < 1) {
        pulse = true;
      }
    }
  }

  void draw() {
    col= color(r, g, b);
    r = 255-noise(1+frameCount*.25)*255;
    g = frameCount % 255;
    b = noise(frameCount*.01)*255;

    noStroke();
    fill(r, g, b,75);


    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    float s1 = sin(u)*cos(u);
    float p1 = map(s1, -1, 1, base+1, base * 2);
    //    for (w=0; w<1; w++){
    //ellipse(0, 0, vsiz.x, vsiz.x);

    beginShape();
    vertex(0*vsiz.x+p1, -50*vsiz.x);
    vertex(14*vsiz.x+p1, -20*vsiz.x);
    vertex(47*vsiz.x+p1, -15*vsiz.x);
    vertex(23*vsiz.x+p1, 7*vsiz.x);
    vertex(29*vsiz.x+p1, 40*vsiz.x);
    vertex(0*vsiz.x+p1, 25*vsiz.x);
    vertex(-29*vsiz.x+p1, 40*vsiz.x);
    vertex(-23*vsiz.x+p1, 7*vsiz.x);
    vertex(-47*vsiz.x+p1, -15*vsiz.x);
    vertex(-14*vsiz.x+p1, -20*vsiz.x);
    endShape(CLOSE);

    //      w+= random(.015, .02);
    println(pulse);
    //    }
  }
}

