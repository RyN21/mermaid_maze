class BubbleRainbow
  SHEET_WIDTH = 383
  SHEET_HEIGHT= 255
  FRAME_COUNT = 5
  FRAME_DELAY = 100 # milliseconds
  attr_reader :x, :y, :frames
  def initialize(x, y)
    @x = x
    @y = y
    @frames = Gosu::Image.load_tiles("assets/images/bubbles/bubble_rainbow_sheet.png", 127, 127, retro: true)
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
    @frames[@current_frame].draw_rot(@x, @y, 0, 0, 0.5, 0.5, 0.20, 0.20)
  end
end
