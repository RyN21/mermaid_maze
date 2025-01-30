class Pop
  SHEET_WIDTH = 358
  SHEET_HEIGHT= 120
  FRAME_COUNT = 5
  FRAME_DELAY = 100 # milliseconds
  attr_reader :x, :y, :pop_frames

  def initialize(x, y)
    @x = x
    @y = y
    @pop_frames = Gosu::Image.load_tiles("assets/images/bubbles/green_pop.png", 119, 120, retro: true)
    @current_frame = 0
    @last_frame_change = Gosu.milliseconds
    @rotation = 0
  end

  def update
    current_time = Gosu.milliseconds
    if current_time - @last_frame_change > FRAME_DELAY
      @current_frame = (@current_frame + 1) % FRAME_COUNT
      @last_frame_change = current_time
    end
    @rotation += 1
  end

  def draw
    @pop_frames[@current_frame].draw_rot(@x, @y, 0, 0, 0.5, 0.5, 0.20, 0.20)
  end
end
