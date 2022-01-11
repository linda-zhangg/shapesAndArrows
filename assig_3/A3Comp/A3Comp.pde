//array of point coordinates
float[] xPoints = {80,400,180,400,500,150};
float[] yPoints = {80,300,390,40,300,500};

Arrow[] arrows;  //array of Arrow objects
int numArrows = 5;  //the number of Arrow objects

int pointNum = 6; // number of existing points
int curPoint = -1;  // the current point - used for mouseDragged and mousePressed

Laser laser;  // laser object


void setup(){
  size(600,600);
  // make new arrows
  arrows = new Arrow[numArrows];
  for(int i=0;i<arrows.length;i++){
    arrows[i] = new Arrow(i%pointNum);
  }
  // make new laser
  laser = new Laser(width/2,height/2);
}

// be able to drag points of the curve if the mouse is close enough
void mousePressed(){
  boolean foundPoint = false;
  for(int i=0;i<pointNum;i++){
    if(Math.hypot((mouseX-xPoints[i]),(mouseY-yPoints[i])) < 15){ // if the mouse is close enough to a point
      curPoint = i;
      foundPoint = true;
    }
  }
  if(!foundPoint){
    curPoint = -1;
  }
}

void mouseDragged(){
  if(curPoint != -1){
    xPoints[curPoint] = mouseX;
    yPoints[curPoint] = mouseY;
  }
}

void draw(){
  background(149, 218, 193);
  
  //draw Catmull-Rom spline using curveVertex
  stroke(255, 235, 161);
  strokeWeight(25);
  noFill();
  beginShape();
    for(int i=0; i<pointNum+3;i++){  // +3 to draw the closed curve
      curveVertex(xPoints[i%pointNum], yPoints[i%pointNum]);
    }
  endShape();
  
  //draw connecting lines to each point with a circle
  stroke(111, 105, 172);
  strokeWeight(2);
  for(int i=0;i<pointNum;i++){
    circle(xPoints[i], yPoints[i],10);
    if(i == pointNum - 1){
      line(xPoints[i], yPoints[i],xPoints[0], yPoints[0]);
    }
    else{
      line(xPoints[i], yPoints[i],xPoints[i+1], yPoints[i+1]);
    }
  }
  
  //draw the animated arrows on the curve
  for(Arrow a: arrows){
    
    //change colour if touched by laser
    a.run();
  }
  
  //run laser
  laser.run();
 
}
