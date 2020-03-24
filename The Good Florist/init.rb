# frozen_string_literal: true

require "rubygems"
require 'gosu'

require_relative 'libs/map.rb'
require_relative 'libs/character.rb'
require_relative 'libs/hero.rb'

class Window < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'The Good Florist - The Game'
    @song = Gosu::Song.new("assets/sounds/nature-sketch.ogg")
    @song.play(true)
    @main_state = Map.new()
  end

  def update
    # contain the main game logic
  end

  def draw
    # contain code to redraw the whole scene
    scale(4,4)do
      @main_state.draw
    end
  end
end

Window.new.show
