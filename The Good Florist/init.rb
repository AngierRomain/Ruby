# frozen_string_literal: true

require 'rubygems'
require 'gosu'

require_relative 'libs/map.rb'
require_relative 'libs/character.rb'
require_relative 'libs/hero.rb'

class Window < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'The Good Florist - The Game'
    @song = Gosu::Song.new('assets/sounds/nature-sketch.ogg')
    @song.play(true)
    @main_state = Map.new
    @camx = 0
    @camy = 0
    @hero = Hero.new
  end

  def update
    # contain the main game logic
    @hero.update
    @camx = @hero.x
    @camy = @hero.y
  end

  def draw
    # contain code to redraw the whole scene
    scale(3, 3)do
      @main_state.draw
        @hero.draw
    end

  end
end

Window.new.show
