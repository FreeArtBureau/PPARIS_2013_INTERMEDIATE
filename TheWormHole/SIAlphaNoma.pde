public class SIAlphaNoma extends Worm {

  int nbSyl=25;
  char [] CONSO= {
    'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'z'
  };
  char [] VOYEL= {
    'a', 'e', 'i', 'o', 'u', 'y'
  };

  char [] conso = new char[nbSyl];
  char [] voyel = new char[nbSyl];

  String []syllabes= new String[nbSyl];

  float squize;
  PVector vitesseRot;
  PVector vitessePos;

  color col, noir;
  boolean finDeVie() {
    return (life<50);
  }



  public SIAlphaNoma() {

    author = "Fred SIgnard";
    name = "AlphaNoma";
    int sens=(int)random(0, 2);
    vitesseRot =new PVector(0, sens==1?0.02:-0.02, 0);  
    vitessePos =new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    rot.set(random(0, 1), random(0, 1), random(0, 1));
    squize=(random(0.1, 0.2));


    col=color(random(0, 180), random(0, 140), random(0, 100));
    noir=color(0, 0, 0);

    for (int c_ = 0; c_<conso.length;c_++) {
      conso[c_]=CONSO[int(random(0, CONSO.length))];
      voyel[c_]=VOYEL[int(random(0, VOYEL.length))];
      syllabes[c_]=conso[c_]+""+voyel[c_];
    }
  }

  void update() {
    rot.add(vitesseRot);
    pos.add(vitessePos);
    step();
    println(life);
//    if (finDeVie()) criDeMort() ;
  }

  void draw() {
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    dessine();
  }

  void dessine() {
    pushMatrix();
    int ts=nbSyl;
    int its=0;

    for (String s:syllabes) {
      fill(col, map(ts, 0, nbSyl, 0, 255));
      if ((int)rot.y==++its) fill (255, 0, 0);
      if ((int)rot.y==its+1) fill (0, 255, 0);
      if ((int)rot.y==its+2) fill (0, 0, 255);
      textSize(ts--);
      text(s, 0, 0, 0);
      rotateY(radians(-100));
      rotateY(rot.y*squize);
      rotateX(radians(squize));
      float offset=1;
      offset=life<=500?map(life, 500, 0, 1, 0):1;
      translate(textWidth(s)*1.2, 10*offset, 0);
    }
    popMatrix();
  }

  void criDeMort() {
    for (int c_ = 0; c_<conso.length;c_++) {
      syllabes[c_]='i'+""+'i';
      println("cridemort");
    }
  }




  void step() {
    for (int i=1;i<nbSyl;i++) {
      if (frameCount%((i*life)+1)==0) {
        conso[i]=CONSO[int(random(0, CONSO.length))];
        syllabes[i]="ooooooooooooooooooooooooooooooooo";
      }
    }
  }
}

