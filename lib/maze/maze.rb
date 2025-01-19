require_relative "cell"

class Maze
  attr_reader :grid

  def initialize rows, cols
      @rows  = rows
      @cols  = cols

      @grid  = Array.new(rows) { |row| Array.new(cols) { |col| Cell.new(row, col) } }
      generate_maze
  end


  def generate_maze
    # Choose starting path cell
    start_cell = @grid[2][2]
    start_cell.path_tile = true
    # Add all neighbors of the starting cell
    wall_list = []
    add_neighbors_to_wall_list(start_cell, wall_list)
    # Process walls until no walls remain in the list
    while wall_list.any?
      current_wall = wall_list.sample
      process_wall(current_wall, wall_list)
    end
    # Update all tiles after maze generation
    update_all_tiles
  end


  def random_cell
    row = rand(@rows)
    col = rand(@cols)
    @grid[row][col]
  end


  def add_neighbors_to_wall_list(cell, wall_list)
    neighbors(cell).each do |neighbor|
      unless neighbor.path_tile || wall_list.include?([cell, neighbor])
        wall_list << [cell, neighbor] # Add wall between cell and neighbpr
      end
    end
  end


  def process_wall(wall, wall_list)
    wall_list.reject! do |wall_pair|
      wall_pair[0].path_tile && wall_pair[0] != wall[1]
    end

    cell1, cell2 = wall
    new_cell = nil
    if cell1.path_tile ^ cell2.path_tile
      carve_path_between(cell1, cell2)
      # Mark the unvisited cell as part of the path
      new_cell = cell1.path_tile ? cell2 : cell1
      new_cell.path_tile = true
      # Add neighbors of the newly visited cell to wall list
      add_neighbors_to_wall_list(new_cell, wall_list)
    end
    # Remove this wall from the list after processing it

    wall_list.delete(wall)
  end


  def carve_path_between(cell1, cell2)
    if !cell1.path_tile || !cell2.path_tile
      cell1.path_tile = true
      cell2.path_tile = true
    end
  end


  def neighbors(cell)
    row = cell.row
    col = cell.col
    {
      north: (row > 1 ? @grid[row - 1][col] : nil),
      south: (row < @rows - 2 ? @grid[row + 1][col] : nil),
      west: (col > 1 ? @grid[row][col - 1] : nil),
      east: (col < @cols - 2 ? @grid[row][col + 1] : nil)
    }.compact.values
  end


  def update_all_tiles
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        neighbors = {
          north: (row_index > 0 ? @grid[row_index - 1][col_index] : nil),
          south: (row_index < @rows.size - 1 ? @grid[row_index + 1][col_index] : nil),
          west:  (col_index > 0 ? @grid[row_index][col_index - 1] : nil),
          east:  (col_index < @cols.size - 1 ? @grid[row_index][col_index + 1] : nil)
        }
        cell.update_tile(neighbors)
      end
    end
  end


  def draw(cell_size)
    @grid.each do |row|
      row.each do |cell|
        if !cell.path_tile
          x = cell.col * cell_size
          y = cell.row * cell_size
          cell.draw x, y, cell_size
        end
      end
    end
  end
end
