class Crab
  SHEET_WIDTH  = 256
  SHEET_HEIGHT = 128
  CRAB_WIDTH   = 64
  CRAB_HEIGHT  = 64
  def initialize maze
    @maze             = maze
    @x                = 0
    @y                = 0
    @crab_frames      = Gosu::Image.load_tiles("assets/images/crab/crab_sprite.png", 64, 64, retro: true)
    @current_frame    = 0
    @frame_delay      = 4
    @frame_counter    = 0
    @direction        = :up
    @crab_scale       = 0.75
    place_on_path
  end

  def update

  end

  def draw
    @crab_frames[@current_frame].draw(@x, @y, 0, @crab_scale, @crab_scale)
  end


  private


  def place_on_path
    @maze.grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        if cell.tile_path
          @x = x + 50
          @y = y + 50
          return
        end
      end
    end
  end
end
