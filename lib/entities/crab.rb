# MY CODE
class Crab
  TILE_SIZE      = Config::CELL_SIZE
  CRAB_WIDTH   = 64
  CRAB_HEIGHT  = 64
  def initialize maze
    @maze              = maze
    @crab_scale        = 0.50
    @x                 = 0
    @y                 = 0
    @x_center          = @x + CRAB_WIDTH * @crab_scale
    @y_center          = @y + CRAB_HEIGHT * @crab_scale
    @speed             = 3
    @crab_frames       = Gosu::Image.load_tiles("assets/images/crab/crab_sprite.png", 64, 64, retro: true)
    @animation_frames  = {
      up: [@crab_frames[0], @crab_frames[1]],
      down: [@crab_frames[2], @crab_frames[3]],
      left: [@crab_frames[4], @crab_frames[5]],
      right: [@crab_frames[6], @crab_frames[7]]
    }
    @current_frame     = 0
    @frame_delay       = 4
    @frame_counter     = 0
    @directions        = [:up, :down, :left, :right]
    @current_direction = :down
    # @path_memory       = []
    # @stuck_counter     = 0
    place_on_path
  end

  def update
    move
    update_animation
  end

  def draw
    frames = @animation_frames[@current_direction]
    frames[@current_frame].draw(@x, @y, 0, @crab_scale, @crab_scale)
  end

  def move
    case @current_direction
    when :up
      move_up
    when :down
      move_down
    when :left
      move_left
    when :right
      move_right
    end
  end

  def move_left
    if is_valid_move(@x - @speed - 25, @y)
      @x -= @speed
    else
      change_direction(:left)
    end
  end

  def move_right
    if is_valid_move(@x + @speed - 5, @y)
      @x += @speed
    else
      change_direction(:right)
    end
  end

  def move_up
    if is_valid_move(@x, @y - @speed - 10)
      @y -= @speed
    else
      change_direction(:up)
    end
  end

  def move_down
    if is_valid_move(@x, @y + @speed + 10)
      @y += @speed
    else
      change_direction(:down)
    end
  end

  def change_direction(current_direction)
    index = rand(0..2)
    @directions.push(@directions.delete_at(@directions.index(current_direction)))
    @current_direction = @directions[index]
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
    grid_y = (new_y + CRAB_HEIGHT / 2 * @crab_scale) / TILE_SIZE
    @maze.is_path?(grid_x, grid_y)
  end
end












# AI CODE
#
# class Crab
#   TILE_SIZE    = Config::CELL_SIZE
#   CRAB_WIDTH   = 64
#   CRAB_HEIGHT  = 64
#   CRAB_SCALE   = 0.50
#
#   def initialize(maze)
#     @maze             = maze
#     @speed            = 2.5
#     @crab_frames      = Gosu::Image.load_tiles("assets/images/crab/crab_sprite.png", 64, 64, retro: true)
#     @animation_frames = {
#       up:    [@crab_frames[0], @crab_frames[1]],
#       down:  [@crab_frames[2], @crab_frames[3]],
#       left:  [@crab_frames[4], @crab_frames[5]],
#       right: [@crab_frames[6], @crab_frames[7]]
#     }
#     @directions        = [:up, :down, :left, :right]
#     @current_direction = @directions.sample
#     @current_frame     = 0
#     @frame_delay       = 4
#     @frame_counter     = 0
#
#     @path_memory      = []
#     @stuck_counter    = 0
#     @position_counter = 0
#
#     place_on_path
#   end
#
#   def update
#     move
#     update_animation
#   end
#
#   def draw
#     frames = @animation_frames[@current_direction]
#     frames[@current_frame].draw(@x, @y, 0, CRAB_SCALE, CRAB_SCALE)
#   end
#
#   private
#
#   def move
#     # Use a wider "turn zone" to allow for turns at intersections
#     if at_tile_center?(12) && at_intersection?
#       choose_new_direction_at_intersection
#     end
#
#     if can_continue_moving?
#       move_forward
#       @stuck_counter = 0
#     else
#       @stuck_counter += 1
#       choose_new_direction
#     end
#
#     avoid_loops
#     record_position
#   end
#
#   def at_tile_center?(threshold = 20)
#     crab_center_x = @x + CRAB_WIDTH * CRAB_SCALE / 2
#     crab_center_y = @y + CRAB_HEIGHT * CRAB_SCALE / 2
#     center_x = ((crab_center_x) / TILE_SIZE).round * TILE_SIZE + TILE_SIZE / 2
#     center_y = ((crab_center_y) / TILE_SIZE).round * TILE_SIZE + TILE_SIZE / 2
#     (crab_center_x - center_x).abs < threshold && (crab_center_y - center_y).abs < threshold
#   end
#
#   def current_tile
#     [
#       ((@x + CRAB_WIDTH * CRAB_SCALE / 2) / TILE_SIZE).round,
#       ((@y + CRAB_HEIGHT * CRAB_SCALE / 2) / TILE_SIZE).round
#     ]
#   end
#
#   def at_intersection?
#     tile_x, tile_y = current_tile
#     case @current_direction
#     when :left, :right
#       up    = @maze.is_path?(tile_x, tile_y - 1)
#       down  = @maze.is_path?(tile_x, tile_y + 1)
#       up || down
#     when :up, :down
#       left  = @maze.is_path?(tile_x - 1, tile_y)
#       right = @maze.is_path?(tile_x + 1, tile_y)
#       left || right
#     end
#   end
#
#   def choose_new_direction_at_intersection
#     tile_x, tile_y = current_tile
#     perpendicular_dirs = case @current_direction
#     when :left, :right then [:up, :down]
#     when :up, :down    then [:left, :right]
#     end
#
#     possible_turns = []
#     perpendicular_dirs.each do |dir|
#       case dir
#       when :up    then possible_turns << :up    if @maze.is_path?(tile_x, tile_y - 1)
#       when :down  then possible_turns << :down  if @maze.is_path?(tile_x, tile_y + 1)
#       when :left  then possible_turns << :left  if @maze.is_path?(tile_x - 1, tile_y)
#       when :right then possible_turns << :right if @maze.is_path?(tile_x + 1, tile_y)
#       end
#     end
#
#     # 30% chance to take a turn at intersection
#     if possible_turns.any? && rand < 0.3
#       @current_direction = possible_turns.sample
#     end
#   end
#
#   def can_continue_moving?
#     case @current_direction
#     when :left
#       valid_move?(@x - @speed, @y)
#     when :right
#       valid_move?(@x + @speed + CRAB_WIDTH * CRAB_SCALE, @y)
#     when :up
#       valid_move?(@x, @y - @speed)
#     when :down
#       valid_move?(@x, @y + @speed + CRAB_HEIGHT * CRAB_SCALE)
#     end
#   end
#
#   def move_forward
#     case @current_direction
#     when :left
#       @x -= @speed
#     when :right
#       @x += @speed
#     when :up
#       @y -= @speed
#     when :down
#       @y += @speed
#     end
#   end
#
#   def choose_new_direction
#     possible_dirs = @directions.reject { |dir| opposite_direction?(dir) }
#     .select { |dir| valid_direction?(dir) }
#
#     @current_direction =
#     if possible_dirs.empty?
#       opposite_direction
#     elsif possible_dirs.size == 1
#       possible_dirs.first
#     else
#       rand <= 0.7 ? similar_direction(possible_dirs) : possible_dirs.sample
#     end
#   end
#
#   def similar_direction(possible_dirs)
#     case @current_direction
#     when :left, :right
#       (possible_dirs & [:left, :right]).sample || possible_dirs.sample
#     when :up, :down
#       (possible_dirs & [:up, :down]).sample || possible_dirs.sample
#     else
#       possible_dirs.sample
#     end
#   end
#
#   def valid_direction?(direction)
#     case direction
#     when :left
#       valid_move?(@x - @speed, @y)
#     when :right
#       valid_move?(@x + @speed + CRAB_WIDTH * CRAB_SCALE, @y)
#     when :up
#       valid_move?(@x, @y - @speed)
#     when :down
#       valid_move?(@x, @y + @speed + CRAB_HEIGHT * CRAB_SCALE)
#     end
#   end
#
#   def valid_move?(x, y)
#     # Check 3 points across the crab's leading edge for collision
#     case @current_direction
#     when :left, :right
#       [0, CRAB_HEIGHT * CRAB_SCALE / 2, CRAB_HEIGHT * CRAB_SCALE - 1].all? do |offset|
#         tile_walkable?(x, @y + offset)
#       end
#     when :up, :down
#       [0, CRAB_WIDTH * CRAB_SCALE / 2, CRAB_WIDTH * CRAB_SCALE - 1].all? do |offset|
#         tile_walkable?(@x + offset, y)
#       end
#     end
#   end
#
#   def tile_walkable?(x, y)
#     grid_x = (x / TILE_SIZE).to_i
#     grid_y = (y / TILE_SIZE).to_i
#     @maze.is_path?(grid_x, grid_y)
#   end
#
#   def opposite_direction?(dir)
#     {
#       left: :right,
#       right: :left,
#       up: :down,
#       down: :up
#       }[dir] == @current_direction
#     end
#
#     def opposite_direction
#       {
#         left: :right,
#         right: :left,
#         up: :down,
#         down: :up
#         }[@current_direction]
#       end
#
#       def avoid_loops
#         if @path_memory.size > 10
#           @path_memory.shift
#           @path_memory << [@x.to_i, @y.to_i]
#         end
#
#         if @path_memory.uniq.size < 3 && @stuck_counter > 5
#           choose_new_direction
#           @path_memory.clear
#           @stuck_counter = 0
#         end
#       end
#
#       def record_position
#         @position_counter += 1
#         if @position_counter >= 15
#           @path_memory << [@x.to_i, @y.to_i]
#           @position_counter = 0
#         end
#       end
#
#       def update_animation
#         @frame_counter += 1
#         if @frame_counter >= @frame_delay
#           @current_frame = (@current_frame + 1) % 2
#           @frame_counter = 0
#         end
#       end
#
#       def place_on_path
#         walkable_tiles = []
#         @maze.grid.each_with_index do |row, y|
#           row.each_with_index do |cell, x|
#             walkable_tiles << [x, y] if cell.tile_path
#           end
#         end
#         tile = walkable_tiles.sample
#         @x = tile[0] * TILE_SIZE + TILE_SIZE / 4
#         @y = tile[1] * TILE_SIZE + TILE_SIZE / 4
#       end
#     end
#
#
