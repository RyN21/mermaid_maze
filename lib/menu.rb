require "gosu"

class Menu
  CHARACTERS = ["Reija", "Adyra", "Stiorra", "Celine"]
  def initialize(state_manager)
    @state_manager = state_manager
    # @background = Gosu::Image.new("assets/images/background.png")
    # @logo = Gosu::Image.new("assets/images/logo.png")
    @font = Gosu::Font.new(30)
    # @menu_music = Gosu::Song.new("assets/sounds/menu_music.mp3")
    # @menu_music.play(true)
  end

  def update; end

  def draw
    @font.draw_text("SELECT CHARACTER", 0, 0, 0, 1, 1)
    @font.draw_text("SELECT CHARACTER", 0, 0, 0, 1, 1)
    CHARACTERS.each do |char, index|
      color = index == @character_select ? Gosu::Color::GREEN : Gosu::Color::WHITE
      @font.draw_text(char, 233 + (index * 125), 430, 1, 1, 1, color)
    end
    # @background.draw(0, 0, 0, 1, 1)
    # @logo.draw(0, 0, 0, 1, 1)
  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE
      exit
    when Gosu::KB_RETURN
      # @menu_music.stop
      @state_manager.switch_to(GameWindow.new(@state_manager))
    # when Gosu::KB_LEFT
    #
    # when Gosu::KB_RIGHT
    end
  end
end
