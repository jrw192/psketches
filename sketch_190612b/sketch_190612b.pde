/**
 * Processing Sound Library, Example 5
 * 
 * This sketch shows how to use the FFT class to analyze a stream  
 * of sound. Change the variable bands to get more or less 
 * spectral bands to work with. The smooth_factor variable determines 
 * how much the signal will be smoothed on a scale form 0-1.
 */

import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
FFT fft;
AudioDevice device;

// Declare a scaling factor
int scale = 100;

// Define how many FFT bands we want
int bands = 8;

// declare a drawing variable for calculating rect width
float r_width;

// Create a smoothing vector
float[] sum = new float[bands];

// Create a smoothing factor
float smooth_factor = 2;

void setup() {
  size(700, 700);
  background(255);

  // If the Buffersize is larger than the FFT Size, the FFT will fail
  // so we set Buffersize equal to bands
  device = new AudioDevice(this, 44000, bands);

  // Calculate the width of the rects depending on how many bands we have
  r_width = width/float(bands);

  // Load and play a soundfile and loop it. This has to be called 
  // before the FFT is created.
  sample = new SoundFile(this, "junny.mp3");
  sample.loop();

  // Create and patch the FFT analyzer
  fft = new FFT(this, bands);
  fft.input(sample);
}      
int counter = 0;
void draw() {
  if(counter % 5 == 0) {
    circles();
  }
  counter++;
}

void circles() {
  int r = 25;
  int g = 70;
  int b = 255;
  // Set background color, noStroke and fill color
  background(0, 10);
  noStroke();

  fft.analyze();
  for (int i = 0; i < bands; i++) {
    fill(r+30*i, g+20*i, b);
    //System.out.println("r: " + r+15*i + "g: " + g+10*i + "b: " + b);
    // Smooth the FFT data by smoothing factor
    sum[i] += (fft.spectrum[i] - sum[i]) * smooth_factor;

    // Draw the rects with a scale factor
    //rect( i*r_width, height, r_width, -sum[i]*height*scale );
    System.out.println(sum[i]);
    //circle(random(0, width), random(0, height), sum[i]*scale);
    circle(70 + i*70, 70 + i*70, sum[i]*scale);

  }
}
