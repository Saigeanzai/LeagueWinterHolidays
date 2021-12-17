class Snowflakes {
  int gravity = 1;
  ArrayList<Snowflake> snowflakes;
  boolean sparkleEnabled;
  
  public Snowflakes(){
    snowflakes = new ArrayList<Snowflake>();
    this.sparkleEnabled = false;
    
    addSnowflake();
  }

  public Snowflakes(boolean enableSparkle){
    snowflakes = new ArrayList<Snowflake>();
    this.sparkleEnabled = enableSparkle;
    
    addSnowflake();
  }
  
  public void addSnowflake() {
    float x = random(width);
    float y = -60;
    float w = random(20, 60);
    
    Snowflake flake = new Snowflake( x, y, w, this.gravity);
    flake.setSparkle(this.sparkleEnabled);
    
    snowflakes.add( flake );
  }
  
  void draw() {
    // Make a new snowflake at a specified interval
    if( frameCount % 140 == 0 ){
      addSnowflake();
    }
    
    // Draw all the snowflakes
    for ( Snowflake flake : snowflakes ) {
      flake.draw();
    }

    // Remove snowflakes at the bottom of the screen
    for( int i = snowflakes.size()-1; i >= 0; i-- ){
      if( snowflakes.get(i).y > height ){
        snowflakes.remove(snowflakes.get(i));
      }
    }
  }
}

class Snowflake {
  float x;
  float y;
  float w;
  float r;
  float gravity;
  float fallSpeed;
  float rotateSpeedDegrees;
  boolean sparkle;
  color snowflakeColor;
  color[] snowflakeColors = { #FFFFFF, #1F1FFF, #DBDFE0 };

  public Snowflake(float x, float y, float w, float gravity) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.r = 0;
    this.gravity = gravity;
    this.snowflakeColor = snowflakeColors[ int(random(snowflakeColors.length)) ];
    
    this.fallSpeed = random(0.0, 1.0);
    this.rotateSpeedDegrees = random(0.0, 3.0);
  }
  
  public void setSparkle( boolean enableSparkle ) {
    this.sparkle = enableSparkle;
  }

  public void draw() {
    push();
    
    if( this.sparkle ){
      stroke(255 - random(50), 255 - random(50), 255 - random(50));
    } else {
      // White snowflake
      stroke( this.snowflakeColor );
    }
    
    int m = 16;
    float pDegrees = 360 / m;
    
    for (int i=0; i<m; i++) {
      if (i%2 == 0) {
        drawBranch(x, y, w, pDegrees * i);
      } else {
        drawBranch(x, y, w * 0.7, pDegrees * i);
      }
    }
    
    this.y += gravity + this.fallSpeed;
    this.r += this.rotateSpeedDegrees;
    
    pop();
  }

  private void drawBranch(float x, float y, float w, float rDegrees) {
    push();
    
    translate(x, y);
    rotate(radians(rDegrees + this.r));
    strokeWeight(3);
    line(0, 0, w, 0);
    line(w*0.5, 0, w*0.6, w*0.2);
    line(w*0.5, 0, w*0.6, w*-0.2);
    line(w*0.7, 0, w*0.8, w*0.2);
    line(w*0.7, 0, w*0.8, w*-0.2);
    
    pop();
  }
}
