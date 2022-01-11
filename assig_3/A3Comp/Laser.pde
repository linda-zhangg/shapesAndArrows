class Laser{
  
  private float xPos, yPos;  // position of the lazer
  private float angle;  // angle the lazer is pointing
  private float xs, ys;  // maximum lazer range position
  
  private float xa,xb,xc,ya,yb,yc;  // points for checking if c is close to the line ab
  private float s;  // the value s is between 0 and 1 (parametric)
  private float px, py; // the location point line ab at P(s)
  
  private double dist;  // distance from c to p

  public Laser(float x, float y){
    xPos = x;
    yPos = y;
  }

  public void run(){
    
    angle = atan2(yPos-mouseY,xPos-mouseX) + PI/2;
    
    //draw the laser line
    stroke(111, 105, 172);
    noFill();
    //make it stretch to beyond window
    xs = (float)(cos(angle + PI/2) * Math.hypot(width/2,height/2) + xPos);
    ys = (float)(sin(angle + PI/2) * Math.hypot(width/2,height/2) + yPos);
    line(xPos, yPos, xs, ys);
    
    //translate the laser position to allow rotation
    translate(xPos,yPos);
    rotate(angle);
    // draw canon
    noStroke();
    fill(111, 105, 172);
    circle(0,0,20);
    rect(-5,10,10,20);
    
    resetMatrix();
    
    // finding if each arrow is close enough to the lazer to change colour
    for(int i=0;i<numArrows;i++){
      xa = xs;
      ya = ys;
      
      xb = xPos;
      yb = yPos;
      
      xc = arrows[i].getX();
      yc = arrows[i].getY();
      
      s = ((xb - xa)*(xc - xa) + (yb - ya)*(yc - ya)) / ((xb - xa)*(xb - xa) + (yb - ya)*(yb - ya));
      
      px = (1-s)*xa + s*xb;
      py = (1-s)*ya + s*yb;
      
      dist = Math.hypot(xc-px,yc-py);
      
      //if it is close enough and lies in the laser line (not infinite line)
      if(dist < 20 && s >= 0 && s <= 1){
        arrows[i].touchingLaser = true;
      }
      else{
        arrows[i].touchingLaser = false;
      }
    }
  }

}
