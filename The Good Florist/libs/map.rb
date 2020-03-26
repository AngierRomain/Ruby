# frozen_string_literal: true

require 'json'

class Map
  TILE_SIZE = 32
  GRASS_POS = 0
  GROUND_POS = 5

  def initialize
    @tileset = Gosu::Image.load_tiles('assets/tilesets/flowers.png', TILE_SIZE, TILE_SIZE, retro: true)

    fileMap = File.read('./assets/map/map.json')
    @map = JSON.parse(fileMap)
    @height = @map['height']
    @width = @map['width']
    @tiles = @map['layers'][0]['data'].map { |e| e - 1 }
  end

  def record
    # optimisation, pas comme render, ne renvoie pas une vraie gosu image
    @recorded = Gosu::record(@width * TILE_SIZE,@height * TILE_SIZE) do
      @width.times do |x|
        @height.times do |y|
          i = y * @width + x
          if @tiles[i] != -1
            @tileset[@tiles[i]].draw(x * TILE_SIZE, y * TILE_SIZE, 0)
          end
        end
      end
    end
  end

  def draw
    record unless defined? @recorded
    @recorded.draw(0, 0, 0)
  end

  def save; end
end
