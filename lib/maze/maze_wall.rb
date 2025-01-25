class MazeWall
  def initialize(window, x, y, width, height)
    @body = CP::Body.new_static()
    @body.p = CP::Vec2.new(x + width/2. y + height/2)
    @shape = CP::Shape::Boc.new(@body, width, height)
    @shape.collision_type = :wall
    window.space.add_shape(@shape)
  end
end


#
#
#
# class Maze
#   attr_reader :space
#
#   def initialize(window)
#     @window = window
#     @space = CP::Space.new
#     @space.damping = 0.8
#     create_walls
#   end
#
#   def create_walls
#     @grid.each_with_index do |row, y|
#       row.each_with_index do |cell, x|
#         unless cell.tile_path
#           MazeWall.new(@window, x * CELL_SIZE, y * CELL_SIZE, CELL_SIZE, CELL_SIZE)
#         end
#       end
#     end
#   end
# end
#
# class Mermaid
#   MASS = 1
#   def initialize(maze, x, y)
#     @maze = maze
#     @body = CP::Body.new(MASS, CP::moment_for_circle(MASS, 0, 25, CP::Vec2.new(0, 0)))
#     @body.p = CP::Vec2.new(x, y)
#     @shape = CP::Shape::Circle.new(@body, 25, CP::Vec2.new(0, 0))
#     @shape.collision_type = :mermaid
#     maze.space.add_body(@body)
#     maze.space.add_shape(@shape)
#   end
#
#   def update
#     # Apply forces based on input
#     @body.apply_force(CP::Vec2.new(-MOVE_SPEED, 0)) if Gosu.button_down? Gosu::KB_LEFT
#     @body.apply_force(CP::Vec2.new(MOVE_SPEED, 0)) if Gosu.button_down? Gosu::KB_RIGHT
#     @body.apply_force(CP::Vec2.new(0, -MOVE_SPEED)) if Gosu.button_down? Gosu::KB_UP
#     @body.apply_force(CP::Vec2.new(0, MOVE_SPEED)) if Gosu.button_down? Gosu::KB_DOWN
#
#     @x = @body.p.x
#     @y = @body.p.y
#     update_animation
#   end
# end
#
#
# class GameWindow < Gosu::Window
#   def update
#     @maze.space.step(1.0/60.0)
#     @mermaid.update
#     @fox.update
#   end
# end
