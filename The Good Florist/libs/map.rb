require "json"

def fileToString(file)
	data = ""
	file.each_line do |line|
		if(data == "")
			data = line
		else
			data += line
		end
	end
	return data
end

class Map

	TILE_SIZE = 32
	GRASS_POS = 0
	GROUND_POS = 5

	def initialize()
		@tileset = Gosu::Image.load_tiles('assets/tilesets/flowers.png', TILE_SIZE, TILE_SIZE, retro:true)

		fileMap = File.open("./assets/map.json", 'r')
		@map = JSON.parse(fileToString(fileMap))
	end

	def draw

	end

	def save
	end
end