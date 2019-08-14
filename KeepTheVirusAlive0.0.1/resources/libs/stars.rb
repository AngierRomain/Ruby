class Stars

  TILE_WIDTH = 25
  TILE_HEIGHT = 25

  attr_accessor :height, :width, :x, :y, :size

  def self.load_animation(window)
     @animation ||= Gosu::Image::load_tiles(window, "resources/images/stars/01.png",
        TILE_WIDTH, TILE_HEIGHT, false)
  end

  def self.load_sound(window)
    @sound ||= Gosu::Sample.new(window, "resources/sounds/explosion.ogg")
  end

  def initialize(window, speed = 0.5)
    @window = window
    @starssanim = self.class.load_animation(window)
    @x = rand(window.width - TILE_WIDTH)
    @y = 0
    @size = rand(1) - 0.3
    @height = TILE_HEIGHT * @size
    @width = TILE_WIDTH * @size
    @boom = self.class.load_sound(window)
    @speed = speed
  end

  def destroy
    @window.play_sound(@boom, (1.0 / @size.to_f))
    @window.remove_stars(self)
  end

  def draw
    img = @starssanim[(Gosu::milliseconds / 100) % @starssanim.size]
    img.draw_rot(@x, @y, ZOrder::Stars, -90, 0.5, 0.5, @size, @size)
  end

  def update
    @y += @speed
    if (@y - height) > @window.height
      @window.remove_stars(self)
    end
  end

  def radius
    (19.0 * @size) / 2.0
  end

end

class Stars02

  TILE_WIDTH = 25
  TILE_HEIGHT = 25

  attr_accessor :height, :width, :x, :y, :size

  def self.load_animation(window)
     @animation ||= Gosu::Image::load_tiles(window, "resources/images/stars/02.png",
        TILE_WIDTH, TILE_HEIGHT, false)
  end

  def self.load_sound(window)
    @sound ||= Gosu::Sample.new(window, "resources/sounds/explosion.ogg")
  end

  def initialize(window, speed = 0.5)
    @window = window
    @stars02sanim = self.class.load_animation(window)
    @x = rand(window.width - TILE_WIDTH)
    @y = 0
    @size = rand(1) - 0.3
    @height = TILE_HEIGHT * @size
    @width = TILE_WIDTH * @size
    @boom = self.class.load_sound(window)
    @speed = speed
  end

  def destroy
    @window.play_sound(@boom, (1.0 / @size.to_f))
    @window.remove_stars02(self)
  end

  def draw
    img = @stars02sanim[(Gosu::milliseconds / 100) % @stars02sanim.size]
    img.draw_rot(@x, @y, ZOrder::Stars02, -90, 0.5, 0.5, @size, @size)
  end

  def update
    @y += @speed
    if (@y - height) > @window.height
      @window.remove_stars02(self)
    end
  end

  def radius
    (19.0 * @size) / 2.0
  end

end
