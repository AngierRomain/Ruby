# frozen_string_literal: true

require 'gosu'

class Window < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'The Good Florist - The Game'
    @song = Gosu::Song.new("assets/sounds/nature-sketch.ogg")
    @song.play(true)
  end

  def update
    # contain the main game logic
  end

  def draw
    # contain code to redraw the whole scene
  end
end

Window.new.show
