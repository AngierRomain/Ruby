class Character
  attr_reader :x, :y
  def initialize
    @x = 20
    @y = 20
    @direction = 0
    @anims = {} # Hash littéral
    @current_animation = nil
    @current_frame = 0 # quelle frame de l'animation on est en train d'afficher
  end

  def set_direction(direction)
    @direction = direction
  end

  def set_current_frame(frame)
    @current_frame = frame
  end
  
  def add_animation(animation_name, file_name, width, height)
    @anims[animation_name] = Gosu::Image.load_tiles(file_name, width, height, retro: true)
  end
  
  def set_animation(animation_name)
    @current_animation = animation_name
  end

  def next_frame
    @anim_tick ||= Gosu::milliseconds # renvoie le nombre de millisecondes écoulées depuis le début de l'application
    if Gosu::milliseconds - @anim_tick >= 190
      framecount = @anims[@current_animation].size
      unless @direction.nil?
        framecount = @anims[@current_animation].size/4
      end
      @current_frame += 1
      @current_frame = 0 if @current_frame > framecount-1
      @anim_tick = Gosu::milliseconds
    end
  end

  def draw
    frame = @current_frame
    unless @direction.nil?
      framecount = @anims[@current_animation].size / 4
      frame = @direction * framecount + @current_frame
    end
    @anims[@current_animation][frame].draw(@x, @y, 1)
  end
end
