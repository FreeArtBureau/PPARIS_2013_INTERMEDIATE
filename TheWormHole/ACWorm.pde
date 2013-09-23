public class ACWorm extends Worm {

  float r, g, b;    // color actuel
  float R, G, B;    // target
  float R1, G1, B1; // color1
  float R2, G2, B2; // color2
  float ang;  
  float randcos;
  float randsin;
  float  incr;

  PVector vitesseRot;
  PVector vitessePos;
  PVector ac1;
  PVector ac2;
  PVector point2;
  color col1, col2;
  float f1, f2, f3;
  float base;

  int num;
  float arc;

  public ACWorm() {
    name = "MicroB";
    author = "anoine@artmedium.info";
    // antoine 

    incr=random(0.0001, 0.01);//mouvement

    r=255;
    g=255;
    b=255;
    R2 = random(100, 150);
    G2 = random(100, 150);
    B2 = random(100, 150);

    // R1 = random(255);
    // G1 = random(255);
    // B1 = random(255);

    R=R1;
    G=G1;
    B=B1;

    ac1=new PVector(random(-100, 100), random(-100, 100), random(-100, 100));
    ac2=new PVector(random(-100, 100), random(-100, 100), random(-100, 100));

    point2=new PVector(random(-100, 100), random(-100, 100), random(-100, 100));

    vitesseRot =new PVector(random(-0.001, 0.001), random(-0.001, 0.001), random(-0.001, 0.001));  
    vitessePos =new PVector(random(-1, 1), random(-1, 1), random(-1, 1));

    // col1 = color(random(255), random(255), random(255));
    // col2 = color(random(255), random(255), random(255));

    num = 50;
    arc = TWO_PI / num ;
  }

  void update() {
    rot.add(vitesseRot);
    pos.add(vitessePos);

    /////////////////////////color
    r += (R - r) * 0.005;
    g += (G - g) * 0.005;
    b += (B - b) * 0.005;

    // println("R-"+R+"R1-"+R1);
    // println("R1-"+R1);
    // println("R2-"+R2);
    // println("r"+r);
    // println("--------------");

    if ( (g+1)>=G &&  (r+1)>=R && (b+1)>=B ) { 
      // println("------chang color --------");

      R = random(100, 230); 
      G = random(100, 230); 
      B = random(100, 230);

      // if (R1==R  && G1==G  && B1==B) {  
      //   R=R2; 
      //   G=G2; 
      //   B =B2;
      // println("------chang color 2--------");
    }

    // else { 
    //    R=R1; 
    //   G=G1; 
    //   B =B1;
    //if (R2==R && G2==G  && B2==B ) {  
    //  R=R1; 
    //  G=G1; 
    // B =B1;
    //  println("------chang color 1--------");
    //  }
    //}

    ///////////////////////////////mouvement 


    randcos=cos(ang);
    randsin=sin(ang);
    //float randtang=random(-0.5, 0.1);


    ac1.x= (ac1.x + (randcos * 0.01) ) ;
    ac1.y= (ac1.y + (randcos* 0.5) ) ;
    ac1.z= (ac1.z + ( randcos* 0.5 ) );

    ac2.x= (ac2.x + (randsin * 0.5) ) ;
    ac2.y= (ac2.y + (randsin* 0.1) ) ;
    ac2.z= (ac2.z + ( randsin* 0.1 ) );

    //   point2.x=point2.x+ (randsin * 0.09);
    //  point2.y=point2.y+ (randsin * 0.09);
    //  point2.z=point2.z+ (randsin * 0.09);
    point2.x=point2.x+ (randcos * 0.09);
    point2.y=point2.y+ (randcos * 0.09);
    point2.z=point2.z+ (randcos * 0.09);


    ang= ang + incr;



    if (ang >= TWO_PI ) {  
      incr = -incr;
    }


    if (ang <=0) {  
      incr =-incr;
    }
  }



  void draw() {



    col1 = color(r, g, b );

    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);

    pushMatrix();


    bezierDetail(8);
    noFill();

    stroke(col1);

    for (int i=0;i<num;i++) 
    { 

      bezier(0, 0, 0, ac1.x, ac1.y, ac1.z, ac1.x, ac1.y, ac1.z, point2.x, point2.y, point2.z);

      rotateX(arc);
    }

    popMatrix();
  }
}

