//For every corner in original object
//Add itself if inside, add intersections, and don't add outside points
//Then draw with those points using shape()

float[] oriX = {50,400,300,400};
float[] oriY = {250,100,250,400};

int numVert = 4;  // number of verticies of original shape
int curPoint = -1;  // the current point - used for mouseDragged and mousePressed

// infinite line points
float x3=250,y3=50,x4=250,y4=450;  // p3p4 is the ininite line, so that the lines on the shape are p1p2
float x1,x2,y1,y2; // temp points to store each line of the shape

//new shape coordinates
ArrayList<Float> xShape;
ArrayList<Float> yShape; 


void setup(){
  size(500,500);
  xShape = new ArrayList<Float>();
  yShape = new ArrayList<Float>();
}

//move the verticies of the original shape
void mousePressed(){
  boolean foundPoint = false;
  for(int i=0;i<numVert;i++){
    if(Math.hypot((mouseX-oriX[i]),(mouseY-oriY[i])) < 15){ // if the mouse is close enough to a point
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
    oriX[curPoint] = mouseX;
    oriY[curPoint] = mouseY;
  }
}

void draw(){
  background(149, 218, 193);
  xShape.clear();
  yShape.clear();
  
  //find the intersection points between the infinite line (p3p4)
  //and each line (p1p2)
  for(int i=0;i<numVert;i++){
    //assign points to fit equation
    x1 = oriX[i];
    y1 = oriY[i];
    if(i == numVert-1){
      x2 = oriX[0];
      y2 = oriY[0];
    }
    else{
      x2 = oriX[i+1];
      y2 = oriY[i+1];
    }
    
    float a = -(y4-y3);
    float b = x4-x3;
    float c = x3*y4 - y3*x4;
    float s = -(a*x1 + b*y1 + c)/(a*(x2-x1) + b*(y2-y1));
    
    //intersection point
    float xi = (1-s)*x1 + s*x2;
    float yi = (1-s)*y1 + s*y2;
    
    //3 cases: intersect; all to the left; all to the right
    
    //if s is between 0 and 1 (they intersect)
    if(s>=0 && s<=1){
      //add left coordinate and intersection point
      if(x1<xi){
        xShape.add(x1);
        yShape.add(y1);
      }
      xShape.add(xi);
      yShape.add(yi);
      
    }
    //if both coordinates on left side
    else if(x1<x3 && x1<x4 && x2<x3 && x2<x4){
      xShape.add(x1);
      yShape.add(y1);
      xShape.add(x2);
      yShape.add(y2);
    }
    //if on right side, don't add to final shape
    
  }
  
  //draw a filled shape with coordinates in arrayLists
  
  //fill the new shape
  fill(167, 199, 231);
  noStroke();
  beginShape();
    for(int i=0; i<xShape.size(); i++){
      vertex(xShape.get(i),yShape.get(i));
    }
  endShape(CLOSE);
  
  //draw the original shape
  stroke(255, 235, 161);
  strokeWeight(5);
  noFill();
  beginShape();
    for(int i=0; i<numVert; i++){
      vertex(oriX[i],oriY[i]);
    }
  endShape(CLOSE);
  
  //draw circles on the control points
  stroke(111, 105, 172);
  strokeWeight(2);
  for(int i=0;i<numVert;i++){
    circle(oriX[i],oriY[i],10);
  }
  
  //draw the infinite line
  stroke(253, 111, 150);
  strokeWeight(7);
  line(x3,y3,x4,y4);
  
  
}
