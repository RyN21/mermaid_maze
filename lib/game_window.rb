require_relative "../config/settings"
require_relative "entities/fox"
require_relative "entities/mermaid"
require_relative "maze/maze"
require_relative "maze/cell"
require_relative "entities/coin"
require_relative "entities/bubble_rainbow"


class GameWindow < Gosu::Window

  def initialize
    super Config::WINDOW_WIDTH,
          Config::WINDOW_HEIGHT,
          Config::FULLSCREEN
    self.caption = Config::CAPTION
    Gosu.enable_undocumented_retrofication

    @background_color   = Config::COLORS[:background]
    @maze               = MazeSidewinder.new(Config::GRID_ROWS, Config::GRID_COLS)
    @character          = Mermaid.new(@maze) # 0 for first row mermaid
    @bubbe_rainbows     = Array.new
    # @red_coins_anim     = Gosu::Image.load_tiles("assets/images/coins/red_coin.png", 25, 25)
    # @gold_coins_anim    = Gosu::Image.load_tiles("assets/images/coins/red_coin.png", 25, 25 )
    # @silver_coins_anim  = Gosu::Image.load_tiles("assets/images/coins/red_coin.png", 25, 25)
    add_bubbles_to_maze
  end

  def update
    # @fox.update
    @bubbe_rainbows.each do |coin|
      coin.update
    end
    @character.update
  end

  def draw
    draw_rect 0,0, Config::WINDOW_WIDTH, Config::WINDOW_HEIGHT, @background_color
    @maze.draw(Config::CELL_SIZE)
    @character.draw
    @bubbe_rainbows.each(&:draw)
  end

  def add_bubbles_to_maze
    path_tiles = []
    path_tiles = @maze.grid.flatten.select(&:tile_path)
    number_of_bubbles = path_tiles.size / 3
    path_tiles.shift # Makes sure coin isnt loaded at start path where fox is
    path_tiles.sample(number_of_bubbles).each do |tile|
      x = tile.col * Config::CELL_SIZE + Config::CELL_SIZE / 2
      y = tile.row * Config::CELL_SIZE + Config::CELL_SIZE / 2
      @bubbe_rainbows << BubbleRainbow.new(x, y)
    end
  end
end
