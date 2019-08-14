class Rocket

  attr_accessor :speed, :x, :y

  def self.load_explosion_sound(window)
    @explosion_snd ||= Gosu::Sample.new(window, 'resources/sounds/explosion.ogg')
  end

  def self.load_image(window)
    @rocket_image ||= Gosu::Image.new(window, 'resources/images/rocket/player.gif', false)
  end

  def initialize(window)
    @rocket_image = self.class.load_image(window)
    @explosion = self.class.load_explosion_sound(window)
    @window = window
    @x = window.width / 2
    @y = window.height / 2
    @speed = 5
    @x_offset = @rocket_image.width / 2
    @y_offset = @rocket_image.height / 2
    reset
  end

  def reset
    @exploding = false
    @x = @window.width / 2
    @y = @window.height / 2 * 2 - 110
  end

  def draw
    if @spawning
      @rocket_image.draw_rot(@x, @y, ZOrder::Rocket, 0, 0.5, 0.5, 1, 1, c1)
    else
      @rocket_image.draw_rot(@x, @y, ZOrder::Rocket, 0)
    end

  end

  def move
    return if @exploding

    if @window.button_down?(Gosu::KbLeft) or @window.button_down?(Gosu::GpLeft)
      move_left
    end
    if @window.button_down?(Gosu::KbRight) or @window.button_down?(Gosu::GpRight)
      move_right
    end
  end

  def move_left
    if @x > 0 + @x_offset
      @x -= 20
    end
  end

  def move_right
    if @x < @window.width - @x_offset
      @x += 20
    end
  end

  def move_up
    if @y > 0 + @y_offset
     @y -= 20
    end
  end

  def move_down
    if @y < @window.height - @y_offset
      @y += 20
    end
  end

  def update
    update_explosion
    update_spawning
    move
  end

  def update_explosion
    if @exploding then
      @exploding_counter -= 1
      if @exploding_counter <= 0 then
        @exploding = false
        @window.new_rocket
      end
    end
  end

  def update_spawning
    if @spawning then
      @spawning_counter ||= 100
      @spawning_counter -= 1
      if @spawning_counter < 0 then
        @spawning = false
      end
    end
  end

  def set_x(x)
    @x = x
  end

  def set_y(y)
    @y = y
  end

  def spawn
    @spawning = true
    @spawning_counter = nil
    reset
  end

  def can_collide?
    !@spawning && !@exploding
  end

  def radius
    @radius ||= @rocket_image.width / 2
  end

  def destroy
    @window.play_sound(@explosion)
    @exploding = true
    @exploding_counter = 0
  end

  def collide?(thing)
      if can_collide? && Utilities.collide?(self, thing)
        self.destroy
        return true
      end

  end

end
