class Flake {
  color flakeColor;
  PVector position, velocity;
  float radius;
  float randXDist, randXPeriod, gravity;

  Flake() {
    this.flakeColor = color(255);
    this.radius = random(1, 6);
    this.randXDist = random(-0.8, 0.8);//(-0.01, 0.01);
    this.randXPeriod = random(0.01, 0.05);

    // Random starting position
    float gWidth = ((GLOBE_WIDTH - 10) / 2);
    float gHeight = ((GLOBE_HEIGHT) / 2);
    float theta = random(0, 2*PI);
    float dist = sqrt(random(0, 1.0));
    float randX = (float)(gWidth  * dist * cos(theta));
    float randY = (float)(gHeight * dist * sin(theta));

    while ( randY > GLOBE_FLOOR_Y_OFS ) {
      theta = random(0, 2*PI);
      dist = sqrt(random(0, 1.0));
      randX = (float)(gWidth  * dist * cos(theta));
      randY = (float)((GLOBE_HEIGHT/2) * dist * sin(theta));
    }

    this.position = new PVector(randX, randY);
    this.position.x += width/2;
    this.position.y += height/2;

    // Downwards gravity
    this.gravity = 1 * (radius / 10);
    this.velocity = new PVector(0, this.gravity);
  }

  void update(PVector globePosition, PVector globeVelocity) {
    if ( checkBounds(globePosition) < 1 ) {
      if (velocity.y != 0) {
        velocity.x += (float)((cos(frameCount*randXPeriod)) * randXDist) * 0.01;
      }

      velocity.y += gravity * 0.01;

      PVector g = new PVector(globeVelocity.x, globeVelocity.y);
      g.mult(0.05);
      g.mult(radius/10);

      velocity.add(g);
      position.add(velocity);
    } else {
      float dx = position.x - globePosition.x;
      float dy = position.y - globePosition.y - GLOBE_HEIGHT_OFS;
      float theta = atan2(dy, dx);

      position.x = globePosition.x + (GLOBE_WIDTH/2 - radius/2) * cos(theta);
      position.y = globePosition.y - GLOBE_HEIGHT_OFS + (GLOBE_HEIGHT/2 - radius/2) * sin(theta);
      if ( position.y > globePosition.y + GLOBE_FLOOR_Y_OFS ) {
        position.y = globePosition.y + GLOBE_FLOOR_Y_OFS;
      }

      velocity.x = 0;
      velocity.y = 0;
    }
  }

  float checkBounds(PVector globePosition) {
    float ret;
    float globeCenterX = globePosition.x;
    float globeCenterY = globePosition.y - GLOBE_HEIGHT_OFS;
    int globeWidth = GLOBE_WIDTH;
    int globeHeight = GLOBE_HEIGHT;

    if ( position.y > globeCenterY + GLOBE_FLOOR_Y_OFS + GLOBE_HEIGHT_OFS ) {
      ret = 1;
    } else {
      ret =  pow(position.x - globeCenterX, 2) / pow(globeWidth / 2, 2);
      ret += pow(position.y - globeCenterY, 2) / pow(globeHeight / 2, 2);
    }

    return ret;
  }

  void draw() {
    pushStyle();

    ellipseMode(CENTER);
    noStroke();
    fill(flakeColor);
    ellipse(position.x, position.y, radius, radius);

    popStyle();
  }
}
