require_relative "../config/settings"
require_relative "entities/fox"
require_relative "entities/mermaid"
require_relative "maze/maze"
require_relative "maze/cell"
require_relative "entities/coin"
require_relative "entities/bubble_rainbow"
require_relative "effects/pop"


class GameWindow

  def initialize(state_manager, character_index)
    @state_manager = state_manager
    @character_index = character_index
    # Gosu.enable_undocumented_retrofication

    @background_color   = Config::COLORS[:background]
    @background_image   = Gosu::Image.new("assets/images/background_ocean.jpg")
    @maze               = MazeSidewinder.new(Config::GRID_ROWS, Config::GRID_COLS)
    @mermaid            = Mermaid.new(@maze, @character_index) # 0 for first row mermaid
    @bubble_rainbows    = Array.new

    @level_up_sound     = Gosu::Sample.new("assets/sounds/level_up.mp3")

    # @red_coins_anim     = Gosu::Image.load_tiles("assets/images/coins/red_coin.png", 25, 25)
    # @gold_coins_anim    = Gosu::Image.load_tiles("assets/images/coins/red_coin.png", 25, 25 )
    # @silver_coins_anim  = Gosu::Image.load_tiles("assets/images/coins/red_coin.png", 25, 25)
    add_bubbles_to_maze
  end

  def update
    @bubble_rainbows.each(&:update)
    @mermaid.update
    @mermaid.collects_bubbles(@bubble_rainbows)
    @bubble_rainbows.reject! { |bubble| bubble.popped? }
    reset_maze if all_bubbles_collected?
  end


  def draw
    # draw_rect 0,0, Config::WINDOW_WIDTH, Config::WINDOW_HEIGHT, @background_color
    @background_image.draw 0, 0, 0, 0.20, 0.20

    @maze.draw(Config::CELL_SIZE)
    @mermaid.draw
    @bubble_rainbows.each(&:draw)
  end

  def reset_bubbles
    @bubble_rainbows.clear
    add_bubbles_to_maze
  end

  def add_bubbles_to_maze
    path_tiles = []
    path_tiles = @maze.grid.flatten.select(&:tile_path)
    number_of_bubbles = path_tiles.size / 3
    path_tiles.shift # Makes sure coin isnt loaded at start path where fox is
    path_tiles.sample(number_of_bubbles).each do |tile|
      x = tile.col * Config::CELL_SIZE + Config::CELL_SIZE / 2
      y = tile.row * Config::CELL_SIZE + Config::CELL_SIZE / 2
      @bubble_rainbows << BubbleRainbow.new(x, y)
    end
  end

  def all_bubbles_collected?
    @bubble_rainbows.all?(&:popped?)
  end

  def reset_maze
    @level_up_sound.play
    @maze    = MazeSidewinder.new(Config::GRID_ROWS, Config::GRID_COLS)
    @mermaid = Mermaid.new(@maze, @character_index) # 0 for first row mermaid
    @mermaid.place_on_path
    reset_bubbles
  end

  def button_down(id)
    case id
    when Gosu::KB_BACKSPACE
      @state_manager.switch_to(Menu.new(@state_manager))
    end
  end
end


# GAME FEATURES TO ADD
#
# accidentally runs into something she shouldn't
# something scart pops up
# if she runs into something the bubbles reset or something similar
