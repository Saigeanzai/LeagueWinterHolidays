boolean dragGlobe = false;

// 1. Use this globe object for the rest of the project
//    DO NOT initialize it here!
Globe globe;

void setup() {
  // 2. Set the size of the sketch to at least 800 width 600 height

  // 3. Initialize the globe object to a new Globe
  
}

void draw() {
  // 4. Set a background color using the background function 

  // 5. Call the globe object's update method
  
  // 6. Call the globe object's draw method
  
  // 7. Run the program. Do you see the globe?

  if (dragGlobe) {
    // 8. Call the globe object's drag method
    
  }

  // 9. Run the program. What happens when you click on
  //    the globe and drag it?

}

void mousePressed() {
  if (dist(mouseX, mouseY, globe.position.x, globe.position.y) <= 300/2) {
    dragGlobe = true;
  }
}

void mouseReleased() {
  if( mouseButton == RIGHT ){
    if(globe.snowmen.size() > 0){
      globe.throwSnowball();
    }
  }
  dragGlobe = false;
}
