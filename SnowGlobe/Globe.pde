/*
 * This code was helped very much by: Jake "Sid" Smith
 * https://jakesidsmith.com/
 */
int GLOBE_WIDTH = 500 - 10;  // empirically determined
int GLOBE_HEIGHT = 500 - 10; // empirically determined
int GLOBE_HEIGHT_OFS = 44;
int GLOBE_FLOOR_Y_OFS = 150;

class Globe {  
  float startX, startY;
  PVector position, velocity;
  ArrayList<Flake> flakes;
  PImage globeImg;

  ArrayList<Flake> snowflakes;
  ArrayList<Snowman> snowmen;

  public Globe() {
    this.globeImg = loadImage("cabin3c.png");
    this.globeImg.resize(545, 600);

    this.startX = width / 2;
    this.startY = height / 2;
    this.position = new PVector(startX, startY);
    this.velocity = new PVector(0, 0);

    snowmen = new ArrayList<Snowman>();
    snowflakes = new ArrayList<Flake>();

    for (int i = 0; i < 1000; i++) {
      snowflakes.add(new Flake());
    }
  }

  public void addSnowman(float scale, color c, int x, int y) {
    snowmen.add(new Snowman(scale, c, x, y));
  }
  
  public void throwSnowball(){
    for ( Snowman sm : snowmen ) {
      sm.throwSnowball();
    }
  }

  void drag() {
    velocity = new PVector(mouseX - pmouseX, mouseY - pmouseY);

    for ( Snowman sm : snowmen ) {
      sm.velocity.x = velocity.x;
      sm.velocity.y = velocity.y;
    }
  }

  void update() {
    position.add(velocity);

    velocity.mult(0.8);

    /*
     * Only applied when not dragging
     */
    velocity.x += (startX - position.x) * 0.2;
    velocity.y += (startY - position.y) * 0.2;
    
    position.x = constrain(position.x, GLOBE_WIDTH/2, width - GLOBE_WIDTH/2);
    position.y = constrain(position.y, GLOBE_HEIGHT/2, height - GLOBE_HEIGHT/2);
    
    for( Snowman sm : snowmen ) {
      sm.update();
    }
    
    for( Flake flake : snowflakes ) {
      flake.update(position, velocity);
    }
  }

  void draw() {
    pushStyle();

    noStroke();
    fill(0, 40);

    imageMode(CENTER);
    image(globeImg, position.x, position.y);

    for ( Snowman sm : snowmen ) {
      sm.draw();
    }

    for (Flake flake : snowflakes ) {
      flake.draw();
    }

    popStyle();
  }
}
