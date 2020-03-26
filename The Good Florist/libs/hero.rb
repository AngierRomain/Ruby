class Hero < Character
  SPEED = 1.2
  def initialize
    super
    add_animation('walking', 'assets/characters/farmer.png', 16, 24)
    add_animation('idle', 'assets/characters/stand_1.png', 16, 24)
    add_animation('houe', 'assets/characters/houe.png', 48, 48)
    set_animation('idle') # animation par défaut
  end

  def update
    needs_animation = true
    if Gosu::button_down? Gosu::KB_DOWN
      @y += SPEED
      set_direction(0)
      set_animation('walking')
    elsif Gosu::button_down? Gosu::KB_UP
      @y -= SPEED
      set_direction(1)
      set_animation('walking')
    elsif Gosu::button_down? Gosu::KB_LEFT
      @x -= SPEED
      set_direction(2)
      set_animation('walking')
    elsif Gosu::button_down? Gosu::KB_RIGHT
      @x += SPEED
      set_direction(3)
      set_animation('walking')
    else
      set_current_frame(0)
      needs_animation = false
    end
    next_frame if needs_animation
  end

end
