int numParticles = 5;
Particle[] particles = new Particle[numParticles];

void setup() {
  size(200, 200); 
  fill(0);
  for(int i = 0; i < numParticles; i++) {
    particles[i] = new Particle(random(0, 100), random(0, 100), random(0.2, 2.0), random(0.2, 2.0), 10);
  }
}

void draw() {
  //background(0);
  fill(0, 25);
  rect(0, 0, width, height);
  fill(163, 185, 255);
  noStroke();
  for(int i = 0; i < particles.length; i++) {
    particles[i].move(); 
    particles[i].show(); 
  }
}

class Particle {
  float xpos, ypos;
  float xdir, ydir;
  int size;
  float maxspeed = 2.0;
  float speed;
  
  Particle(float x, float y, float xd, float yd, int s) {
    xpos = x;
    ypos = y;
    xdir = xd;
    ydir = yd;
    size = s;
    speed = 0.2;
  }
  
  void show() {
    ellipse(xpos, ypos, size, size);
  }
  
  void move() {
    xpos += xdir * speed;
    ypos += ydir * speed;
    if(speed < maxspeed)
      speed += 0.02;
    if((xpos > width-(size/2)) || (xpos < (size/2))) {
      speed = 0.2;
      xdir = -xdir;
    }
    if((ypos > height-(size/2)) || (ypos < (size/2))) {
      ydir = -ydir;
      speed = 0.2;
    }
    
  }
}
