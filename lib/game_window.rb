require_relative "../config/settings"
require_relative "entities/fox"
require_relative "maze/maze"
require_relative "maze/cell"


class GameWindow < Gosu::Window

  def initialize
    super Config::WINDOW_WIDTH,
          Config::WINDOW_HEIGHT,
          Config::FULLSCREEN
    self.caption = Config::CAPTION

    @background_color = Config::COLORS[:background]
    # @maze             = Maze.new Config::GRID_ROWS, Config::GRID_COLS
    @maze             = MazeSidewinder.new Config::GRID_ROWS, Config::GRID_COLS
    @fox              = Fox.new(@maze)
  end

  def update
    @fox.update
  end

  def draw
    draw_rect 0,0, Config::WINDOW_WIDTH, Config::WINDOW_HEIGHT, @background_color
    @fox.draw
    @maze.draw(Config::CELL_SIZE)
  end
end
