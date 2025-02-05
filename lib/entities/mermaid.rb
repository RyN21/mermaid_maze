require_relative "../effects/pop"


class Mermaid
  TILE_SIZE      = Config::CELL_SIZE
  MERMAID_WIDTH  = 60
  MERMAID_HEIGHT = 83
  MOVE_SPEED     = 3
  CHRACTERS_LIST = [:blue, :pink, :purple, :green]
  def initialize maze, character
    @maze         = maze
    @character    = Config::MERMAIDS[CHRACTERS_LIST[character]]
    @up_frames    = @character[:up]
    @down_frames  = @character[:down]
    @left_frames  = @character[:left]
    @right_frames = @character[:right]

    @current_frame   = 0
    @frame_delay     = 7
    @frame_counter   = 0
    @x               = 0
    @y               = 0
    @direction       = :down
    @mermaid_scale   = 0.75

    place_on_path
  end


  def update_animation
    @frame_counter += 1
    if @frame_counter >= @frame_delay
      frames = case @direction
               when :up then @up_frames
               when :down then @down_frames
               when :left then @left_frames
               when :right then @right_frames
               end
      @current_frame = (@current_frame + 1) % frames.size
      @frame_counter = 0
    end
  end


  def update
    move_left if Gosu.button_down? Gosu::KB_LEFT
    move_right if Gosu.button_down? Gosu::KB_RIGHT
    move_up if Gosu.button_down? Gosu::KB_UP
    move_down if Gosu.button_down? Gosu::KB_DOWN
  end


  def move_left
    if is_valid_move(@x - MOVE_SPEED - 12, @y)
      update_animation
      @x -= MOVE_SPEED
      @direction = :left
    end
  end
  def move_right
    if is_valid_move(@x + MOVE_SPEED, @y)
      update_animation
      @x += MOVE_SPEED
      @direction = :right
    end
  end
  def move_up
    if is_valid_move(@x, @y - MOVE_SPEED - 7)
      update_animation
      @y -= MOVE_SPEED
      @direction = :up
    end
  end
  def move_down
    if is_valid_move(@x, @y + MOVE_SPEED + 20)
      update_animation
      @y += MOVE_SPEED
      @direction = :down
    end
  end


  def draw
    if @direction == :left
      @left_frames[@current_frame].draw(@x + 8, @y + 5, 0, @mermaid_scale, @mermaid_scale)
    end
    if @direction == :right
      @right_frames[@current_frame].draw(@x + 8, @y + 5, 0, @mermaid_scale, @mermaid_scale)
    end
    if @direction == :up
      @up_frames[@current_frame].draw(@x + 8, @y + 5, 0, @mermaid_scale, @mermaid_scale)
    end
    if @direction == :down
      @down_frames[@current_frame].draw(@x + 8, @y + 5, 0, @mermaid_scale, @mermaid_scale)
    end
    # draw_border(@x + 10, @y + 8, MERMAID_WIDTH * @mermaid_scale, MERMAID_HEIGHT * @mermaid_scale)
  end


  def collects_bubbles(bubbles)
    frames = case @direction
             when :up then @up_frames
             when :down then @down_frames
             when :left then @left_frames
             when :right then @right_frames
             end

    bubbles.each do |bubble|
      if Gosu.distance(@x + frames[@current_frame].width/2 * @mermaid_scale,
                       @y + frames[@current_frame].height/2 * @mermaid_scale,
                       bubble.x, bubble.y - 10) < 30
        bubble.pop unless bubble.popping? || bubble.popped?
      end
    end
  end


  def place_on_path
    @maze.grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        if cell.tile_path
          @x = x + 50
          @y = y + 45
          return
        end
      end
    end
  end


  private



  def draw_border(x, y, w, h)
    Gosu.draw_line(x, y, Gosu::Color::RED, x + w, y, Gosu::Color::RED, 1) #top border
    Gosu.draw_line(x + w, y, Gosu::Color::RED, x + w, y + h, Gosu::Color::RED, 1) #right border
    Gosu.draw_line(x + w, y + h, Gosu::Color::RED, x, y + h, Gosu::Color::RED, 1) #bottom border
    Gosu.draw_line(x, y + h, Gosu::Color::RED, x, y, Gosu::Color::RED, 1) #left border
  end




  def is_valid_move(new_x, new_y)
    grid_x = (new_x + MERMAID_WIDTH * @mermaid_scale) / TILE_SIZE
    grid_y = (new_y + MERMAID_HEIGHT / 2 * @mermaid_scale) / TILE_SIZE
    @maze.is_path?(grid_x, grid_y)
  end
end
