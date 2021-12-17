class Snowball:
    
  def __init__(self, diameter, start_x, start_y, destination_x, destination_y, speed=10):
    self.speed = speed
    self.radius = diameter / 2
    self.x = start_x
    self.y = start_y
    self.is_active = True
    
    theta = atan( abs(destination_y - start_y) / abs(destination_x - start_x) )
    self.snowball_inc_x = self.speed * cos(theta)
    self.snowball_inc_y = self.speed * sin(theta)
    
    if destination_x < start_x:
      self.snowball_inc_x = -self.snowball_inc_x
    
    if destination_y < start_y:
      self.snowball_inc_y = -self.snowball_inc_y

  def draw(self):
    pushStyle()
    
    strokeWeight(3)
    stroke(0)
    circle(self.x, self.y, 2 * self.radius)

    if self.x < -self.radius or self.x > width + self.radius or self.y < -self.radius or self.y > height + self.radius:
        # Snowball is off the screen, reset

        self.is_active = False
    else:
        # Snowball on the screen so move it

        self.x += self.snowball_inc_x
        self.y += self.snowball_inc_y
    
    popStyle();
