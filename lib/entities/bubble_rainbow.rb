class BubbleRainbow
  SHEET_WIDTH = 383
  SHEET_HEIGHT= 255
  FRAME_COUNT = 5
  FRAME_DELAY = 100 # milliseconds
  POP_FRAME_DELAY = 50
  attr_reader :x, :y, :frames, :current_frame, :bubble_scale

  def initialize x, y
    @x                 = x
    @y                 = y
    @frames            = Gosu::Image.load_tiles("assets/images/bubbles/bubble_rainbow_sheet.png", 127, 127, retro: true)
    @pop_frames        = Gosu::Image.load_tiles("assets/images/bubbles/green_pop.png", 119, 120, retro: true)
    @pop_sound         = Gosu::Sample.new("assets/sounds/bubble_pop_2.mp3")
    @state             = :idle
    @current_frame     = 0
    @last_frame_change = Gosu.milliseconds
    @rotation          = 0
    @pop_start_time    = 0
    @bubble_scale      = 0.20
  end

  def update
    current_time = Gosu.milliseconds

    case @state
    when :idle
      if current_time - @last_frame_change > FRAME_DELAY
        @current_frame = (@current_frame + 1) % FRAME_COUNT
        @last_frame_change = current_time
      end
      @rotation += 1
    when :popping
      if current_time - @last_frame_change > POP_FRAME_DELAY
        @current_frame += 1
        @last_frame_change = current_time
        if @current_frame >= @pop_frames.size
          @state = :popped
        end
      end
    end
  end

  def draw
    case @state
    when :idle
      @frames[@current_frame].draw_rot(@x, @y, 0, 0, 0.5, 0.5, @bubble_scale, @bubble_scale)
    when :popping
      @pop_frames[@current_frame].draw_rot(@x, @y, 0, 0, 0.5, 0.5, @bubble_scale, @bubble_scale)
    end
  end

  def pop
    @state = :popping
    @current_frame = 0
    @last_frame_change = Gosu.milliseconds
    @pop_sound.play
  end

  def popping?
    @state == :popping
  end

  def popped?
    @state == :popped
  end
end
