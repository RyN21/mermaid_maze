require_relative "../effects/pop"
require "./lib/entities/ammo"


class Mermaid
  TILE_SIZE      = Config::CELL_SIZE
  MERMAID_WIDTH  = 47
  MERMAID_HEIGHT = 64
  MOVE_SPEED     = 3.5
  CHRACTERS_LIST = [:blue, :pink, :purple, :green]
  attr_reader :direction, :score

  def initialize maze, character
    @maze            = maze
    @character       = Config::MERMAIDS[CHRACTERS_LIST[character]]
    @blaster_sound   = Gosu::Sample.new("assets/sounds/blaster.mp3")
    @up_frames       = @character[:up]
    @down_frames     = @character[:down]
    @left_frames     = @character[:left]
    @right_frames    = @character[:right]
    @current_frame   = 0
    @frame_delay     = 7
    @frame_counter   = 0
    @x               = 0
    @y               = 0
    @direction       = :down
    @mermaid_scale   = 0.75
    @ammo_count      = 1000
    @ammo_inventory  = []
    @score           = 0
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

    @ammo_inventory.reject! { |ammo| ammo.dead?}
  end


  def move_left
    @direction = :left
    if is_valid_move(@x - MOVE_SPEED - 12, @y + 15)
      update_animation
      @x -= MOVE_SPEED
    end
  end
  def move_right
    @direction = :right
    if is_valid_move(@x + MOVE_SPEED, @y + 15)
      update_animation
      @x += MOVE_SPEED
    end
  end
  def move_up
    @direction = :up
    if is_valid_move(@x - 10, @y - MOVE_SPEED - 7)
      update_animation
      @y -= MOVE_SPEED
    end
  end
  def move_down
    @direction = :down
    if is_valid_move(@x - 10, @y + MOVE_SPEED + 20)
      update_animation
      @y += MOVE_SPEED
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

  def shoot
    if @ammo_count > 0
      @ammo_inventory << Ammo.new(@x + MERMAID_WIDTH / 2 * @mermaid_scale + 8, @y + MERMAID_HEIGHT / 2 * @mermaid_scale + 5, @direction)
      @ammo_count -= 1
      @blaster_sound.play(volume = 0.10)
    end
  end

  def update_ammo
    @ammo_inventory.each(&:update)
    ammo_hits_wall
  end

  def ammo_hits_bubble(bubbles)
    @ammo_inventory.each do |ammo|
      frames = ammo.blaster_frames
      scale = ammo.ammo_scale
      x = ammo.x + frames[ammo.current_frame].width/2 * scale
      y = ammo.y + frames[ammo.current_frame].height/2 * scale
      bubbles.each do |bubble|
        if Gosu.distance(x,
                         y,
                         bubble.x + bubble.frames[bubble.current_frame].width / 2 * bubble.bubble_scale + 10,
                         bubble.y + bubble.frames[bubble.current_frame].height / 2 * bubble.bubble_scale) < 22
          bubble.pop unless bubble.popping? || bubble.popped?
          @ammo_inventory.delete(ammo)
        end
      end
    end
  end

  def draw_ammo
    @ammo_inventory.each(&:draw)
  end

  def ammo_hits_wall
    @ammo_inventory.each do |ammo|
      if ammo_valid_move(ammo.x - 37, ammo.y - 10, ammo.direction) == false
        ammo.explode unless ammo.exploding? || ammo.dead?
      end
    end
  end


  private


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

  def ammo_valid_move(new_x, new_y, direction)
    case direction
    when :left
      grid_x = (new_x + 60 * 0.40) / TILE_SIZE
      grid_y = (new_y + 50 / 2 * 0.40) / TILE_SIZE
    when :right
      grid_x = (new_x + 120 * 0.40) / TILE_SIZE
      grid_y = (new_y + 50 / 2 * 0.40) / TILE_SIZE
    when :up
      grid_x = (new_x + 120 * 0.40) / TILE_SIZE
      grid_y = (new_y + 50 / 2 * 0.40) / TILE_SIZE
    when :down
      grid_x = (new_x + 120 * 0.40) / TILE_SIZE
      grid_y = (new_y + 100 / 2 * 0.40) / TILE_SIZE
    end
    # grid_x = (new_x + 90 * 0.40) / TILE_SIZE
    @maze.is_path?(grid_x, grid_y)
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
