class Asteroids

  TILE_WIDTH = 100
  TILE_HEIGHT = 100

  attr_accessor :height, :width, :x, :y, :size

  def self.load_animation(window)
     @animation ||= Gosu::Image::load_tiles(window, "resources/images/asteroids/glitch.gif",
        TILE_WIDTH, TILE_HEIGHT, false)
  end

  def self.load_sound(window)
    @sound ||= Gosu::Sample.new(window, "resources/sounds/explosion.ogg")
  end

  def initialize(window, speed = 0.5)
    @window = window
    @asteroidsanim = self.class.load_animation(window)
    @x = rand(window.width - TILE_WIDTH)
    @y = 0
    @size = rand(2) + 1
    @height = TILE_HEIGHT * @size
    @width = TILE_WIDTH * @size
    @beep = self.class.load_sound(window)
    @speed = speed
  end

  def destroy
    @window.play_sound(@beep, (1.0 / @size.to_f))
    @window.remove_asteroids(self)
  end

  def draw
    angle = (Gosu::milliseconds / 30) % 360
    img = @asteroidsanim[(Gosu::milliseconds / 100) % @asteroidsanim.size]
    img.draw_rot(@x, @y, ZOrder::Asteroids, angle, 0.5, 0.5, @size, @size)
  end

  def update
    @y += @speed
    if (@y - height) > @window.height
      @window.remove_asteroids(self)
    end
  end

  def radius
    (19.0 * @size) / 2.0
  end

end
