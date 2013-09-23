import java.lang.reflect.*;

class WormManager {
  boolean drawAxis = true;
  boolean drawInfo = true;
  ArrayList<Worm> worms;
  ArrayList<Class> wormClasses;
  int which = -1;
  
  Worm active;
  PVector releasePoint;

  PApplet parent;

  WormManager(PApplet parent) {
    this.parent = parent;
    worms = new ArrayList();
    wormClasses = scanClasses(parent, "Worm");
    releasePoint = new PVector();
    nextWorm();
  }

  void draw() {
    pushMatrix();
    stroke(0, 100);
    noFill();
    if (drawAxis) box(220, 220, 220);
    for (int i=worms.size()-1; i>= 0; i--) {
      Worm w = worms.get(i);
      w.update();
      w.preDraw();
      w.draw();
      w.postDraw();      
      if (w.life <= 0) worms.remove(w);
    }
    
    if (active != null){
      active.update();
      active.setPos(releasePoint);
      active.preDraw();
      active.draw();
      active.postDraw();      
    }

    if (drawAxis) for (Worm w : worms) w.drawAxis();    
    popMatrix();

    camera(); // reset de la camera, on peut afficher les infos a la bonne place
    if (drawInfo) {
      hint(DISABLE_DEPTH_TEST);
      showInfo();
      if (active != null) active.showInfo();
      hint(ENABLE_DEPTH_TEST);
    }
  }

  void killAll() {
    worms.clear();
  }

  void showInfo() {
    String out = "";
    fill(0, 100);
    out += "--------------------------\n";
    out += "fps: " + nf(frameRate, 0, 1) + "\n";
    out += "num worms: " + worms.size() + "\n";
    out += "current worm: " + which + "\n";
    text(out, 20, 20);
  }

  void nextWorm() {
    which = ++which % wormClasses.size();
    active = createInstance(which);
    active.setManagerReference(this); 
  }

  void prevWorm() {
    which = which - 1 < 0 ? wormClasses.size()-1 : which - 1;
    active = createInstance(which);
    active.setManagerReference(this); 
  }

  void addWorm() {
    worms.add(active);
    active = createInstance(which);
    active.setManagerReference(this);
    releasePoint = PVector.random3D();
    releasePoint.mult(80);
    //active.setPos(random(-100, 100), random(-100, 100), random(-100, 100));
  }

  ArrayList<Class> scanClasses(PApplet parent, String superClassName) {
    ArrayList<Class> wormClasses = new ArrayList<Class>();  
    println("------------------------------------------------------");
    println("Searching for classes which extend " + superClassName + ":");  

    String infoText = "";
    Class[] c = parent.getClass().getDeclaredClasses();
    for (int i=0; i<c.length; i++) {
      if (c[i].getSuperclass() != null && (c[i].getSuperclass().getSimpleName().equals(superClassName) )) {
        wormClasses.add(c[i]);
        int n = wormClasses.size()-1;
        String numb = str(n);
        if (n < 10) numb = " " + n;
        infoText += numb + "     " + c[i].getSimpleName() + "\n";
      }
    }
    println(infoText);
    return wormClasses;
  }

  public Worm createInstance(int i) {
    if (i < 0 || i >= wormClasses.size()) return null;

    Worm w = null;
    try {
      Class c = wormClasses.get(i);
      Constructor[] constructors = c.getConstructors();
      w = (Worm) constructors[0].newInstance(parent);
    } 
    catch (InvocationTargetException e) {
      System.out.println(e);
    } 
    catch (InstantiationException e) {
      System.out.println(e);
    } 
    catch (IllegalAccessException e) {
      System.out.println(e);
    } 

    //    if (f != null) {
    //      // Do something with the Class, for example add it to an ArrayList
    //    }
    return w;
  }

  public Worm createInstance(String className) {
    int index = -1;
    for (int i=0; i<wormClasses.size(); i++) {    
      if (wormClasses.get(i).getSimpleName().equals(className)) {
        index = i;
        break;
      }
    }
    if (index >= 0) return createInstance(index);
    return null;
  }
  
  ArrayList<Worm> getWorms(String wormName) {
    ArrayList<Worm> t = new ArrayList();
    for (Worm w : worms) {
      if (w.name.equals(wormName)) t.add(w);
    }
    return t;
  }

  ArrayList<Worm> getWorms() {
    return worms;
  }
}

