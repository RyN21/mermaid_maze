require_relative "../config/settings"
require_relative "entities/fox"


class GameWindow < Gosu::Window

  def initialize
    super Config::WINDOW_WIDTH,
          Config::WINDOW_HEIGHT,
          Config::FULLSCREEN
    self.caption = Config::CAPTION

    @background_color = Config::COLORS[:background]
    @fox              = Fox.new
  end

  def update
    @fox.update
  end

  def draw
    draw_rect 0,0, Config::WINDOW_WIDTH, Config::WINDOW_HEIGHT, @background_color
    @fox.draw
  end
end
