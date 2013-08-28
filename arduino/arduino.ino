/*
Created by: Leonardo Merza
Version 0.9
*/
#include <Servo.h> 

Servo myServo;
int servoPin = 9;
int servoStraight = 90; // set servo straight
int servoLeft = 180; // max left turn
int servoRight = 50; // max right turn
int currentServo = servoStraight; /// start current servo as straight
int turningAngle = 20; // how much to turn when turning

int val, xVal, yVal, zVal; 

void setup() 
{ 
  Serial.begin(9600); 
  myServo.attach(servoPin);
} 

void loop()
{ 
  getKinectValues();
  kinectFollowX();

} // void loop
 
 void kinectFollowX()
{
  currentServo = (abs(xVal-255))*180/255;
  if(currentServo > servoRight && currentServo < servoLeft)
  {
    myServo.write(currentServo);
  }
} // void kinectFollowX

void getKinectValues()
{
    // check if enough data has been sent from the computer: 
  if (Serial.available()>3) 
  { 
    // Read the first value. This indicates the beginning of the communication. 
    val = Serial.read(); 
    // If the value is the event trigger character 'S' 
    if(val == 'S')
    { 
      // read the most recent byte, which is the x-value 
      xVal = Serial.read();
      Serial.write(xVal);
      // Then read the y-value 
      yVal = Serial.read();
      Serial.write(yVal); 
      // Then read the z-value
      zVal = Serial.read();
      Serial.write(zVal);
    } // if input is 'S' then read values
  } //if serial read on
}
