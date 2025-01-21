class Fox
  TILE_SIZE  = Config::CELL_SIZE
  FOX_WIDTH  = 39
  FOX_HEIGHT = 29
  MOVE_SPEED = 2
  def initialize maze
    @maze          = maze
    @frames        = [
      Gosu::Image.new("assets/images/fox/Fox_run1.png"),
      Gosu::Image.new("assets/images/fox/Fox_run2.png"),
      Gosu::Image.new("assets/images/fox/Fox_run3.png")
    ]
    @current_frame = 0
    @frame_delay   = 5
    @frame_counter = 0
    @x             = 0
    @y             = 0
    @direction     = -1
    @fox_scale     = 1
    place_on_path
  end



  def update_animation
    @frame_counter += 1

    if @frame_counter >= @frame_delay
      @current_frame = ( @current_frame + 1 ) % @frames.size
      @frame_counter = 0
    end
  end



  def update
    if Gosu.button_down? Gosu::KB_LEFT
      move_left
    end
    if Gosu.button_down? Gosu::KB_RIGHT
      move_right
    end
    if Gosu.button_down? Gosu::KB_UP
      move_up
    end
    if Gosu.button_down? Gosu::KB_DOWN
      move_down
    end
  end



  def move_left
    update_animation
    if is_valid_move?(@x - MOVE_SPEED , @y)
      @x -= MOVE_SPEED
      @direction = @fox_scale
    end
  end
  def move_right
    update_animation
    if is_valid_move?(@x + MOVE_SPEED, @y)
      @x += MOVE_SPEED
      @direction = -@fox_scale
      @x - @frames[@current_frame].width
    end
  end
  def move_up
    if is_valid_move?(@x, @y - MOVE_SPEED)
      update_animation
      @y -= MOVE_SPEED
    end
  end
  def move_down
    if is_valid_move?(@x, @y + MOVE_SPEED)
      update_animation
      @y += MOVE_SPEED
    end
  end



  def draw
    x = @direction == @fox_scale ? @fox_scale : -@fox_scale
    adjusted_x = x == -@fox_scale ? @x + @frames[@current_frame].width : @x

    @frames[@current_frame].draw adjusted_x, @y, 0, x, @fox_scale
    draw_border(@x + 10, @y + 17, FOX_WIDTH, FOX_HEIGHT)
  end



  private



  def draw_border(x, y, w, h)
    Gosu.draw_line(x, y, Gosu::Color::RED, x + w, y, Gosu::Color::RED, 1) #top border
    Gosu.draw_line(x + w, y, Gosu::Color::RED, x + w, y + h, Gosu::Color::RED, 1) #right border
    Gosu.draw_line(x + w, y + h, Gosu::Color::RED, x, y + h, Gosu::Color::RED, 1) #bottom border
    Gosu.draw_line(x, y + h, Gosu::Color::RED, x, y, Gosu::Color::RED, 1) #left border
  end



  def place_on_path
    @maze.grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        if cell.tile_path
          @x = x + 45
          @y = y + 45
          return
        end
      end
    end
  end



  # def is_valid_move?(new_x, new_y)
  #   grid_x = x #/ Config::CELL_SIZE
  #   grid_y = y #/ Config::CELL_SIZE
  #   @maze.is_path?(grid_x, grid_y)
  # end

  def is_valid_move?(new_x, new_y)
    # Check all four corners of the fox's hitbox
    [
      [new_x + 10, new_y + 17],
      [new_x + 10 + FOX_WIDTH - 5, new_y + 17],
      [new_x + 10, new_y + 17 + FOX_HEIGHT - 5],
      [new_x + 10 + FOX_WIDTH - 5, new_y + 17 + FOX_HEIGHT - 5]
    ].all? do |corner_x, corner_y|
      grid_x = corner_x / TILE_SIZE
      grid_y = corner_y / TILE_SIZE
      @maze.is_path?(grid_x, grid_y)
    end
  end
end
# @fox_border = draw_border(@x + 10, @y + 17, FOX_WIDTH, FOX_HEIGHT)





#### THIS WAY PREVENTS FOX FROM MOVING DIAGONALLY
# def update
#   direction = nil
#
#   if Gosu.button_down? Gosu::KB_LEFT
#     direction = :left
#   elsif Gosu.button_down? Gosu::KB_RIGHT
#     direction = :right
#   elsif Gosu.button_down? Gosu::KB_UP
#     direction = :up
#   elsif Gosu.button_down? Gosu::KB_DOWN
#     direction = :down
#   end
#   move direction if direction
# end
#
#
# def move direction
#   return unless direction
#   case direction
#   when :left
#     update_animation
#     @x -= 4
#     @direction = @fox_scale
#   when :right
#     update_animation
#     @x += 4
#     @direction = -@fox_scale
#     @x - @frames[@current_frame].width
#   when :up
#     update_animation
#     @y -= 4
#   when :down
#     update_animation
#     @y += 4
#   end
# end
