float theta = 0.0;  // Start angle at 0
//float amplitude = 75.0;  // Height of wave
float period = 500.0;  // How many pixels before the wave repeats
int maxwaves = 5;

float[] amplitudes = new float[maxwaves];
float[] dx = new float[maxwaves];  // Value for incrementing X, a function of period and xspacing
float[] yvalues;  // Using an array to store height values for the wave

void setup() {
  size(700, 300);
  //dx = (TWO_PI / period);
  for(int i = 0; i < maxwaves; i++) {
    amplitudes[i] = random(10, 50);
    float period = random(width/5, width);
    dx[i]= TWO_PI / period;
  }
  yvalues = new float[width];
}

void draw() {
  background(0);
  calcWave();
  renderWave();
}

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here)
  theta += 0.05;
  
  //initialize all yvalues to be zero first;
  for(int j = 0; j < yvalues.length; j++) {
   yvalues[j] = 0; 
  }
  
  for (int i = 0; i < maxwaves; i++) {
    float x = theta;
    for(int j = 0; j < yvalues.length; j++) {
      yvalues[j] += sin(x)*amplitudes[i];
      x+=dx[i];
    }
  }
}

void renderWave() {
  noStroke();
  fill(255);
  // A simple way to draw the wave with an ellipse at each location
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x, height/2+yvalues[x], 1, 1);
  }
}
