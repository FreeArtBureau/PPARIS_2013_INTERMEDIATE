class Camera {
  PVector eye, lookAt, up;
  PVector deye, dlookAt;
  float eyeDamp, lookAtDamp;
  float angle, radius; 
  Worm target;
  ArrayList<Worm> targets;
  int currentTarget = -1;

  Camera(PVector eye, PVector lookAt, PVector up) {
    this.eye = eye;
    this.lookAt = lookAt;
    this.up = up;

    deye = eye.get();
    dlookAt = lookAt.get();
    eyeDamp = 0.05;
    lookAtDamp = 0.05;    
    setRadius(1000);
  }

  Camera(PVector eye, PVector lookAt) {
    this(eye, lookAt, new PVector(0, 1, 0));
    setRadius(1000);
  }

  Camera() {
    this(new PVector(0, 0, 1000), new PVector(0, 0, 0), new PVector(0, 1, 0));
    setRadius(1000);
  }

  void apply() {
    float fov = PI/3.0;
    float cameraZ = (height/2.0) / tan(fov/2.0);
    float ratio = float(width)/float(height);
    perspective(fov, ratio, cameraZ*0.001, cameraZ*1000.0);
    camera(eye.x, eye.y, eye.z, lookAt.x, lookAt.y, lookAt.z, up.x, up.y, up.z);
  }

  void setEye(PVector e) {
    deye = e.get();
  }

  void setEye(float x, float y, float z) {
    deye.set(x, y, z);
  }

  void setLookAt(PVector c) {
    dlookAt = c.get();
  }

  void setLookAt(float x, float y, float z) {
    dlookAt.set(x, y, z);
  }

  void setTargets(ArrayList<Worm> t) {
    targets = t;
  }


  void setTarget(Worm t) {
    target = t;
  }

  void nextTarget() {
    if (targets.size() > 0) {
      currentTarget = ++currentTarget % targets.size();
      setTarget(targets.get(currentTarget));
    }
  }

  void prevTarget() {
    if (targets.size() > 0) {
      currentTarget--;
      if (currentTarget < 0) currentTarget = targets.size() -1;
      setTarget(targets.get(currentTarget));
    }
  }


  // cette fonction est le meme de setTarget(null);
  void forgetTarget() {    
    target = null;
  }
  float getAngle() {
    return angle;
  }
  void setAngle(float a) {
    angle = a;
    deye.x = dlookAt.x + sin(angle) * radius;
    deye.z = dlookAt.y + cos(angle) * radius;
  }

  void setRadius(float r) {
    radius = r;
    deye.x = dlookAt.x + sin(angle) * radius;
    deye.z = dlookAt.y + cos(angle) * radius;
  }

  void interpolate() {
    PVector e, l;
    if (target == null) {
      e = deye.get();
      l = dlookAt.get();
    } 
    else {
      l = target.getPos();
      e = l.get();
      e.x += sin(angle) * radius;
      e.z += cos(angle) * radius;
    }
    lookAt.x += (l.x - lookAt.x) * lookAtDamp;
    lookAt.y += (l.y - lookAt.y) * lookAtDamp;
    lookAt.z += (l.z - lookAt.z) * lookAtDamp;
    eye.x += (e.x - eye.x) * eyeDamp;
    eye.y += (e.y - eye.y) * eyeDamp;
    eye.z += (e.z - eye.z) * eyeDamp;
  }
}

