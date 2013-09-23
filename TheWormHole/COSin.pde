public class COSin extends Worm {
  PVector fin;
  float speed;
  float range;
  int tcount;
  PVector next;
  color colHead, colQueue;
  final float MAX_ANGLE = 90;
  final float NUM_VERTICES = 5;
  final int SPEED = 10;
  final int SIZE = 20;
  final int distance = 50;
  float rotX, rotY, rotZ;
  int numBloc;
  Boolean prevBool;
  Boolean isOdd;
  
  ArrayList<PVector> points = new ArrayList();
  ArrayList<PVector> points_rot = new ArrayList();  
  ArrayList<Boolean> odd = new ArrayList();
  PMatrix3D mat = new PMatrix3D();
  public COSin() {
    name = "Crawler";    
    author = "Clement";   
    tcount = 0;
    next = null;
    numBloc = int(random(10, 50));
    prevBool = new Boolean(false);
    pushStyle();
    colorMode(HSB, 1);
    float h = random(1);
    float s = random(0.7, 0.9);
    float b = random(0.7, 1); 
    colHead = color(h, s, b);
    colQueue = color(h , s, b-random(0.4, 0.6));
    popStyle();
  }

  void draw() {
    //step();
    // place le repere
    pushStyle();  
    pushMatrix();
    colorMode(HSB, 255);
    noStroke();
    fill(colHead);    
    for (int i = 0; i < points.size()-2; i++ ) {
      PVector v = points.get(i);          
      next = points.get(i+1);
      if ((next != null) && (i != points.size()-1)) {            
        line(v.x, v.y, v.z, next.x, next.y, next.z);
      }
    }
    popMatrix();        

    for (int i = 0; i < points.size()-2; i++ ) {
      PVector v = points.get(i);          
      PVector r = points_rot.get(i);
      pushMatrix();          
      translate(v.x, v.y, v.z);
      rotateX(r.x);
      rotateY(r.y);
      rotateZ(r.z);
      Boolean o = odd.get(i);
      if ( o.booleanValue()) {
        fill(colHead);  
      } else {
        fill(colQueue);
      }
      box(SIZE*map(i, 0, points.size()-1, 0.3, 1));          
      popMatrix();
    }
    popStyle();
  }

  void step() {
    if (tcount < SPEED) {
      tcount++;
      
      for (int i=0; i < points.size()-2; i++) {
        PVector p = points.get(i);
        PVector next = points.get(i+1);
        PVector op;
        op = next.get();
        op.sub(p);
        op.div(SPEED);
        p.add(op);
      }
    } 
    else {
      tcount = 0;
      PVector t = new PVector();
      
      if (points.size() == 0) {
        PVector rand = PVector.random3D();
        rotX = rand.x;
        rotY = rand.y;
        rotZ = rand.z;
      } 
      else {
        PVector previous = points.get(points.size()-1);
        rotX = previous.x*random(0.1f, 0.9f);
        rotY = previous.y*random(0.1f, 0.9f);
        rotZ = previous.z*random(0.1f, 0.9f);        
      }              

      mat.translate(0, 0, -distance);
      mat.rotateX(rotX);
      mat.rotateY(rotY);
      mat.rotateZ(rotZ);

      mat.mult(new PVector(20, 0, 0), t);
      points.add(t.get());
      points_rot.add(new PVector(rotX, rotY, rotZ));
      if ( prevBool.booleanValue() ) {
         isOdd = new Boolean(true);
        prevBool = new Boolean(false);
      } else {
        isOdd = new Boolean(false);
        prevBool = new Boolean(true);
      }
      odd.add(isOdd);
      if (points.size() > numBloc) {
        PVector toRemove = points.get(0);
        pos.x = toRemove.x;
        pos.y = toRemove.y;
        pos.z = toRemove.z;        
        points.remove(0);
        points_rot.remove(0);
        odd.remove(0);
      }     
    }
  }

  void update() {
    step();
  }
}
