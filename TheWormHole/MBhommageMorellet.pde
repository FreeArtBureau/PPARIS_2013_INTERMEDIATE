public class MBhommageMorellet extends Worm {

int rangeGrid1, rangeGrid2, pas;
int strokeW=int(random(1, 5));
    int sens=(int)random(0,2);
  PVector  vitesseRot =new PVector(0, sens==1?0.01:-0.01, 0);  
  PVector  vitessePos =new PVector(random(-2, 2), random(-2, 2), random(-2, 2));
  

float[] angle1= {
  0, 22.5*PI/180, 45*PI/180, 67.5*PI/180
};
float vitesse;
PVector unit=new PVector(1.0, 0.0, 0.0);
color[] colorGrid=new color[4];

float[] angle2;

int renderNumber=0;
int kFrame=0;

public MBhommageMorellet() {
      author = "Marc Bernot";
    name = "Hommage à Morellet";

  colorMode(HSB);

  int hueInit=int(random(255));
  int SInit=int(random(255));
  int BInit=int(random(200));

  for (int k=0;k<colorGrid.length;k++)
  {
    colorGrid[k]=  color((hueInit+random(100))%255, (SInit+random(100))%255, (BInit+random(100))%255);
  }


  String lines[] = loadStrings("battement.csv");
  String[] angle2string= split(lines[0], ',');

  angle2=new float[angle2string.length];
  for (int k=0;k<angle2string.length;k++)
  {
    angle2[k]=float(angle2string[k]);
  }

  vitesse=random(1.0, 4.0);
}


  void update() {
    rot.add(vitesseRot);
    pos.add(vitessePos);
  }
  
void draw() {

    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
  
  blendMode(MULTIPLY);
  noStroke();


  if (int(vitesse*kFrame)>=angle2.length)
  {
    kFrame=0;
    renderNumber++;
  }


  scale(1+((angle2[int(2*vitesse*kFrame)%angle2.length])-0.5)/2.0);

  if (renderNumber%2==0) {
    for (int k=0;k<4;k++)
    {
      unit.x= k==0?1:0;
      unit.y=(k==1)||(k==3)?1:0;
      unit.z=k>=2?1:0;
      unit.normalize();

      rotate((k==3?2:1)*PI*angle2[int(vitesse*kFrame)], unit.x, unit.y, unit.z);
      rotate(angle1[k], 0, 0, 1);
      lignes(colorGrid[k]);
      rotateZ(PI/2);
      lignes(colorGrid[k]);
      rotateZ(-PI/2);
      rotate(-angle1[k], 0, 0, 1);
      rotate(-(k==3?2:1)*PI*angle2[int(vitesse*kFrame)], unit.x, unit.y, unit.z);
    }
  }

  else {
    for (int k=0;k<4;k++)
    {
      unit.x= 0;
      unit.y=0;
      unit.z=1;

      rotate((k<2?1:-1)*(k==3?2:1)*PI*angle2[int(vitesse*kFrame)], unit.x, unit.y, unit.z);
      rotate(angle1[k], 0, 0, 1);
      lignes(colorGrid[k]);
      rotateZ(PI/2);
      lignes(colorGrid[k]);
      rotateZ(-PI/2);
      rotate(-angle1[k], 0, 0, 1);
      rotate(-(k<2?1:-1)*(k==3?2:1)*PI*angle2[int(vitesse*kFrame)], unit.x, unit.y, unit.z);
    }
  }
  kFrame++;
}


void lignes(color c)
{     
  rangeGrid1=200;
  rangeGrid2=200;
  pas=20;
  for (int i=-rangeGrid1; i<rangeGrid1; i+=pas) {
    strokeWeight(strokeW);
    stroke(c);
    line(i, -sqrt(float(rangeGrid1*rangeGrid1)-float(i*i)), 0, i, sqrt(float(rangeGrid1*rangeGrid1)-float(i*i)), 0);
  }
}
}
