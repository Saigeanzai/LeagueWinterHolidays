import java.util.Iterator;

public class Snowman {
  float startX, startY;
  color bodyColor, inverted;
  float scale;

  float radiusBot, radiusMid, radiusTop;
  float offsetBot, offsetMid, offsetTop;

  int snowballSize;
  float snowballX, snowballY;
  float snowballThrowX, snowballThrowY;

  float globeRadius;
  PVector position, velocity;
  ArrayList<Snowball> snowballs = new ArrayList<Snowball>();

  float globeStartX, globeStartY, globeOfsX, globeOfsY;

  public Snowman(float scale, int bodyColor, int x, int y) {
    this.scale = scale;
    this.startX = x;
    this.startY = y;
    this.position = new PVector(x, y);
    this.velocity = new PVector(0, 0);
    this.bodyColor = color(bodyColor);
    this.inverted = color(255 - red(bodyColor), 255 - green(bodyColor), 255 - blue(bodyColor));

    /*
     * Reminder, pass in these values--not the best way to hard code these 
     */
    this.globeStartX = width/2;
    this.globeStartY = height/2;
    this.globeOfsX = x - globeStartX;
    this.globeOfsY = y - globeStartY;

    this.snowballSize = 0;
    this.radiusBot = int(175 * scale);
    this.radiusMid = int(140 * scale);
    this.radiusTop = int(100 * scale);
    this.offsetBot = y - radiusBot - 20;
    this.offsetMid = offsetBot - (radiusBot);
    this.offsetTop = offsetMid - (2*radiusTop);
  }

  private void update() {
    position.add(velocity);
    
    /*
     * Only called when not dragging
     */
    velocity.x += (startX - position.x) * 0.2;
    velocity.y += (startY - position.y) * 0.2;
    
    position.x = constrain(position.x, globeOfsX + GLOBE_WIDTH/2, width - globeOfsX - GLOBE_WIDTH/2);
    position.y = constrain(position.y, globeOfsY + GLOBE_HEIGHT/2, height - globeOfsY - GLOBE_HEIGHT/2);
    
    velocity.mult(0.8);
  }

  public void draw() {
    drawBody();
    drawButtons();
    drawNose();
    drawEyesMouth();
    drawHat();
    drawArms();
  }

  public void drawBody() {
    pushStyle();

    noStroke();
    radiusBot = 175 * scale;
    radiusMid = 140 * scale;
    radiusTop = 100 * scale;
    offsetBot = position.y - radiusBot - 20;
    offsetMid = offsetBot - (radiusBot);
    offsetTop = offsetMid - (2*radiusTop);
    fill(this.bodyColor);
    ellipse(position.x, offsetBot, 2.15*radiusBot, 2*radiusBot);
    ellipse(position.x, offsetMid, 2.15*radiusMid, 2*radiusMid);
    ellipse(position.x, offsetTop, 2*radiusTop, 2*radiusTop);

    popStyle();
  }

  public void drawButtons() {
    pushStyle();

    float buttonSize = 0.25 * radiusMid;

    stroke(inverted);
    strokeWeight(buttonSize);

    point(position.x, offsetMid);
    point(position.x, offsetMid - (0.5 * radiusMid));
    point(position.x, offsetMid + (0.5 * radiusMid));

    popStyle();
  }

  public void drawNose() {
    pushStyle();

    float noseHeight = 0.2 * radiusTop;
    float noseLength = 1.2 * radiusTop;

    noStroke();
    fill(#FFA500);
    triangle(position.x, offsetTop, position.x, offsetTop + noseHeight, position.x + noseLength, offsetTop);

    popStyle();
  }

  public void drawEyesMouth() {
    pushStyle();

    float radiusEyes = 0.25 * radiusTop; 

    // Inverted color
    fill(inverted);
    ellipse(position.x - (radiusTop/4), offsetTop - (radiusTop/4), radiusEyes, radiusEyes);
    ellipse(position.x + (radiusTop/4), offsetTop - (radiusTop/4), radiusEyes, radiusEyes);

    float radiusSmile = 1.25 * radiusTop;
    float smileWidth = 0.15 * radiusTop;

    noFill();
    stroke(inverted);
    strokeWeight(smileWidth);
    arc(position.x, offsetTop, radiusSmile, radiusSmile, PI/4, 3*PI/4, OPEN);

    popStyle();
  }

  public void drawHat() {
    pushStyle();

    float brimWidth = 2.5 * radiusTop;
    float brimHeight = 0.3 * radiusTop;
    float topWidth = 0.5 * brimWidth;
    float topHeight = radiusTop;

    fill(1);
    rect(position.x - brimWidth/2, offsetTop - radiusTop, brimWidth, brimHeight);
    rect(position.x - topWidth/2, offsetTop - radiusTop - topHeight, topWidth, topHeight);

    popStyle();
  }

  private void drawArms() {
    pushStyle();

    float armY = offsetMid - (0.3 * radiusMid);
    float leftArmX =  position.x - (0.9 * radiusMid);
    float rightArmX = position.x + (0.9 * radiusMid);
    float armLength = 1.2 * radiusMid;
    float armWidth =  0.1 * radiusMid;

    stroke(#4C322B);
    strokeWeight(armWidth);
    strokeCap(ROUND);

    // Left arm angle and lengths
    float thetaL = atan( abs(mouseY - armY) / abs(mouseX - leftArmX) );
    float leftHandX = armLength * cos(thetaL);
    float leftHandY = armLength * sin(thetaL);

    // If mouseX is farther to the right, add to x position
    // If mouseY is farther below, add to the y position
    leftHandX = ( mouseX > leftArmX ) ? leftHandX : -leftHandX;
    leftHandY = ( mouseY > armY ) ? leftHandY : -leftHandY;

    // Same for right arm
    float thetaR = atan( abs(mouseY - armY) / abs(mouseX - rightArmX) );
    float rightHandX = armLength * cos(thetaR);
    float rightHandY = armLength * sin(thetaR);
    rightHandX = ( mouseX > rightArmX ) ? rightHandX : -rightHandX;
    rightHandY = ( mouseY > armY ) ? rightHandY : -rightHandY;

    // Draw arms
    line(leftArmX, armY, leftArmX + leftHandX, armY + leftHandY); 
    //line(rightArmX, armY , rightArmX + rightHandX, armY + rightHandY);
    line(rightArmX, armY, rightArmX + armLength, armY + armLength);

    if ( mousePressed && mouseButton == RIGHT ) {
      // Create a snowball in the snowman's hand!
      snowballSize++;

      strokeWeight(3);
      stroke(0);
      fill(bodyColor);
      snowballThrowX = mouseX;
      snowballThrowY = mouseY;
      snowballX = leftArmX + leftHandX;
      snowballY = armY + leftHandY;
      circle(snowballX, snowballY, snowballSize);
    }

    for ( Snowball ball : snowballs ) {
      ball.draw();
    }

    Iterator<Snowball> sbIterator = snowballs.iterator();
    while ( sbIterator.hasNext() ) {
      Snowball ball = sbIterator.next();
      if ( !ball.isActive ) {
        sbIterator.remove();
      }
    }

    popStyle();
  }

  public void throwSnowball() {
    if ( mouseButton == RIGHT ) {
      if ( snowballSize > 0 ) {
        snowballs.add(new Snowball(snowballSize, 10, bodyColor, snowballX, snowballY, snowballThrowX, snowballThrowY));
        snowballSize = 0;
      }
    }
  }
}
