def fullscreen
  true
end

def windowed
  false
end

settings = YAML.load_file "./resources/libs/config.yaml"
WIDTH = settings["screen_width"]
HEIGHT = settings["screen_height"]
SCREENSETTING = settings["screensetting"]
@nointro = true

module ZOrder
  Background = 0
  Menuscreen = 1
  Sun = 2
  Stars02 = 3
  Stars = 4
  Asteroids = 5
  Rocket = 6
  UI = 7
  UI2 = 8
  Pause = 9
end

def respawn_game
  @pause = false
  @aboutme = false
  @game_over = false
  @escaped = false
  @life_counter = 0
  @base_speed = 0.5
  @rocket.speed = 5
  @away = 20000
  @secs ||= 0
  @score = 0
  @counter = 0
  @meteor = Meteor.new
  @asteroids = []
  @stars = []
  @stars02 = []
  @sounds = []
  @rocket.reset
end

def run_it
  @paused = true
  @aboutme = false
  @game_over = false
  @escaped = false
  @life_counter = 0
  @base_speed = 0.5
  @rocket.speed = 5
  @away = 20000
  @secs ||= 0
  @score = 0
  @counter = 0
  @meteor = Meteor.new
  @asteroids = []
  @stars = []
  @stars02 = []
  @sounds = []
  @rocket.reset
  puts "Game started"
end
