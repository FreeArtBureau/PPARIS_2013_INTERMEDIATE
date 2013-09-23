public class CDFlower extends Worm {

  color col1, col2, col3;
  float r1, r2;
  float h;
  float vitesse;
  PVector[] lookUp;

  public CDFlower() {
    author = "Camille Dedieu";
    name = "CDFlower";

    pos.x = random(-500, 500);
    pos.y = random(-500, 500);
    pos.z = random(-500, 500);    
    rot.x = random(TWO_PI);
    rot.y = random(TWO_PI);
    rot.z = random(TWO_PI);

    int num = (int) random(6, 100);
    r1 = random(50, 1200);
    r2 = random(50, 1200);
    h = random(10, 2000);
    //h = 0;
    col1 = color(random(200,255), random(200,255), random(200,255));
    col2 = color(random(0,255), random(0,50), random(0,100));
    col3 = color(random(255), random(255), random(255));

    //    col1 = color(0);
    //    col2 = color(0);
    vitesse = random(-0.01, 0.01);


    lookUp = new PVector[num*2];
    float arc = TWO_PI / (num*2);
    for (int i=0; i<num*2; i++) {
      float a = arc * i;
      lookUp[i] = new PVector(cos(a), sin(a), 0);
    }
  }

  void update() {
    rot.z += vitesse;
  }

  void draw() {
    applyTransforms();    

    noStroke();    
    //    float R1 = map(sin(count * 0.01 + 10), -1, 1, 0, 255);
    //    float G1 = map(sin(count * 0.02 + 10), -1, 1, 0, 255);
    //    float B1 = map(sin(count * 0.03 + 10), -1, 1, 0, 255);
    //
    //    float R2 = map(sin(count * 0.011), -1, 1, 0, 255);
    //    float G2 = map(sin(count * 0.021), -1, 1, 0, 255);
    //    float B2 = map(sin(count * 0.031), -1, 1, 0, 255);
    //
    //    
    //    col1 = color(R1, G1, B1);
    //    col2 = color(R2, G2, B2);
    beginShape();
    vertex (50, 5);
     fill(col2);
    bezierVertex(50, 10, 40, 50, 50, 100, 30, 100, 0);
    fill(col1);
    bezierVertex(70, 10, 40, 50, 50, 100, 30, 100, 100); 
    endShape ();
    
//    beginShape();
//    vertex (-5, 5);
//     fill(col2);
//    bezierVertex(-30, -50, -40, -50, -50, -100, -30, -100, -10);
//    fill(col1);
//    bezierVertex(-10, -70, -40, -50, -50, -100, -30, -100, -100); 
//   
//   
//    
//    
//      //bezierVertex(100, 10, 0, 50, 50, 100, 30, 100, 0); 
//
//      endShape();



      //    beginShape(QUADS);
      //    int n = lookUp.length;
      //    for (int i=0; i<n; i += 2) {
      //      int j = (i + 1) % n;      
      //      fill(col1);
      //      vertex(lookUp[i].x*r1, lookUp[i].y*r1, -h);
      //      vertex(lookUp[j].x*r1, lookUp[j].y*r1, -h);      
      //      fill(col2);
      //      vertex(lookUp[j].x*r2, lookUp[j].y*r2, h);
      //      vertex(lookUp[i].x*r2, lookUp[i].y*r2, h);
      //    }
      //    endShape();
      //  }
    }
  }


