module Utilities

  def self.collide?(thing1, thing2)
    dist = Gosu::distance(thing1.x, thing1.y, thing2.x, thing2.y)
    dist < (thing1.radius + thing2.radius)
  end

end
