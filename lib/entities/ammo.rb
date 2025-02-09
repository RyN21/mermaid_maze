class Ammo
  AMMO_SHEET_WIDTH  = 591
  AMMO_SHEET_HEIGHT = 60

  attr_reader :x, :y, :width, :height, :blaster_frames, :current_frame, :ammo_scale

  def initialize x, y, direction
    @x                 = x
    @y                 = y
    @width             = 98
    @height            = 60
    @direction         = direction
    @speed             = 5
    @blaster_frames    = Gosu::Image.load_tiles("assets/images/blaster_1.png", 98, 60, retro: true)
    @current_frame     = 0
    @frame_delay       = 100
    @last_frame_change = Gosu.milliseconds
    @rotation          = 0
    @ammo_scale        = 0.40
    @state             = :active
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
      @blaster_frames[@current_frame].draw_rot(@x, @y, 0, 90, 0.50, 0.50, @ammo_scale, @ammo_scale)
    when :down
      @blaster_frames[@current_frame].draw_rot(@x, @y, 0, -90, 0.50, 0.50, @ammo_scale, @ammo_scale)
    when :left
      @blaster_frames[@current_frame].draw_rot(@x, @y, 0, 0, 0.50, 0.50, @ammo_scale, @ammo_scale)
    when :right
      @blaster_frames[@current_frame].draw_rot(@x, @y, 0, 180, 0.50, 0.50, @ammo_scale, @ammo_scale)
    end
  end
end
