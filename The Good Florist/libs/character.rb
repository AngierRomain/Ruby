class Character
  TILE_SIZE = 48
  def initialize
    @x = 0
    @y = 0
    @anims = {} # Hash littéral
    @current_animation = nil
    @current_frame = 0 # quelle frame de l'animation on est en train d'afficher
  end

  def set_current_frame(frame)
    @current_frame = frame
  end
  
  def add_animation(animation_name, file_name)
    @anims[animation_name] = Gosu::Image.load_tiles(file_name, TILE_SIZE, TILE_SIZE, retro: true)
  end
  
  def set_animation(animation_name)
    @current_animation = animation_name
  end

  def draw
    p @anims[@current_animation].size
    @anims[@current_animation][@current_frame].draw(@x, @y, 1)
  end
end
