require "gosu"

class Menu
  CHARACTERS = ["Reija", "Adyra", "Stiorra", "Celine"]
  def initialize(state_manager)
    @state_manager    = state_manager
    @character_index  = 0
    @mermaid_blue     = Config::MERMAIDS[:blue][:down][0]
    @mermaid_purple   = Config::MERMAIDS[:purple][:down][0]
    @mermaid_pink     = Config::MERMAIDS[:pink][:down][0]
    @mermaid_green    = Config::MERMAIDS[:green][:down][0]
    @background_image = Gosu::Image.new("assets/images/background_ocean.jpg")
    @logo             = Gosu::Image.new("assets/images/logo.png")
    @font             = Gosu::Font.new(30)
    # @menu_music = Gosu::Song.new("assets/sounds/menu_music.mp3")
    # @menu_music.play(true)
  end

  def update; end

  def draw
    # @background_image.draw 0, 0, 0, 0.20, 0.20

    @font.draw_text("SELECT CHARACTER", 263, 250, 0, 1, 1)
    CHARACTERS.each_with_index do |char, index|

      shift = index * 200
      color = index == @character_index ? Gosu::Color.argb(0xff_ff00ff) : Gosu::Color::WHITE
      @font.draw_text(char, 60 + shift, 430, 1, 1, 1, color)
    end
    @mermaid_green.draw(47, 300, 0, 2, 2)
    @mermaid_pink.draw(247, 300, 0, 2, 2)
    @mermaid_purple.draw(447, 300, 0, 2, 2)
    @mermaid_blue.draw(647, 300, 0, 2, 2)
    @logo.draw(200, 50, 0, 1, 1)
    @font.draw_text("PRESS SPACE TO PLAY", 250, 525, 0, 1, 1)
    # @background.draw(0, 0, 0, 1, 1)
    # @logo.draw(0, 0, 0, 1, 1)
  end

  def button_down(id)
    case id
    when Gosu::KB_ESCAPE
      exit
    when Gosu::KB_SPACE
      # @menu_music.stop
      @state_manager.switch_to(GameWindow.new(@state_manager, @character_index))
    when Gosu::KB_LEFT
      @character_index = (@character_index - 1) % CHARACTERS.size
    when Gosu::KB_RIGHT
      @character_index = (@character_index + 1) % CHARACTERS.size
    end
  end
end
