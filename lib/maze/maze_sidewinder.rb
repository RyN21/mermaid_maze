require_relative "cell_sidewinder"

class MazeSidewinder
  TILE_SIZE = Config::CELL_SIZE

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    # @tile_images = load_tile_images
    @grid = Array.new(rows) { |row| Array.new(cols) { |col| CellSidewinder.new(row, col, rows, cols) } }
    generate_maze
    update_all_tiles
  end



  def generate_maze
    @grid.each_with_index do |row, row_index|
      next if row_index == 0 || row_index == @rows - 1 || row_index.even?
      row.each_with_index do |_, col_index|
        next if col_index == 0 || col_index == @cols - 1 || col_index.even?
        if rand < 0.5
          carve_horizontally(row_index, col_index)
        else
          carve_vertically(row_index, col_index)
        end
      end
    end
  end



  def carve_horizontally(row, col)
    return if col >= @cols - 2
    @grid[row][col].tile_path = true
    @grid[row][col + 1].tile_path = true
  end



  def carve_vertically(row, col)
    return if row >= @rows - 2
    @grid[row][col].tile_path = true
    @grid[row + 1][col].tile_path = true
  end



  def draw(cell_size)
    @grid.each do |row|
      row.each do |cell|
        if !cell.tile_path
          x = cell.col * cell_size
          y = cell.row * cell_size
          cell.draw x, y, cell_size
        end
      end
    end
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


  # Connect isolated mazes
end
