/*
Created by: Leonardo Merza
Version: 0.9
*/

import processing.serial.*;
import SimpleOpenNI.*;

SimpleOpenNI kinect;
Serial myPort;

//main variables
int closestX;
int closestY;
int closestZ; 

//debugging variables
int closex, closey;
int maxx=630, maxy=478, minx=1, miny=1;

void setup()
{
  myPort = new Serial(this, Serial.list()[0], 9600);
  
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableIR();
} // void setup

void draw()
{
  closestZ = 8000; 
  kinect.update();
  // get the depth array from the kinect
  int[] depthValues = kinect.depthMap();
  // for each row in the depth image
  for(int y = 0; y < 480; y++)
  { 
    // look at each pixel in the row
    for(int x = 0; x < 640; x++)
    { 
      // pull out the corresponding value from the depth array
      int i = x + y * 640; 
      int currentDepthValue = depthValues[i];
      // if that pixel is the closest one we've seen so far
      if(currentDepthValue > 0 && currentDepthValue < closestZ)
      { 
        // save its value
        closestZ = currentDepthValue;
        // and save its position (both X and Y coordinates)
        closestX = x;
        closestY = y;
      } // if statement
    } // for loop y value
  } // for loop x value
  
  //draw the depth image on the screen
  image(kinect.irImage(),0,0);
  
  fill(255,0,0);
  // draw a red circle over it
  ellipse(closestX, closestY, 10, 10);
} // void draw()
