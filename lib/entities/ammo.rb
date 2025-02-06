class Ammo
  AMMO_SHEET_WIDTH  = 591
  AMMO_SHEET_HEIGHT = 60
  attr_reader :x, :y

  def initialize x, y, direction
    @x = x
    @y = y
    @direction = direction
    @speed = 5
    @blaster_frames = Gosu::Image.load_tiles("assets/images/blaster_1.png", 98, 60, retro: true)
    @current_frame = 0
    @frame_delay = 100
    @last_frame_change = Gosu.milliseconds
    @rotation = 0
  end

  def update
    current_time = Gosu.milliseconds

    if current_time - @last_frame_change > @frame_delay
      @current_frame = (@current_frame + 1) % @blaster_frames.size
      @last_frame_change = current_time
    end
    case @direction
    when :up then @y -= @speed
    when :down then @y += @speed
    when :left then @x -= @speed
    when :right then @x += @speed
    end
  end

  def draw
    case @direction
    when :up
      @blaster_frames[@current_frame].draw_rot(@x, @y, 0, 90, 0.50, 0.50, 0.40, 0.40)
    when :down
      @blaster_frames[@current_frame].draw_rot(@x, @y, 0, -90, 0.50, 0.50, 0.40, 0.40)
    when :left
      @blaster_frames[@current_frame].draw_rot(@x, @y, 0, 0, 0.50, 0.50, 0.40, 0.40)
    when :right
      @blaster_frames[@current_frame].draw_rot(@x, @y, 0, 180, 0.50, 0.50, 0.40, 0.40)
    end
  end

end
