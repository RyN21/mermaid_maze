class Mermaid
  TILE_SIZE      = Config::CELL_SIZE
  # MERMAID_WIDTH  = 39
  # MERMAID_HEIGHT = 29
  FRAME_WIDTH    =
  FRAME_HEIGHT   =
  MOVE_SPEED     = 2
  def initialize maze, mermaid_row
    @maze          = maze
    @spritez_sheet = Gosu::Image.load_tiles("assets/images/mermaid/mermaid_sprite_sheet.png",
                                          FRAME_WIDTH, FRAME_HEIGHT, retro: true)
    @row           = mermaid_row
    @current_frame   = 0
    @direction     = :idle
    place_on_path
  end

  def update
    case @direction
    when :up
      @y -= 2
      animate(6, 8)
    when :down
      @y += 2
      animate(0, 2)
    when :left, :right
      @x += (@direction == :left ? -2 : 2)
      animate(3, 5)
    else
      @current_frame = 9 # Idle
  end

  def animate(start_frame, end_frame)
    @current_frame = start_frame + (Gosu.milliseconds / 100 % 3)
  end
end



#
# def update
#   if Gosu.button_down? Gosu::KB_LEFT
#     move_left
#   end
#   if Gosu.button_down? Gosu::KB_RIGHT
#     move_right
#   end
#   if Gosu.button_down? Gosu::KB_UP
#     move_up
#   end
#   if Gosu.button_down? Gosu::KB_DOWN
#     move_down
#   end
# end
