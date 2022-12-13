SnowMan frosty;
Snowfall snow;
Snowflakes flakes;
// 1. Declare a PImage variable for the background. Don't initialize it!
PImage bg;
void setup(){
  // 2. Set the size of the sketch to at least width=800 and height=600
size(800,600);
  // 3. Set your PImage variable to the output of the
  //    loadImage() method with "snowBg.jpg" as an input
bg = loadImage("snowBg.jpg");
  // 4. Call your PImage's resize() method with your width and height
bg.resize(800,600);
  // 5. Set the snowman variable to a new SnowMan()
  frosty = new SnowMan();
snow = new Snowfall();
flakes = new Snowflakes();
}

void draw(){
  // 6. Call the background() method to display your background image 
background(bg);
  // 7. Call the snow man's drawBody() method
frosty.drawBody();
  // 8. Run the program.
  //    Do you see the body of your snow man?
  
  // 9. See if you can figure out how to draw the
  //    snow man's eyes, mouth, nose, buttons,
  //    hat, and arms
frosty.drawArms();
frosty.drawButtons();
frosty.drawEyesMouth();
frosty.drawHat();
frosty.drawNose();

  // 10. Create an object of the Snowfall class in setup
  //     similar to the SnowMan obect from 5.
  //     DO NOT CREATE OR INITIALIZE THE VARIABLE HERE
  
  // 11. Call the Snowfall object's draw() method.
  //     Do you see snow falling when you run the code?
snow.draw();
  // 12. Create an object of the Snowflakes class in setup
  //     similar to the SnowMan obect from 5.

  // 13. Call the Snowflakes object's draw() method.
  //     Do you see snowflakes falling when you run the code?
  flakes.draw();
 

  
  
  // EXTRA:
  // * See if you can figure out how to add wind to the falling snow
  // * See if you can figure out hwo to make the snowflakes sparkle
  // * See if you can add snow men of different shapes and sizes

}

void mouseReleased(){
  if( mouseButton == RIGHT ){
    if( frosty != null ){
      frosty.throwSnowball();
    }
  }
}
