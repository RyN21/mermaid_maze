class Fox
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
    @x -= 2
    @direction = @fox_scale
  end
  def move_right
    update_animation
    @x += 2
    @direction = -@fox_scale
    @x - @frames[@current_frame].width
  end
  def move_up
    update_animation
    @y -= 2
  end
  def move_down
    update_animation
    @y += 2
  end



  def draw
    x = @direction == @fox_scale ? @fox_scale : -@fox_scale
    adjusted_x = x == -@fox_scale ? @x + @frames[@current_frame].width : @x

    @frames[@current_frame].draw adjusted_x, @y, 0, x, @fox_scale
  end



  private



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
end





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
