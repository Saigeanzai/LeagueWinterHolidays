SnowMan frosty;

// 1. Declare a PImage variable for the background. Don't initialize it!

void setup(){
  // 2. Set the size of the sketch to at least width=800 and height=600

  // 3. Set your PImage variable to the output of the
  //    loadImage() method with "snowBg.jpg" as an input

  // 4. Call your PImage's resize() method with your width and height

  // 5. Set the snowman variable to a new SnowMan()

}

void draw(){
  // 6. Call the background() method to display your background image 

  // 7. Call the snow man's drawBody() method

  // 8. Run the program.
  //    Do you see the body of your snow man?
  
  // 9. See if you can figure out how to draw the
  //    snow man's eyes, mouth, nose, buttons,
  //    hat, and arms

  // 10. Create an object of the Snowfall class in setup
  //     similar to the SnowMan obect from 5.
  //     DO NOT CREATE OR INITIALIZE THE VARIABLE HERE
  
  // 11. Call the Snowfall object's draw() method.
  //     Do you see snow falling when you run the code?

  // 12. Create an object of the Snowflakes class in setup
  //     similar to the SnowMan obect from 5.
  
  // 13. Call the Snowflakes object's draw() method.
  //     Do you see snowflakes falling when you run the code?

 

  
  
  // EXTRA:
  // * See if you can figure out how to add wind to the falling snow
  // * See if you can figure out hwo to make the snowflakes sparkle
  // * See if you can add snow men of different shapes and sizes

}

void mouseReleased(){
  if( frosty != null && mouseButton == RIGHT ){
    frosty.throwSnowball();
  }
}
