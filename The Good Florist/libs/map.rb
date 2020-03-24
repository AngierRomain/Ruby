class Map
  def initialize(window)
    @x,@y,@z = 0,0,0

    @tile_size = 32
    @tileset = Image.load_tiles('assets/tilesets/flowers.png', @tile_size, @tile_size, retro:true)
    size_x=40,size_y=40

    @map = Hash.new
    x=y=0
    for x in 0..40
      for y in 0..40
        @map[[x,y]] = 0,nil
      end
    end
    puts @map
  end

  def draw

    @map.each do |coords, texture|
      x, y, = coords[0], coords[1]
      tile1,tile2 = texture[0],texture[1]
      if tile1 != nil
        @tileset[tile1].draw(@x+ x * @tile_size, @y + y * @tile_size, 0)
      end
      if tile2 != nil
        @tileset[tile2].draw(@x+x* @tile_size, @y+y * @tile_size, 10)
      end
    end
  end
end
