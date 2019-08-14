class Meteor

  def initialize()
    @meteor_numbers = 1
    @max_height    = 300
     @images        = [
       Gosu::Image.new("./resources/images/meteors/meteor.png", :tileable => false)
     ]
    @meteors = initial_meteors

  end

  def update
    @meteors.each do |item|
      item[:x] = -300 if item[:x] >= 15000

      item[:x] += item[:speed]
    end
  end

  def draw
    @meteors.each do |item|
      item[:image].draw_rot(
        item[:x],
        item[:y],
        0,
        0,
        0.5,
        0.5,
        item[:size],
        item[:size],
        Gosu::Color.new(0xff_ffffff)
      )
    end
  end

  private

  def initial_meteors
    Array.new(@meteor_numbers) { generate_meteor }
  end

  def generate_meteor
    {
      image: @images.sample,
      x:     rand(-100..600),
      y:     rand(25..@max_height),
      speed: rand(30.1..30.3),
      size:  rand(0.1..1)
    }
  end
end
