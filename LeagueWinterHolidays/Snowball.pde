public class Snowball {
  float x, y;
  float snowballIncX, snowballIncY;
  int radius, speed;
  color ballColor;
  boolean isActive;

  public Snowball(int diameter, int speed, color c, float startX, float startY, float destinationX, float destinationY) {
    this.radius = diameter / 2;
    this.speed = speed;
    this.ballColor = c;
    this.x = startX;
    this.y = startY;
    this.isActive = true;
    
    float thetaS = atan( abs(destinationY - startY) / abs(destinationX - startX) );
    snowballIncX = speed * cos(thetaS);
    snowballIncY = speed * sin(thetaS);
    
    if( destinationX < startX ){
      snowballIncX = -snowballIncX;
    }
    
    if( destinationY < startY ){
      snowballIncY = -snowballIncY;
    }
  }

  void draw() {
    pushStyle();
    
    strokeWeight(3);
    stroke(0);
    fill(ballColor);
    circle(x, y, 2*radius);

    if ( x < -radius || x > width + radius || y < -radius || y > height + radius ) {
      // Snowball is off the screen, reset

      isActive = false;
    } else {
      // Snowball on the screen so move it

      x += snowballIncX;
      y += snowballIncY;
    }
    
    popStyle();
  }
}
