class Crab
  SHEET_WIDTH  = 256
  SHEET_HEIGHT = 128
  CRAB_WIDTH   = 64
  CRAB_HEIGHT  = 64
  def initialize maze
    @maze              = maze
    @x                 = 0
    @y                 = 0
    @speed             = 3
    @crab_frames       = Gosu::Image.load_tiles("assets/images/crab/crab_sprite.png", 64, 64, retro: true)
    @up_frames         = [@crab_frames[0], @crab_frames[1]]
    @down_frames       = [@crab_frames[2], @crab_frames[3]]
    @left_frames       = [@crab_frames[4], @crab_frames[5]]
    @right_frames      = [@crab_frames[6], @crab_frames[7]]
    @current_frame     = 0
    @frame_delay       = 4
    @frame_counter     = 0
    @current_direction = :up
    @crab_scale        = 0.75
    place_on_path
  end

  def update
    move
  end

  def draw
    case @current_direction
    when :up
      @up_frames[@current_frame].draw(@x, @y, 0, @crab_scale, @crab_scale)
    when :down
      @down_frames[@current_frame].draw(@x, @y, 0, @crab_scale, @crab_scale)
    when :left
      @left_frames[@current_frame].draw(@x, @y, 0, @crab_scale, @crab_scale)
    when :right
      @right_frames[@current_frame].draw(@x, @y, 0, @crab_scale, @crab_scale)
    end
  end

  def move
    case @current_direction
    when :up
      move_up
    when :down
      @y += @speed
    when :left
      @x -= @speed
    when :right
      @x += @speed
    end
  end

  def move_left
    @current_direction = :left
    if is_valid_move(@x - @speed, @y)
      update_animation
      @x -= @speed
    end
  end
  def move_right
    @current_direction = :right
    if is_valid_move(@x + @speed, @y)
      update_animation
      @x -= @speed
    end
  end
  def move_up
    @current_direction = :up
    if is_valid_move(@x, @y - @speed)
      update_animation
      @x -= @speed
    end
  end
  def move_down
    @current_direction = :down
    if is_valid_move(@x, @y + @speed)
      update_animation
      @x -= @speed
    end
  end

  def update_animation
    @frame_counter += 1
    if @frame_counter >= @frame_delay
      frames = case @current_direction
               when :up
                 [@crab_frames[0], @crab_frames[1]]
               when :down then
                 [@crab_frames[2], @crab_frames[3]]
               when :left then
                 [@crab_frames[4], @crab_frames[5]]
               when :right then
                 [@crab_frames[6], @crab_frames[7]]
               end
      @current_frame = (@current_frame + 1) % frames.size
      @frame_counter = 0
    end
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

  def is_valid_move(new_x, new_y)
    grid_x = (new_x + CRAB_WIDTH * @crab_scale) / TILE_SIZE
    grid_y = (new_y + CRAB_HEIGHT * @crab_scale) / TILE_SIZE
    @maze.is_path?(grid_x, grid_y)
  end
end
