//Arrow objects
class Arrow{
// fields
  private int currentLine; //starting line number
  private float t = 0;  //parameter t
  private float x, y; // position on curve
  private float xTangent, yTangent; // direction of arrow
  private float angle; // angle to rotate arrow
  
  public boolean touchingLaser = false;  //check if any arrow is touching the laser

//contructor
  public Arrow(int line){
    currentLine = line;
    t = random(0,1);  // starting position can be anywhere on the line
  }

//methods
//calc position - using the given current line and parameter t
  public void calculatePos(){
    x = curvePoint(xPoints[currentLine%pointNum],xPoints[(currentLine+1)%pointNum],
                   xPoints[(currentLine+2)%pointNum],xPoints[(currentLine+3)%pointNum],t);
                   
    y = curvePoint(yPoints[currentLine%pointNum],yPoints[(currentLine+1)%pointNum],
                   yPoints[(currentLine+2)%pointNum],yPoints[(currentLine+3)%pointNum],t);
                   
    xTangent = curveTangent(xPoints[currentLine%pointNum],xPoints[(currentLine+1)%pointNum],
                   xPoints[(currentLine+2)%pointNum],xPoints[(currentLine+3)%pointNum],t);
                   
    yTangent = curveTangent(yPoints[currentLine%pointNum],yPoints[(currentLine+1)%pointNum],
                   yPoints[(currentLine+2)%pointNum],yPoints[(currentLine+3)%pointNum],t);
                   
    angle = atan2(yTangent,xTangent);
  }
//run

//getters for pos
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }

  //includes drawing of the object at the calculated position, and monitoring t
  public void run(){
    calculatePos();
    
    //increase t, and get new t and new currentLine if applicable
    if(t > 1.0){
      currentLine++;
      t = 0;
    }
    t += 0.005;
    
    translate(x,y);
    rotate(angle);
    
    //draw arrow shape translated at x,y and rotating at the tangent
    noStroke();
    
    //change colour if touched by laser
    if(touchingLaser){
      fill(167, 199, 231);
    }
    else{
      fill(253, 111, 150);
    }
    
    beginShape();
      vertex(0,0);  //front of arrow lies on curve
      vertex(-40,-15);
      vertex(-30,0);
      vertex(-40,15);
    endShape(CLOSE);    
    
    resetMatrix();
  }
    
}
