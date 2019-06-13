import processing.video.*;
import processing.sound.*;

// Size of each cell in the grid, ratio of window size to video size
int videoScale = 10;
// Number of columns and rows in the system
int cols, rows;
// Variable to hold onto Capture object
Capture video;

//sound setup
SinOsc[] sineWaves; // Array of sines
float[] sineFreq; // Array of frequencies

void setup() {  
  size(640, 480);
  // Initialize columns and rows
  cols = width/videoScale;
  rows = height/videoScale;
  
  sineWaves = new SinOsc[cols]; // Initialize the oscillators
  sineFreq = new float[cols]; // Initialize array for Frequencies
  
  for (int i = 0; i < cols; i++) {
    // Calculate the amplitude for each oscillator
    float sineVolume = (1.0) / (i + 1);
    // Create the oscillators
    sineWaves[i] = new SinOsc(this);
    // Start Oscillators
    sineWaves[i].play();
    // Set the amplitudes for all oscillators
    sineWaves[i].amp(sineVolume);
  }

  background(0);
  video = new Capture(this, cols, rows);
  video.start();
}

// Read image from the camera
void captureEvent(Capture video) {
  video.read();
}

void draw() {
  video.loadPixels();
  // Begin loop for columns
  int freqSum;
  for (int i = 0; i < cols; i++) {
    freqSum = 0;
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      // Where are you, pixel-wise?
      int x = i*videoScale;
      int y = j*videoScale;
      color c = video.pixels[i + j*video.width];
      freqSum -= c / 1000000;
      
      fill(c);
      stroke(0);
      rect(x, y, videoScale, videoScale);
    }  
    sineFreq[i] = 100 + (((freqSum) / 100 ) * 100);
    sineWaves[i].freq(sineFreq[i]);
  }
}
