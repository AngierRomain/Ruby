class Hero < Character

  def initialize
    super
    add_animation("walking", "assets/characters/farmer.png")
    add_animation("idle", "assets/characters/stand_1.png")
    add_animation("houe", "assets/characters/houe.png")
    set_animation("idle") # animation par défaut
  end

  def update

  end

end
