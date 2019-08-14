class RubyLoadScreen < Gosu::Window

  def initialize
    super(WIDTH,HEIGHT,SCREENSETTING)
    self.caption = "Keep The Virus Alive ! Survive To The Glitch !"
    @font = Gosu::Font.new 50
    @intro_ruby = Gosu::Image.new(self, "resources/images/backgrounds/intro_ruby.png", true)
    @num = 0
  end

  def draw
    @intro_ruby.draw(0, 0, ZOrder::Background)
  end

  def update
    if @num == 200
      GameWindow.new.show
      exit
    end
    @num += 1
  end

  def needs_cursor?
    false
  end

end

class LoadScreen < Gosu::Window

  def initialize
    super(WIDTH,HEIGHT,SCREENSETTING)
    self.caption = "Keep The Virus Alive ! Survive To The Glitch !"
    @font = Gosu::Font.new 50
    
    @num = 0
  end

  def draw
    @intro.draw(0, 0, ZOrder::Background)
  end

  def update
    if @num == 200
      RubyLoadScreen.new.show
      exit
    end
    @num += 1
  end

  def needs_cursor?
    false
  end

end
