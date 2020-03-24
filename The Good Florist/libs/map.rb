class Map

  TILE_SIZE = 32

  # La position des tuiles que l'on va utiliser dans la tileset
  GRASS_POS = 0
  GROUND_POS = 5

  def initialize(window, width, height)
    @tileset = Gosu::Image.load_tiles('assets/tilesets/flowers.png', TILE_SIZE, TILE_SIZE, retro:true)

  end

  def draw

  end
end