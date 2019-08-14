
puts "Chargement... Soyez Patient."
$VERSION = "0.0.2"

class GameWindow < Gosu::Window

  def initialize
    super(WIDTH,HEIGHT,SCREENSETTING)
    self.caption = "Keep The Virus ALive !"
    x = 100
    y = self.height / 2 - 100
    lineHeight = 100
    items = Array["run", "close"]
    actions = Array[lambda { @paused = false }, lambda { close }, lambda { @menu.add_item(Gosu::Image.new(self, "./resources/images/menu/item.png", false), x, y, 1)
    y += lineHeight
    }]
    @menu = Menu.new(self)
    for i in (0..items.size - 1)
      @menu.add_item(Gosu::Image.new(self, "./resources/images/menu/#{items[i]}.png", false), x, y, 1, actions[i], Gosu::Image.new(self, "./resources/images/menu/#{items[i]}_hover.png", false))
      y += lineHeight
    end
   
    @font = Gosu::Font.new(self, "resources/fonts/Roboto-Light.ttf", 35)
    @font_thin = Gosu::Font.new(self, "resources/fonts/Roboto-Light.ttf", 35)
    @font_menu = Gosu::Font.new(self, "resources/fonts/Roboto-Regular.ttf", 25)
    @font_big = Gosu::Font.new(self, "resources/fonts/Roboto-Black.ttf", 65)
    @font_screen = Gosu::Font.new(self, 'resources/fonts/Roboto-Regular.ttf', 55)
    @font_small = Gosu::Font.new(self, 'resources/fonts/Roboto-Light.ttf', 18)
    @font_gameover_bold = Gosu::Font.new(self, 'resources/fonts/Roboto-Regular.ttf', 55)

    @background = Gosu::Image.new(self, "resources/images/backgrounds/space.png", true)
    @darkscreen = Gosu::Image.new("resources/images/backgrounds/darkscreen.png")
    @darkscreen_menu = Gosu::Image.new("resources/images/backgrounds/darkscreen_menu.png")
    @menuscreen = Gosu::Image.new("resources/images/backgrounds/backgroundmenu.png")
    @paused_icon = Gosu::Image.new("resources/images/icons/paused.png")
    @logo = Gosu::Image.new("resources/images/brands/logo.png")

    @rocket = Rocket.new(self)

    @backmusic = Gosu::Song.new(self, "resources/sounds/theme.ogg")
    @menumusic = Gosu::Song.new(self, "resources/sounds/menu.ogg")

    @cursor = Gosu::Image.new(self, 'resources/images/icons/cursor.png', true)
    @preloader = Gosu::Image.new(self, "resources/images/icons/loader.png", true)
    @preloader_background = Gosu::Image.new(self, "resources/images/backgrounds/preloader.png", true)
    @num = 0
    @game_menu = true
    @game_started = false
    run_it
    windowonly
    toggle_settings = false
end

  def new_rocket
    if @life_counter > 0 then
      @life_counter -= 1
      @rocket.spawn
    else
      @game_over = true
    end
  end

  def rocket_level
    (@score / 1000) + 1
  end

  def toggle_paused
    if @paused
      resume_sounds
      puts "Jeu repris"
    else
      pause_sounds
      puts "Jeu en pause"
    end
    @paused = !@paused
  end

  def play_sound(sound, volume = 0.9)
    @sounds << sound.play(volume)
  end

  def clear_stopped_sounds
    @sounds.reject! {|snd| !snd.playing? && !snd.paused? }
  end

  def pause_sounds
    @sounds.each {|snd| snd.pause if snd.playing? }
  end

  def resume_sounds
    @sounds.each {|snd| snd.resume if snd.paused? }
  end

  def toggle_music
    if @backmusic.playing?
      @backmusic.pause
    else
      @backmusic.play(true)
    end
  end

  def windowonly
   if WIDTH > 1920
     close
     puts "Erreur: Mauvaise résolution d'écran."
   end
   if WIDTH < 1920
     close
     puts "Erreur: Mauvaise résolution d'écran."
   end
   if HEIGHT > 1280
     close
     puts "Erreur: Mauvaise résolution d'écran."
   end
   if HEIGHT < 1280
     close
     puts "Erreur: Mauvaise résolution d'écran."
   end
  end

  def self.collide?(thing1, thing2)
    dist = Gosu::distance(thing1.x, thing1.y, thing2.x, thing2.y)
    dist < (thing1.radius + thing2.radius)
  end

  def update
      @menu.update
   unless @paused || @game_over
      @rocket.update
      @asteroids.each {|asteroids| asteroids.update}
      @stars02.each {|stars02| stars02.update}
      new_stars02
      @stars.each {|stars| stars.update}
      @score += 1
      possible_collisions
      clear_stopped_sounds
      new_asteroids
      new_stars
      windowonly
    end
    if @num == 100
      @game_menu = false
    end
    @num += 1
    @meteor.update
  end

  def possible_collisions
    destroyed = []
    @asteroids.each do |asteroids|
      if @rocket.collide?(asteroids)
        @score += (10 * (3.0 / asteroids.size)).to_i
        destroyed << asteroids
      end
    end
    destroyed.each {|asteroids| asteroids.destroy }
  end

  def new_asteroids
    @base_speed = ((rocket_level - 1) * 3.2) + 554.5
    max_speed = 30

    max_asteroids = 12 + (rocket_level * 2)
    prob = 2 + (rocket_level * 0.5 )

    if rand(70) < prob and @asteroids.size < max_asteroids then
      @asteroids.push(Asteroids.new(self, [@base_speed, max_speed].min))
    end
  end

  def new_stars
    @base_speed = ((rocket_level - 1) * 3.2) + 554.5
    max_speed = 25

    max_stars = 42 + (rocket_level * 2)
    prob = 2 + (rocket_level * 0.5 )

    if rand(10) < prob and @stars.size < max_stars then
      @stars.push(Stars.new(self, [@base_speed, max_speed].min))
    end
  end

  def new_stars02
    @base_speed = ((rocket_level - 1) * 3.2) + 554.5
    max_speed = 20

    max_stars02 = 442 + (rocket_level * 2)
    prob = 2 + (rocket_level * 0.5 )

    if rand(7) < prob and @stars02.size < max_stars02 then
      @stars02.push(Stars02.new(self, [@base_speed, max_speed].min))
    end
  end

  def remove_asteroids(asteroids)
    @asteroids.delete(asteroids)
  end

  def remove_stars(stars)
    @stars.delete(stars)
  end

  def remove_stars02(stars02)
    @stars02.delete(stars02)
  end

  def draw
  @background.draw(0, 0, ZOrder::Background)
  @stars.each {|stars| stars.draw}
  @stars02.each {|stars02| stars02.draw}

    if @escaped
      @paused_icon.draw(10, 10, ZOrder::UI2, 0.3, 0.3)
    end

    if @game_menu
      angle = (Gosu::milliseconds / 5) % 360
      @preloader_background.draw(0, 0, ZOrder::Pause)
      @font_thin.draw("CHARGEMENT", self.width - 290, self.height - 65, ZOrder::Pause, 1.0, 1.0, 0xff_ffffff)
      @preloader.draw_rot(self.width - 70, self.height - 50, ZOrder::Pause, angle, 0.5, 0.5)
    end

    if @paused
      @menumusic.play(true) unless @game_menu
      @menuscreen.draw(0, 0, ZOrder::Background)
      @logo.draw(100, 150, ZOrder::UI2, 0.7, 0.7)
      @font_menu.draw("ALPHA #{$VERSION}", 20, self.height / 2 * 2 - 40, ZOrder::UI2, 1.0, 1.0, 0xff_6f717d)
      @meteor.draw
    end

    unless @paused
      @rocket.draw unless @game_over
      @asteroids.each {|asteroids| asteroids.draw}
      @escaped = false
      @game_started = true
      @backmusic.play
      @backmusic.volume = 0.2
      draw_game_ui
      draw_game_over_screen if @game_over
    end
    return unless @paused

    draw_pause_screen if @paused
    draw_game_ui unless @game_over || @paused
  end

  def draw_game_ui
    @font_screen.draw("#{@score}", self.width / 2 - 20, 0, ZOrder::UI2, 1.0, 1.0, 0xff_ffffff) unless @game_over
  end

  def draw_pause_screen
    @menu.draw
    @cursor.draw(self.mouse_x, self.mouse_y, ZOrder::UI2, 1)
  end

  def draw_game_over_screen
    
    @font_big.draw("Game Over :(", self.width / 2 - 150, self.height / 2 - 150, ZOrder::Background, 1.0, 1.0, 0xff_ffffff)
    @font_gameover_bold.draw("Votre score: #{@score}", self.width / 2.7 - 150, self.height / 2 - 75, ZOrder::UI, 1.0, 1.0, 0xff_ffffff)
    @font_gameover_bold.draw("Votre meilleur score: #{@high_score}", self.width / 2.7 - 147, self.height / 2 - 15, ZOrder::UI, 1.0, 1.0, 0xff_ffffff)
    @font.draw("APPUYEZ SUR 'ESPACE' POUR RECOMMENCER OU 'ECHAP' POUR RETOURNER AU MENU", self.width / 2 - 550, self.height / 2 + 60, ZOrder::UI, 1.0, 1.0, 0xff_ffffff)
      if @score > @high_score = YAML.load_file('resources/libs/highscore.yaml')
        @high_score = @score
        File.write('resources/libs/highscore.yaml', @high_score.to_yaml)

      end
      
  end

  def button_down(id)
    @last_btn = id
    if @game_over then
      if id == Gosu::KbEscape
        run_it
      end
      if id == Gosu::KbSpace
        respawn_game
      end
    else
      case id
      when Gosu::KbEscape, Gosu::KbP
        toggle_paused
        @escaped = true
      when Gosu::KbM
        toggle_music
      when Gosu::KbQ
        close
        puts "Exit game"
      when Gosu::MsLeft
        @menu.clicked
      end
    end
  end
end

if @nointro then
window = GameWindow.new
window.show
else
window = LoadScreen.new
window.show
end
